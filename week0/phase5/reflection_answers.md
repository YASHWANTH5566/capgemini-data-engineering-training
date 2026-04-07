# Phase 5 – Reflection Answers

## Q1. What challenges did you face in setup?

The main challenge was understanding how Databricks file paths work. Files uploaded via the UI land under `/FileStore/` which is accessible to Spark as `dbfs:/FileStore/`, but must be referenced without the `dbfs:` prefix in most `spark.read` calls. Another challenge was that `inferSchema` occasionally misdetected timestamp columns as plain strings, requiring explicit casting with `to_timestamp()` afterward.

---

## Q2. How did you validate joins?

Joins were validated using `left_anti` joins — a technique that returns rows from the left table that have **no match** in the right table. This directly tests referential integrity. For example:

```python
orphan_items = df_order_items.join(df_orders.select("order_id"), on="order_id", how="left_anti")
print(orphan_items.count())  # Expected: 0
```

Row counts before and after joins were also compared to ensure no unintended row multiplication (which would indicate a missing join condition or a many-to-many key).

---

## Q3. How did window functions help?

Window functions made city-level and category-level rankings possible **without losing row-level detail**. A regular `groupBy` collapses rows into aggregates, making it impossible to rank within groups while keeping all attributes. With `Window.partitionBy("city").orderBy(col("spend").desc())`, each row keeps its original values and receives a rank column computed relative to its partition. This was essential for Tasks 1, 2, and 3.

The running total in Task 2 was also only possible using a window with `rowsBetween(unboundedPreceding, currentRow)` — a `groupBy` would only give daily totals, not cumulative ones.

---

## Q4. Can you explain your pipeline?

The pipeline follows a classic layered data engineering pattern:

1. **Ingestion** – Raw CSVs loaded into Spark DataFrames via `spark.read.csv`
2. **Cleaning** – Nulls removed, types corrected, referential integrity validated
3. **Transformation** – Joins across fact and dimension tables to create enriched datasets
4. **Analytics** – Window functions and aggregations to generate business metrics
5. **Segmentation** – Rule-based classification applied as a derived column
6. **Reporting** – All relevant attributes unified into a single final table
7. **Persistence** – Outputs written back to DBFS as CSVs for downstream use

Each step is isolated in its own Databricks cell, making debugging and re-running individual steps straightforward.
