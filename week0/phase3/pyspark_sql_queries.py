# Phase 3 – Spark SQL Queries

from pyspark.sql import SparkSession
from pyspark.sql.functions import col

# Initialize Spark
spark = SparkSession.builder.appName("SparkSQLQueries").getOrCreate()

# Load Data
customers = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/customers.csv")

sales = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/sales.csv")

# Basic Cleaning

customers_clean = customers.dropna(subset=["customer_id"]) \
    .fillna({
        "first_name": "Unknown",
        "last_name": "Unknown",
        "city": "Unknown"
    }) \
    .dropDuplicates()

sales_clean = sales.dropna(subset=["customer_id"]).dropDuplicates().withColumn("total_amount", col("total_amount").cast("double")).filter(col("total_amount") > 0)

# Register Temp Views

customers_clean.createOrReplaceTempView("customers")
sales_clean.createOrReplaceTempView("sales")

# 1. Daily Sales
print("===== Daily Sales =====")
spark.sql("""
SELECT sale_date, SUM(total_amount) AS daily_revenue
FROM sales
GROUP BY sale_date
""").show()

# 2. City-wise Revenue
print("===== City-wise Revenue =====")
spark.sql("""
SELECT c.city, SUM(s.total_amount) AS city_revenue
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.city
""").show()

# 3. Repeat Customers
print("===== Repeat Customers =====")
spark.sql("""
SELECT customer_id, COUNT(*) AS order_count
FROM sales
GROUP BY customer_id
HAVING COUNT(*) > 2
""").show()

# 4. Highest Spending Customer per City
print("===== Top Customers per City =====")
spark.sql("""
SELECT *
FROM (
    SELECT c.customer_id, c.city,
           SUM(s.total_amount) AS total_spend,
           ROW_NUMBER() OVER (
               PARTITION BY c.city 
               ORDER BY SUM(s.total_amount) DESC
           ) AS rank
    FROM customers c
    JOIN sales s ON c.customer_id = s.customer_id
    GROUP BY c.customer_id, c.city
) t
WHERE rank = 1
""").show()

# 5. Final Reporting Table
print("===== Final Report =====")
spark.sql("""
SELECT c.customer_id, c.city,
       SUM(s.total_amount) AS total_spend,
       COUNT(s.sale_id) AS order_count
FROM customers c
JOIN sales s ON c.customer_id = s.customer_id
GROUP BY c.customer_id, c.city
""").show()