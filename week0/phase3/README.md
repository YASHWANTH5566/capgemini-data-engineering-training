# 🚀 SQL to PySpark – Phase 3: Final ETL & Pipeline

## 📌 Objective
The goal of Phase 3 is to transition from writing isolated SQL queries to thinking like a Data Engineer.

This phase focuses on:
- Data ingestion
- Data cleaning
- Data transformation
- Building a structured ETL pipeline using PySpark

---

## 🧠 Core Concept: ETL Workflow

Every data engineering workflow follows:

ETL = Extract → Transform → Load

| Step | Description |
|------|------------|
| Extract | Read data from source files |
| Transform | Clean, filter, join, and aggregate |
| Load | Display or store final output |

---

## 📂 Datasets Used

Data is loaded from Spark sample datasets:

```python
df = spark.read.format('csv').option('header', 'true').load('/samples/customers.csv')
df1 = spark.read.format('csv').option('header','true').load('/samples/sales.csv')
```

---

## ⚙️ Project Structure

phase-3A/

├── spark_sql_queries.py  
├── queries.sql  
├── data_cleaning.py  
├── README.md  

---

## 🔄 ETL Pipeline Steps

### 🔹 1. Extract (Data Ingestion)
- Read CSV files using PySpark
- Inspect data using:
  - show()
  - printSchema()

---

### 🔹 2. Transform (Data Cleaning & Processing)

#### ✅ Data Issues Identified
- Null values
- Duplicate records
- Invalid values (e.g., negative amounts, invalid age)
- Incorrect data types

#### ✅ Cleaning Steps
- Remove null primary keys
- Handle missing values using fillna()
- Remove duplicates using dropDuplicates()
- Filter invalid records (age > 0, amount > 0)
- Type casting (e.g., total_amount to double)

---

### 🔹 3. Load (Final Output)
- Aggregated results displayed using .show()
- Final reporting table generated

---

## 📊 Business Pipeline Tasks

1. Daily Sales
2. City-wise Revenue
3. Repeat Customers (>2 orders)
4. Highest Spending Customer per City
5. Final Reporting Table

---

## 🔁 SQL → PySpark Mapping

| SQL | PySpark |
|-----|--------|
| SELECT | select() / spark.sql() |
| WHERE | filter() |
| GROUP BY | groupBy() |
| JOIN | join() |

---

## 🧪 Data Validation

- Row count comparison (before vs after)
- Null checks
- Duplicate checks

---

## 🧠 Key Learnings

- Data is not clean by default
- Learned ingestion and schema inspection
- Understood transformation pipeline
- Built structured ETL workflow
- Converted SQL to PySpark
- Developed data validation mindset

---

## 🎯 Final Outcome

- Read datasets using PySpark
- Clean and process data
- Perform joins and aggregations
- Build ETL pipelines
- Convert SQL logic into PySpark

---

## 🏁 One-Line Summary

Phase 3 is about taking raw data, cleaning it, and transforming it step-by-step into meaningful output using a structured ETL pipeline.
