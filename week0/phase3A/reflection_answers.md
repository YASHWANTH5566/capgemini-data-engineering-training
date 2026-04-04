# Phase 3A – Reflection Answers

## 1. What happens if cleaning is skipped?

If data cleaning is skipped, the results produced from the dataset will be inaccurate and unreliable.

- Null values can cause errors or missing outputs in analysis  
- Duplicate records can inflate counts and totals  
- Invalid data (e.g., negative age) leads to incorrect calculations  
- Missing primary keys (customer_id) break joins and relationships  

Overall, skipping cleaning results in poor data quality and misleading insights.


## 2. Which issue impacted results most?

The most impactful issues were:

- Duplicate records → They increase counts and aggregations incorrectly  
- Invalid values (negative age) → They distort averages and statistical analysis  

These issues directly affect metrics, making the results unreliable.


## 3. How would this affect business decisions?

Poor data quality leads to wrong business decisions:

- Incorrect customer counts → wrong targeting strategies  
- Invalid analytics → poor marketing and operational decisions  
- Misleading insights → financial losses or missed opportunities  

Businesses rely on accurate data, so bad data can significantly impact performance.


## 4. Can you define a cleaning checklist?

Yes, a standard data cleaning checklist includes:

- Remove null values in critical columns (like primary keys)  
- Handle missing values (fill or remove)  
- Remove duplicate records  
- Validate data ranges (e.g., age > 0)  
- Ensure correct data types (string, integer, double)  
- Check column consistency and naming  
- Validate results after cleaning (row counts, sample checks)  

This checklist ensures data is reliable before analysis.