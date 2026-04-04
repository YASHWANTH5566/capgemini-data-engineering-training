# Phase 4A – Bucketing & Segmentation (PySpark)

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, when, count, sum
from pyspark.sql.window import Window
from pyspark.sql.functions import percent_rank
from pyspark.ml.feature import Bucketizer

spark = SparkSession.builder.appName("Phase4A").getOrCreate()

# Load Data
customers = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/customers.csv")
sales = spark.read.format("csv").option("header", "true").option("inferSchema", "true").load("/samples/sales.csv")

# Clean Data
customers = customers.dropna(subset=["customer_id"]).dropDuplicates()
sales = sales.dropna(subset=["customer_id"]).dropDuplicates()
sales = sales.withColumn("total_amount", col("total_amount").cast("double")).filter(col("total_amount") > 0)

# Total Spend per Customer
total_spend_df = sales.groupBy("customer_id").agg(sum("total_amount").alias("total_spend"))

# 1. Conditional Segmentation

segmented_df = total_spend_df.withColumn(
    "segment",
    when(col("total_spend") > 10000, "Gold")
    .when((col("total_spend") >= 5000) & (col("total_spend") <= 10000), "Silver")
    .otherwise("Bronze")
)

segmented_df.show()

# 2. Group by Segment

segment_counts = segmented_df.groupBy("segment").agg(count("customer_id").alias("customer_count"))
segment_counts.show()

# 3. Bucketizer (MLlib)

splits = [-float("inf"), 5000, 10000, float("inf")]
bucketizer = Bucketizer(splits=splits, inputCol="total_spend", outputCol="bucket")

bucketed_df = bucketizer.transform(total_spend_df)
bucketed_df.show()

# 4. Quantile-based Segmentation

quantiles = total_spend_df.approxQuantile("total_spend", [0.33, 0.66], 0)

q1, q2 = quantiles

quantile_df = total_spend_df.withColumn(
    "segment",
    when(col("total_spend") <= q1, "Bronze")
    .when((col("total_spend") > q1) & (col("total_spend") <= q2), "Silver")
    .otherwise("Gold")
)

quantile_df.show()

# 5. Window-based Ranking

window = Window.orderBy("total_spend")

ranked_df = total_spend_df.withColumn("rank_pct", percent_rank().over(window))
ranked_df.show()