
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.getOrCreate()

# =========================
# Dirty Customers Dataset
# =========================

customers_data = [
    (1, "John Doe", "john@example.com", "Hyderabad"),
    (2, "Alice ", "alice@example.com", "Chennai"),
    (3, None, "bob@example.com", "Bangalore"),        # NULL name
    (4, "David", None, "Mumbai"),                    # NULL email
    (5, "Eva", "eva@example.com", "Hyderabad"),
    (6, "Frank", "frank@example.com", "Delhi"),
]

customers = spark.createDataFrame(customers_data, ["customer_id", "name", "email", "city"])

# =========================
# Dirty Orders Dataset
# =========================

orders_data = [
    (101, 1, "2024-01-01", 1000),
    (102, 2, "2024-01-02", 2000),
    (103, 3, "2024-01-03", -500),     # INVALID negative value
    (104, 99, "2024-01-04", 1500),    # INVALID FK (customer_id 99)
    (105, 1, "2024-01-05", None),     # NULL amount
    (106, 5, "2024-01-06", 3000),
    (107, 5, "2024-01-07", 3000),     # duplicate-like record
]

orders = spark.createDataFrame(orders_data, ["order_id", "customer_id", "order_date", "amount"])

# =========================
# Convert date column
# =========================

orders = orders.withColumn("order_date", to_date(col("order_date")))

# =========================
# Tasks for Students
# =========================

# TODO 1: Clean data
# - Remove nulls
# - Handle negative values
# - Trim names

# TODO 2: Validate data
# - Find invalid customer_id using left_anti join

# TODO 3: Join datasets

# TODO 4: Apply transformations
# - total spend per customer
# - count orders

# TODO 5: Window functions
# - rank customers by spend

# TODO 6: Save output
# final_df.write.mode("overwrite").csv("/tmp/phase6_output")

print("Starter dataset loaded successfully")
