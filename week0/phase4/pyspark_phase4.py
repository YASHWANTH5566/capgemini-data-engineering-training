# Phase 4 – Mini Project: Business Pipeline
import pandas as pd
from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, count, when, desc

# Initialize Spark
spark = SparkSession.builder.appName("Phase4Pipeline").getOrCreate()

# 1. Extract (Load Data)

customers = spark.read.format("csv") \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .load("/samples/customers.csv")

sales = spark.read.format("csv") \
    .option("header", "true") \
    .option("inferSchema", "true") \
    .load("/samples/sales.csv")

# 2. Data Cleaning

# Remove null keys
customers_clean = customers.dropna(subset=["customer_id"])
sales_clean = sales.dropna(subset=["customer_id"])

# Remove duplicates
customers_clean = customers_clean.dropDuplicates()
sales_clean = sales_clean.dropDuplicates()

# Fix data types
sales_clean = sales_clean.withColumn("total_amount", col("total_amount").cast("double"))

# Remove invalid values
sales_clean = sales_clean.filter(col("total_amount") > 0)

# 3. Transformations

# Task 1: Daily Sales
daily_sales = sales_clean.groupBy("sale_date") \
    .agg(sum("total_amount").alias("total_sales"))

daily_sales.show()

# Task 2: City-wise Revenue
city_revenue = customers_clean.join(sales_clean, "customer_id") \
    .groupBy("city") \
    .agg(sum("total_amount").alias("total_revenue"))

city_revenue.show()

# Task 3: Top 5 Customers
top_customers = customers_clean.join(sales_clean, "customer_id") \
    .groupBy("first_name", "last_name") \
    .agg(sum("total_amount").alias("total_spend")) \
    .orderBy(desc("total_spend")) \
    .limit(5)

top_customers.show()

# Task 4: Repeat Customers (>1 order)
repeat_customers = sales_clean.groupBy("customer_id") \
    .agg(count("sale_id").alias("order_count")) \
    .filter(col("order_count") > 1)

repeat_customers.show()

# Task 5: Customer Segmentation
customer_spend = customers_clean.join(sales_clean, "customer_id") \
    .groupBy("customer_id", "first_name", "last_name", "city") \
    .agg(sum("total_amount").alias("total_spend"))

segmented_df = customer_spend.withColumn(
    "segment",
    when(col("total_spend") > 10000, "Gold")
    .when((col("total_spend") >= 5000) & (col("total_spend") <= 10000), "Silver")
    .otherwise("Bronze")
)

segmented_df.show()

# Task 6: Final Reporting Table
final_df = segmented_df.join(repeat_customers, "customer_id", "left") \
    .select(
        "first_name",
        "last_name",
        "city",
        "total_spend",
        col("order_count"),
        "segment"
    )

final_df.show()

# 4. Load (Save Output)

# Convert Spark DataFrame → Pandas
pandas_df = final_df.toPandas()

# Save as Excel
final_df.coalesce(1).write.mode('overwrite').option("header", True)\
.csv("/tmp/report")

print("Pipeline Execution Completed Successfully!")