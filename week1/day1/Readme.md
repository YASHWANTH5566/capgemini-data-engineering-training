# Phase 5 – Databricks + Olist: End-to-End Data Engineering Pipeline

## 🔹 Objective  
In this phase, the goal is to work with a real-world dataset and build a complete end-to-end data pipeline using Databricks and PySpark. This includes data ingestion, cleaning, transformation, advanced analytics, and generating a final reporting dataset.

## 🔹 Problem Summary  
We worked with the Olist Brazilian E-commerce dataset, which contains multiple related tables like customers, orders, products, and order items.  
The task was to:
- Load and manage multiple datasets in Databricks  
- Perform data validation and cleaning  
- Join fact and dimension tables  
- Apply advanced analytics using window functions  
- Generate meaningful business insights  

## 🔹 Approach  

1. Data Ingestion  
   - Uploaded all CSV files into Databricks (/FileStore/olist/)  
   - Loaded datasets using PySpark DataFrames  

2. Data Cleaning & Validation  
   - Removed null values in key columns  
   - Fixed incorrect data types (especially timestamps)  
   - Validated joins using techniques like left_anti  

3. Data Transformation  
   - Joined multiple datasets using appropriate keys  
   - Created enriched datasets combining customer, order, and product data  

4. Analytics & Processing  
   - Used groupBy() for aggregations  
   - Applied window functions for ranking and running totals  
   - Calculated business metrics like total spend and order counts  

5. Customer Segmentation  
   - Applied business logic:
     - Gold → total_spend > 10000  
     - Silver → 5000–10000  
     - Bronze → <5000  

6. Final Reporting  
   - Combined all results into a single reporting table  
   - Included key fields like customer_id, city, total_spend, segment, and order count  

7. Data Storage  
   - Saved final outputs to DBFS for further analysis  

## 🔹 Key Transformations Used  
- join() → combining multiple tables  
- groupBy() → aggregations  
- agg() → computing metrics (sum, count)  
- filter() → cleaning invalid data  
- Window() → ranking and running totals  
- withColumn() → creating derived columns  

## 🔹 Analytical Tasks Performed  
- Top 3 customers per city using ranking  
- Daily sales and running total calculation  
- Top products per category  
- Customer lifetime value calculation  
- Customer segmentation  
- Final reporting dataset creation  

## 🔹 Output / Results  
The following outputs were generated:
- Ranked customer insights per city  
- Running sales trends  
- Product performance by category  
- Customer segmentation analysis  
- Final unified reporting dataset  

## 🔹 Data Engineering Considerations  
- Ensured referential integrity before joins  
- Avoided duplicate records during joins  
- Handled schema inconsistencies  
- Used window functions to retain row-level detail  
- Verified outputs using sample checks and counts  

## 🔹 Challenges Faced  
- Understanding Databricks file paths (/FileStore/ vs dbfs:/)  
- Handling incorrect schema inference (timestamps as strings)  
- Managing joins across multiple large datasets  
- Applying window functions correctly for ranking and cumulative metrics  

## 🔹 Learnings  
- Working with real-world multi-table datasets  
- Importance of data validation before transformation  
- Practical use of window functions in analytics  
- Difference between fact and dimension tables  
- Building a structured and scalable data pipeline  

## 🔹 Files in this Folder  
- phase5.ipynb → Complete PySpark implementation in Databricks  
- README.md → Project documentation  
- outputs/ → Screenshots or generated results  
- reflection_answers.md → Reflection responses  

## 🔹 Conclusion  
This phase provided hands-on experience in building a real-world data pipeline using Databricks. It helped in understanding how raw data is transformed into meaningful business insights through structured processing and analytics.
