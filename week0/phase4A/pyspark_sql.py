# Phase 4A – Spark SQL

from pyspark.sql import SparkSession

spark = SparkSession.builder.appName("Phase4A_SQL").getOrCreate()

customers = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/customers.csv")
sales = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/sales.csv")

customers.createOrReplaceTempView("customers")
sales.createOrReplaceTempView("sales")

# Total Spend
spark.sql("""
CREATE OR REPLACE TEMP VIEW total_spend AS
SELECT customer_id, SUM(total_amount) AS total_spend
FROM sales
GROUP BY customer_id
""")

# Segmentation
spark.sql("""
SELECT *,
CASE 
    WHEN total_spend > 10000 THEN 'Gold'
    WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
    ELSE 'Bronze'
END AS segment
FROM total_spend
""").show()

# Segment Count
spark.sql("""
SELECT segment, COUNT(*) AS customer_count
FROM (
    SELECT *,
    CASE 
        WHEN total_spend > 10000 THEN 'Gold'
        WHEN total_spend BETWEEN 5000 AND 10000 THEN 'Silver'
        ELSE 'Bronze'
    END AS segment
    FROM total_spend
) t
GROUP BY segment
""").show()