-- creating the Employee, Sales tables
CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(50),
salary DECIMAL(10, 2),
joining_date DATE
);

CREATE TABLE Sales (
sales_id INT PRIMARY KEY,
emp_id INT,
product VARCHAR(50),
amount DECIMAL(10, 2),
sale_date DATE
);

-- Inserting sample data into Employee and Sales tables
INSERT INTO Employee (emp_id, emp_name, department, salary, joining_date) VALUES
(1, 'Karthik', 'HR', 60000.00, '2021-01-15'),
(2, 'Pratik', 'Finance', 70000.00, '2021-03-10'),
(3, 'Veer', 'HR', 55000.00, '2021-06-20'),
(4, 'Priya', 'Finance', 80000.00, '2022-01-05'),
(5, 'Ajay', 'Engineering', 75000.00, '2020-11-01'),
(6, 'Vijay', 'Engineering', 78000.00, '2019-05-22'),
(7, 'Veena', 'HR', 62000.00, '2023-03-12'),
(8, 'Meena', 'Marketing', 65000.00, '2022-08-18');

INSERT INTO Sales (sales_id, emp_id, product, amount, sale_date) VALUES
(1, 1, 'Laptop', 50000.00, '2023-01-15'),
(2, 2, 'Mobile', 30000.00, '2023-02-18'),
(3, 3, 'Tablet', 20000.00, '2023-02-25'),
(4, 4, 'Laptop', 45000.00, '2023-03-05'),
(5, 5, 'Mobile', 35000.00, '2023-03-12'),
(6, 6, 'Tablet', 25000.00, '2023-03-20'),
(7, 7, 'Laptop', 60000.00, '2023-04-01'),
(8, 8, 'Mobile', 40000.00, '2023-04-10');

-- viewing the table
select * from Employee;

-- 1. Find the total salary for each department in the Employee table.
select department,sum(salary) as total_salary
from Employee
group by department;

-- 2. Count the number of employees in each department.
select department, count(emp_id) as no_of_employees
from Employee
group by department;

select department, count(*) as no_of_employees
from Employee
group by department;

-- 3. Calculate the average salary of employees in each department.
select department, avg(salary) as Avg_salary
from Employee group by department;

-- 4. Find the maximum salary in each department.
select department, max(salary) as Max_Salary
from Employee group by department;

-- 5. Find the minimum salary in each department.
select department, min(salary) as Min_Salary
from Employee group by department;

-- 6. Find the total salary for departments where the total salary exceeds 100,000.
select department, sum(salary) as total_salary
from Employee group by department having total_salary > 100000;

-- 7. Count the number of employees in departments with more than 2 employees.
select department, count(emp_id) as no_of_employees
from Employee group by department having no_of_employees > 2;

-- 8. Calculate the average salary for employees who joined after 2021-01-01, grouped by department.
select department, avg(salary) as avg_salary
from Employee
where joining_date > '2021-01-01'
group by department;

-- 9. Find the departments where the maximum salary is greater than 75,000.
select department
from Employee
group by department
having max(salary) > 75000;

-- 10. List the departments where the total salary is less than 150,000.
select department
from Employee group by department
having sum(salary) < 150000;

-- 11. Find the total number of employees grouped by department, but only include departments with more than 1 employee.
select department, count(emp_id)  as total_employees
from Employee
group by department having total_employees > 1;

-- 12. Calculate the total salary of each department and show only those where the total exceeds 125,000.
select department, sum(salary) as total_salary
from Employee
group by department having total_salary > 125000;

-- 13. Count the number of employees in each department, but include only departments with more than 2 employees.
select department, count(emp_id) as no_of_employees
from Employee
group by department having no_of_employees > 2;

-- 14. Find the average salary in each department where the average salary is above 60,000.
select department, avg(salary) as avg_salary
from Employee
group by department having avg_salary > 60000;

-- 15. Show departments where the sum of salaries is between 100,000 and 200,000.
select department, sum(salary) as total_salary
from Employee
group by department having total_salary between 100000 and 200000;

-- 16. Find the total sales amount for each employee.
select e.emp_name, sum(s.amount) as total_sales_amount
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.emp_id;

-- 17. List the number of sales made by each employee.
select e.emp_id, count(s.sales_id) as no_of_sales
from Employee e join Sales s on e.emp_id = s.emp_id
group by s.emp_id;

-- 18. Find the total sales amount grouped by product.
select product, sum(amount) as total_sales
from Sales
group by product;

-- 19. Calculate the average sales amount grouped by product.
select product, avg(amount) as avg_sales_amount
from Sales group by product;

-- 20. Find employees who have made more than 2 sales, grouped by their names.
select e.emp_name, count(s.sales_id) as no_of_sales
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.emp_name having no_of_sales > 2;

-- 21. Calculate the total salary and total sales amount for each employee.
select e.emp_name, sum(distinct e.salary) as total_salary, sum(s.amount) as total_sales
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.emp_id;

-- 22. Count the number of unique products sold by each employee.
select e.emp_name, count(distinct s.product)
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.emp_id;

-- 23. Find the highest sales amount made by each employee.
select e.emp_name, max(s.amount) as highest_sales_amount
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.emp_id;

-- 24. Calculate the total sales amount grouped by product and filtered by products where the total exceeds 50,000.
select product, sum(amount) as total_sales_amount
from Sales 
group by product having total_sales_amount > 50000;

-- 25. Find the departments with the highest average sales amount.
select e.department, avg(s.amount) as highest_average_sales
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.department
order by highest_average_sales desc
limit 1;

-- 26. Find the department with the highest total sales amount.
select e.department, sum(amount) as total_sales_amount
from Employee e join Sales s on e.emp_id = s.emp_id
group by department order by total_sales_amount desc limit 1;

-- 27. Show the top 3 employees with the highest total sales amount, grouped by employee names.
select e.emp_name, sum(s.amount) as total_sales_amount
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.emp_id order by total_sales_amount desc limit 3;

-- 28. Calculate the total number of employees and the average salary, grouped by the year of joining.
select year(joining_date) as year_of_joining, count(emp_id) as no_of_employees, avg(salary) as avg_salary
from Employee
group by year_of_joining
order by year_of_joining;

-- 29. Find the total sales amount for each department (using a join between Employee and Sales).
select e.department, sum(s.amount) as total_sales_amount
from Employee e join Sales s on e.emp_id = s.emp_id
group by e.department;

-- 30. Show employees who have not made any sales, grouped by their department
select e.department, count(e.emp_id) as no_of_employees_without_sales
from Employee e left join Sales s on e.emp_id = s.emp_id
where s.sales_id is null
group by e.department;