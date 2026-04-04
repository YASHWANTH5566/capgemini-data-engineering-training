# Phase 3A – Data Quality & Cleaning Challenge

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, count

# Initialize Spark
spark = SparkSession.builder.appName("Phase3A").getOrCreate()

# Step 1: Load Data
customers = spark.read.format('csv').option('header', 'true').option('inferSchema', 'true').load('/samples/customers.csv')

sales = spark.read.format('csv').option('header', 'true').option('inferSchema', 'true').load('/samples/sales.csv')

print("===== Original Customers Data =====")
customers.show(5)

print("===== Original Sales Data =====")
sales.show(5)

# Step 2: Identify Data Issues
print("===== Data Issues =====")
print("- Null values may exist")
print("- Duplicate records possible")
print("- Incorrect data types possible")
print("- Missing customer_id (primary key issue)")

# Step 3: Cleaning Customers Data

# Remove rows with null customer_id
customers_clean = customers.dropna(subset=["customer_id"])

# Fill missing values
customers_clean = customers_clean.fillna({
    "first_name": "Unknown",
    "last_name": "Unknown",
    "city": "Unknown"
})

# Remove duplicates
customers_clean = customers_clean.dropDuplicates()

print("===== Cleaned Customers Data =====")
customers_clean.show(5)

# Step 4: Cleaning Sales Data

# Remove rows with null customer_id
sales_clean = sales.dropna(subset=["customer_id"])

# Remove duplicates
sales_clean = sales_clean.dropDuplicates()

# Fix data type for total_amount (important!)
sales_clean = sales_clean.withColumn(
    "total_amount", col("total_amount").cast("double")
)

# Remove invalid values (amount > 0)
sales_clean = sales_clean.filter(col("total_amount") > 0)

print("===== Cleaned Sales Data =====")
sales_clean.show(5)

# Step 5: Validation
print("===== Validation =====")

print("Customers - Before:", customers.count())
print("Customers - After:", customers_clean.count())

print("Sales - Before:", sales.count())
print("Sales - After:", sales_clean.count())

# Step 6: Aggregation (Customers per City)
print("===== Customers per City =====")

customers_per_city = customers_clean.groupBy("city").agg(count("customer_id").alias("customer_count")).orderBy(col("customer_count").desc())

customers_per_city.show()

print("===== Total Spend per Customer =====")

total_spend = sales_clean.groupBy("customer_id") \
    .agg(count("sale_id").alias("total_orders"))

total_spend.show()