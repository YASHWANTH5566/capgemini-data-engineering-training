# Phase 2: PySpark Data Transformation
# Dataset: customers, sales

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, sum, avg

# Initialize Spark Session
spark = SparkSession.builder.appName('Spark Playground').getOrCreate()

# Load the customers.csv and sales.csv datasets
df = spark.read.format('csv').option('header', 'true').load('/samples/customers.csv')
df1 = spark.read.format('csv').option('header','true').load('/samples/sales.csv')

# Data Cleaning
customers = df.dropna(subset=["customer_id"])
sales = df1.dropna(subset=["customer_id"])

# Ensure correct datatype
sales = sales.withColumn("total_amount", col("total_amount").cast("double"))

# 1. Total order amount per customer
sales.groupBy("customer_id").agg(sum("total_amount").alias("total_spend")).show(5)

# 2. Top 3 customers by total spend
sales.groupBy("customer_id").agg(sum("total_amount").alias("total_spend")).orderBy(col("total_spend").desc()).limit(3).show(5)

# 3. Customers with no orders
customers.join(sales, "customer_id", "left").filter(sales.customer_id.isNull()).select("customer_id", "first_name").show(5)

# 4. City-wise total revenue
customers.join(sales, "customer_id").groupBy("city").agg(sum("total_amount").alias("total_revenue")).show(5)

# 5. Average order amount per customer
sales.groupBy("customer_id").agg(avg("total_amount").alias("avg_order")).show(5)

# 6. Customers with more than one order
sales.groupBy("customer_id").agg(count("*").alias("order_count")).filter(col("order_count") > 1).show()

# 7. Sort customers by total spend descending
sales.groupBy("customer_id").agg(sum("total_amount").alias("total_spend")).orderBy(col("total_spend").desc()).show(5)