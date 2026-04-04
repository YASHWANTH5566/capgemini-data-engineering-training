# Phase 3 – Final ETL Pipeline

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, count

# Initialize Spark
spark = SparkSession.builder.appName("Phase3_ETL").getOrCreate()

# EXTRACT (Read Data)

customers = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/customers.csv")

sales = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/sales.csv")

# Inspect schema
customers.printSchema()
sales.printSchema()

# TRANSFORM (Cleaning)

# Clean customers
customers_clean = customers.dropna(subset=["customer_id"]) \
    .fillna({
        "first_name": "Unknown",
        "last_name": "Unknown",
        "city": "Unknown"
    }).dropDuplicates()

# Clean sales
sales_clean = sales.dropna(subset=["customer_id"]) \
    .dropDuplicates() \
    .withColumn("total_amount", col("total_amount").cast("double")) \
    .filter(col("total_amount") > 0)

# BUSINESS TASK 1: Daily Sales

daily_sales = sales_clean.groupBy("sale_date").agg(sum("total_amount").alias("daily_revenue"))

# BUSINESS TASK 2: City-wise Revenue

city_revenue = customers_clean.join(sales_clean, "customer_id").groupBy("city").agg(sum("total_amount").alias("city_revenue"))

# BUSINESS TASK 3: Repeat Customers (>2 orders)

repeat_customers = sales_clean.groupBy("customer_id").agg(count("sale_id").alias("order_count")).filter(col("order_count") > 2)

# BUSINESS TASK 4: Highest Spending Customer per City

customer_spend = customers_clean.join(sales_clean, "customer_id").groupBy("customer_id", "city").agg(sum("total_amount").alias("total_spend"))

from pyspark.sql.window import Window
from pyspark.sql.functions import row_number

windowSpec = Window.partitionBy("city").orderBy(col("total_spend").desc())

top_customers = customer_spend.withColumn("rank", row_number().over(windowSpec)).filter(col("rank") == 1)

# BUSINESS TASK 5: Final Reporting Table

final_report = customers_clean.join(sales_clean, "customer_id").groupBy("customer_id", "city") \
    .agg(
        sum("total_amount").alias("total_spend"),
        count("sale_id").alias("order_count")
    )

# LOAD (Show Results)

print("===== Daily Sales =====")
daily_sales.show()

print("===== City Revenue =====")
city_revenue.show()

print("===== Repeat Customers =====")
repeat_customers.show()

print("===== Top Customers Per City =====")
top_customers.show()

print("===== Final Report =====")
final_report.show()