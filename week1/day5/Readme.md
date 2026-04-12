# 📊 Advanced SQL Assignment: Student Submission Analysis

## 📌 Objective

Analyze student submission data using SQL focusing on joins, validation,
and window functions.

## 🗂️ Datasets

-   Master Table: 56 students
-   Task1_Responses: 51 records
-   Task1_File2: 60 records (duplicates + invalid)

## 🚀 Phases

### Phase 1: Data Preparation

-   Normalize emails (LOWER, TRIM)
-   Create unified email mapping

### Phase 2: Core Analysis

-   NOT submitted → LEFT JOIN
-   Valid submissions → INNER JOIN
-   Invalid submissions → LEFT JOIN + NULL

### Phase 3: Duplicate Detection

-   ROW_NUMBER() for duplicates
-   Keep first, mark others

### Phase 4: Insights

-   Submission count per student
-   Students using both emails
-   Final classification

## 🧠 Key Learnings

-   Joins & validation
-   Window functions
-   Data cleaning

## 📊 Outcome

Built a complete SQL pipeline for validation and analysis.

