1. Which task took the most time?

The window functions (especially ranking and LAG) took the most time.
Understanding partitioning, ordering, and ensuring correct results for Top-N per group required careful debugging and multiple iterations.

2. What mistakes did you make?

Initially used wrong join types, which caused:
Duplicate records
Missing data
Forgot to validate foreign keys before joins
Misused window functions without proper PARTITION BY
Faced issues with date formats while extracting month
Did not cache DataFrames early, leading to slower execution

3. How did you debug issues?

Used:

df.show()
df.printSchema()
df.count()
Compared row counts before and after joins
Used left_anti joins to identify invalid records
Broke transformations into small steps instead of one big pipeline
Verified intermediate outputs before moving forward

4. Can you now build pipeline independently?

Yes — I can now:

Load and clean datasets
Perform joins correctly
Apply window functions
Validate data integrity
Build and execute a complete pipeline

I am confident in building end-to-end PySpark pipelines without guidance.

5. What needs improvement?

Speed of writing transformations
Better optimization (caching, partitioning)
Writing more production-ready code (modular + reusable)
Handling large-scale datasets efficiently
Learning Databricks workflows and Spark optimizations