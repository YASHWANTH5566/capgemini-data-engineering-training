# Phase 3A – Data Quality & Cleaning Challenge

## 📌 Objective
The objective of this phase is to work with messy data and apply data cleaning techniques before performing any transformations or analysis. This helps in understanding the importance of data quality in real-world data engineering.


## 📊 Problem Summary
We were given a dataset containing customer information with multiple data quality issues such as:

- Null values in important columns  
- Duplicate records  
- Missing primary keys (customer_id)  
- Invalid values (negative age)  

The task was to:
- Identify data issues  
- Clean the dataset  
- Validate the cleaning process  
- Perform aggregation (customers per city)  


## ⚙️ Approach

1. **Data Creation**
   - Created a PySpark DataFrame with intentionally messy data

2. **Data Issue Identification**
   - Detected null values
   - Identified duplicate rows
   - Checked missing primary keys

3. **Data Cleaning Steps**
   - Removed rows with null `customer_id`
   - Filled missing values in `name` and `city`
   - Removed duplicate records

4. **Validation**
   - Compared row counts before and after cleaning
   - Verified no critical null values remain

5. **Aggregation**
   - Calculated number of customers per city using `groupBy`


## 🔧 Key Transformations Used

- `dropna()` → Remove null values  
- `fillna()` → Handle missing values  
- `dropDuplicates()` → Remove duplicate rows  
- `filter()` → Remove invalid data  
- `groupBy()` → Group data  
- `agg()` → Perform aggregation  


## 📈 Output / Results

The following outputs were generated:

- Cleaned customer dataset  
- Row count comparison (before vs after cleaning)  
- Aggregated result: **number of customers per city**


## 🧠 Data Engineering Considerations

- Ensured primary key (`customer_id`) integrity  
- Prevented duplicate records from affecting results  
- Removed invalid values to maintain data accuracy  
- Validated dataset after cleaning  


## ⚠️ Challenges Faced

- Handling multiple data issues simultaneously  
- Deciding how to treat missing values  
- Ensuring no important data is lost during cleaning  


## 📚 Key Learnings

- Real-world data is often messy and incomplete  
- Data cleaning is a critical step before analysis  
- Poor data quality leads to incorrect insights  
- Validation is essential after cleaning  


## 📁 Files in this Folder

- `pyspark_phase_3A.py` → PySpark implementation  
- `reflection_answers.md` → Answers to reflection questions  
- `README.md` → Documentation for Phase 3A  