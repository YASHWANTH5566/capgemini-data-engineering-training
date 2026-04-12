# 🚀 Phase 6 – Spark Playground Exit Sprint (Advanced Practice Lab)

## 📌 Objective
The goal of this phase is to build fluency and confidence in PySpark by practicing:
- Joins
- Window functions
- Date operations
- End-to-end pipeline execution

This phase prepares for transitioning to **Databricks and real-world data engineering workflows**.

---

## ⏱️ Effort
Estimated Time: **3–4 Hours**

---

## 📚 Mandatory Reading
- Window Functions  
  https://www.sparkplayground.com/tutorials/pyspark/window-functions  

- Joining DataFrames  
  https://www.sparkplayground.com/tutorials/pyspark/joining-dataframes  

- Date Functions  
  https://www.sparkplayground.com/tutorials/pyspark/date-functions  

---

## 🧪 Practice Sets

### 🔹 Practice Set A: Join Drills
- Inner Join → Retrieve valid records  
- Left Join → Identify missing values  
- Left Anti Join → Detect invalid foreign keys  
- Compare row counts across joins  

---

### 🔹 Practice Set B: Window Functions
- Top 3 customers per city using ranking  
- Running total of sales  
- Rank customers by total spend  
- Use `LAG` to find previous transactions  

---

### 🔹 Practice Set C: Date Analysis
- Extract month from date  
- Monthly sales aggregation  
- Calculate difference between dates  
- Perform trend analysis  

---

### 🔹 Practice Set D: Timed Pipeline (60–75 mins)
Steps performed:
1. Load datasets  
2. Clean invalid records  
3. Validate referential integrity  
4. Join tables  
5. Apply aggregations and window functions  
6. Save output  

---

## ⚙️ Pipeline Overview

### 1. Data Loading
- Loaded structured datasets into PySpark DataFrames

### 2. Data Cleaning
- Removed null values  
- Fixed invalid price values  
- Ensured data consistency  

### 3. Validation
- Used **left_anti joins** to detect invalid foreign keys  
- Verified row counts  

### 4. Transformation
- Calculated revenue (`price * quantity`)  
- Aggregated:
  - Revenue per customer  
  - Revenue per city  
  - Cars per brand  

### 5. Analysis
- Top customers using window functions  
- Repeat customers  
- Monthly revenue trends  

### 6. Output
- Saved results to:

/tmp/car_sales_output/

---

## 🧠 Key Learnings

- Strong understanding of **joins and their use cases**
- Hands-on experience with **window functions**
- Practical usage of **date transformations**
- Importance of **data validation before transformations**
- Ability to build a **complete PySpark pipeline**

---

## 🚧 Challenges Faced

- Debugging incorrect joins  
- Understanding window partitioning  
- Handling date formats  
- Ensuring correct aggregation logic  

---

## 🛠️ Debugging Techniques

- Used `.show()`, `.count()`, `.printSchema()`  
- Verified intermediate outputs  
- Compared row counts before/after joins  
- Used anti-joins for validation  

---

## 📈 Outcomes

- Improved PySpark fluency  
- Better debugging skills  
- Increased confidence in handling pipelines  
- Ready to transition to **Databricks**

---

## 🔮 Next Steps

- Learn **Spark optimizations (caching, partitioning)**  
- Build pipelines in **Databricks**  
- Work with **real-world large datasets**  
- Implement **Airflow for orchestration**

---

## 💡 Reflection Summary

- Window functions required the most effort  
- Mistakes helped in understanding joins and validation  
- Now capable of building pipelines independently  
- Need to improve speed and optimization  

---
