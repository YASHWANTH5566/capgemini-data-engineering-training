# Phase 2 – Data Transformation using PySpark

## 📌 Objective
In this phase, the goal is to perform data transformations on the given dataset using PySpark. 
This includes joining datasets, applying aggregations, and generating meaningful insights.

---

## 📊 Problem Summary
We were given datasets:
- customers.csv → customer details
- sales.csv → transactional data

The task was to:
- Combine datasets
- Perform aggregations
- Extract useful business insights

---

## ⚙️ Approach

1. Loaded datasets into PySpark DataFrames  
2. Performed data cleaning:
   - Removed null values in customer_id
   - Converted total_amount to numeric type  
3. Joined datasets using customer_id  
4. Applied transformations:
   - groupBy and aggregations  
   - filtering conditions  
5. Generated final outputs  

---

## 🔑 Key Transformations Used

- `join()` → to combine datasets  
- `groupBy()` → for aggregation  
- `agg()` → to calculate metrics (sum, avg, count)  
- `filter()` → to remove unwanted data  
- `orderBy()` → sorting results  

---

## 📈 Output / Results

The following outputs were generated:
- Total spend per customer  
- Top 3 customers by revenue  
- Customers with no orders  
- City-wise revenue  
- Average order value  
- Customers with multiple orders  

---

## 🏗️ Data Engineering Considerations

- Handled null values to avoid incorrect aggregations  
- Ensured correct data types (especially numeric columns)  
- Used proper joins to avoid duplicate records  

---

## ⚠️ Challenges Faced

- Ambiguous column names (amount vs total_amount)  
- Data type issues (string → double conversion)  
- File path errors while loading datasets  

---

## 📚 Learnings

- Mapping SQL queries to PySpark transformations  
- Importance of schema validation (`printSchema()`)  
- Handling real-world dataset inconsistencies  

---

## 📂 Files in this Folder

- `solution.py` → PySpark implementation  
- `queries.sql` → SQL queries  
- `README.md` → Documentation  
- `outputs/` → screenshots of results  