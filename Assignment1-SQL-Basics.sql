-- Q1. Create a New Database and  Table for Employees
-- Task: Create a new database named and Create a table named with the following
-- columns:
create database company_db;
use company_db;

-- Task: Create a new database named and Create a table named with the following columns:
create table employees(
employee_id int PRIMARY KEY,
first_name varchar(50),
last_name varchar(50),
department varchar(50),
salary int,
hire_date date);

-- Q2. Insert Data into Employees Table
-- Task: Insert the following sample records into the employees table
Insert into employees(employee_id, first_name, last_name, department, salary, hire_date)
VALUES
(101, 'Amit', 'Sharma', 'HR', 50000, '2020-01-15'),
(102, 'Riya', 'Kapoor', 'Sales', 75000, '2019-03-22'),
(103, 'Raj', 'Mehta', 'IT', 90000, '2018-07-11'),
(104, 'Neha', 'Verma', 'IT', 85000, '2021-09-01'),
(105, 'Arjun', 'Singh', 'Finance', 60000, '2022-02-10');

select * from employees;

-- Q3. Display All Employee Records Sorted by Salary (Lowest to Highest)
-- Hint: Use the ORDER BY clause on the salary column.
select * from employees order by salary ASC;

-- Q4. Show Employees Sorted by Department (A–Z) and Salary (High → Low)
select * from employees order by department ASC, salary DESC;

-- Q5. List All Employees in the IT Department, Ordered by Hire Date (Newest First)
select * from employees where department = 'IT' order by hire_date DESC;

-- Q6. Create and Populate a Sales Table
-- Task: Create a table to track sales data:

create table sales(
sale_id int,
customer_name varchar(50),
amount int,
sale_date date
);

insert into sales(sale_id, customer_name, amount, sale_date)
values
(1, 'Aditi', 1500, '2024-08-01'),
(2, 'Rohan', 2200, '2024-08-03'),
(3, 'Aditi', 3500, '2024-09-05'),
(4, 'Meena', 2700, '2024-09-15'),
(5, 'Rohan', 4500, '2024-09-25');

select * from sales;

-- Q7. Display All Sales Records Sorted by Amount (Highest → Lowest)
-- Hint: Use ORDER BY amount DESC
select * from sales order by amount DESC; 

-- Q8. Show All Sales Made by Customer “Aditi”
-- Hint: Use WHERE customer_name = 'Aditi'
select * from sales where customer_name = 'Aditi';