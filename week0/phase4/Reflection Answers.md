### Reflection Answers

---

## 1. Why is cleaning done before joining tables?

If we join unclean data, problems like duplicates and null values get carried forward and even multiplied. Cleaning first makes sure the data is consistent, so the join results are accurate and meaningful.

--- 

## 2. What would go wrong if null keys are not removed?

Null keys won’t match during joins, so some records may be lost or incorrectly handled. This can lead to incomplete datasets and wrong insights during aggregation.

---

## 3. How did you decide join order?

I first cleaned both datasets and ensured the key columns were valid, then joined using customer_id. This way, only relevant and correct records are combined, avoiding unnecessary errors.

---

## 4. Which step was most difficult and why?

Customer segmentation and building the final reporting table were the hardest parts. It required combining multiple transformations like aggregation, joins, and conditional logic carefully.

---

## 5. How is SQL logic similar to PySpark?

Both follow the same flow—filtering data, joining tables, grouping, and aggregating results. The main difference is syntax, but the overall approach and thinking remain the same.

---

## 6. What challenges will appear with large data?

With large data, operations can become slow, especially joins and aggregations. Memory issues can also occur, so techniques like partitioning, caching, and optimization are important.

---

## 7. Can you explain your pipeline in simple steps?

First, I loaded the data and cleaned it by removing nulls and duplicates. Then I joined datasets, performed aggregations, applied segmentation logic, and finally generated and saved the report for analysis.