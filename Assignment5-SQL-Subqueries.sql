create database subqueries;
use subqueries;

create table employee(
emp_id int,
emplyee_name varchar(50),
department_id varchar(20),
salary int
);

insert into employee(emp_id, emplyee_name, department_id, salary)
values
(101, 'Abhishek', 'D01', 62000),
(102, 'Shubham', 'D01', 58000),
(103, 'Priya', 'D02', 67000),
(104, 'Rohit', 'D02', 64000),
(105, 'Neha', 'D03', 72000),
(106, 'Aman', 'D03', 55000),
(107, 'Ravi', 'D04', 60000),
(108, 'Sneha', 'D04', 75000),
(109, 'Kiran', 'D05', 70000),
(110, 'Tanuja', 'D05', 65000);

select * from employee;

create table department(
department_id varchar(20),
department_name varchar(50),
location varchar(30)
);

insert into department(department_id, department_name, location)
values
('D01', 'Sales', 'Mumbai'),
('D02', 'Marketing', 'Delhi'),
('D03', 'Finance', 'Pune'),
('D04', 'HR', 'Bengaluru'),
('D05', 'IT', 'Hyderabad');

select * from department;

create table sales(
sale_id int,
emp_id int,
sale_amount int,
sale_date date
);

insert into sales(sale_id, emp_id, sale_amount, sale_date)
values
(201, 101, 4500, '2025-01-05'),
(202, 102, 7800, '2025-01-10'),
(203, 103, 6700, '2025-01-14'),
(204, 104, 12000, '2025-01-20'),
(205, 105, 9800, '2025-02-02'),
(206, 106, 10500, '2025-02-05'),
(207, 107, 3200, '2025-02-09'),
(208, 108, 5100, '2025-02-15'),
(209, 109, 3900, '2025-02-20'),
(210, 110, 7200, '2025-03-01');

select * from sales;

-- 1. Retrieve the names of employees who earn more than the average salary of all employees.
select emplyee_name, salary from employee 
where salary > (select avg(salary) as avg_salary from employee) order by salary desc;

-- 2. Find the employees who belong to the department with the highest average salary.
select emplyee_name, department_id from employee where department_id = 
(
select department_id from employee 
group by department_id order by avg(salary) desc limit 1
);

-- 3. List all employees who have made at least one sale.
select emp_id, sale_amount
from sales where sale_amount is not null order by sale_amount desc;

-- 4. Find the employee with the highest sale amount.
select emp.emplyee_name, emp.emp_id, s.sale_amount as highest_sale_amt 
from employee as emp
join sales as s 
on emp.emp_id = s.emp_id
where s.sale_amount = (
select max(sale_amount)
from sales
);

-- 5. Retrieve the names of employees whose salaries are higher than Shubham’s salary.
select emplyee_name, salary 
from employee where salary > 
(
select salary from employee where emplyee_name = 'Shubham'
) 
order by salary desc;


-- Intermediate Level

-- 1. Find employees who work in the same department as Abhishek.
select e.emp_id, e.emplyee_name, d.department_id, d.department_name 
from employee as e join department as d 
on e.department_id = d.department_id
where e.department_id =
(
select department_id from employee where emplyee_name = 'Abhishek'
);

select e.emp_id, e.emplyee_name from employee as e where e.department_id =
(
select department_id from employee where emplyee_name = 'Abhishek'
);

-- 2. List departments that have at least one employee earning more than ₹60,000.
select distinct e.department_id, e.salary, d.department_name from employee as e join department as d 
on e.department_id = d.department_id
where e.salary > 60000 order by department_id;

-- with having
select e.department_id, d.department_name from employee as e 
join department as d
on e.department_id = d.department_id
group by e.department_id, d.department_name
having max(salary) > 60000
order by e.department_id;

-- 3. Find the department name of the employee who made the highest sale.
select d.department_name, s.sale_amount from department as d
join employee as e
on d.department_id = e.department_id
join sales as s
on e.emp_id = s.emp_id
where s.sale_amount = (
select max(sale_amount) from sales
);
-- 4. Retrieve employees who have made sales greater than the average sale amount.
-- with where
select e.emplyee_name, e.emp_id, s.sale_amount 
from employee as e
join sales as s
on e.emp_id = s.emp_id 
where s.sale_amount > (
select avg(sale_amount) from sales)
order by sale_amount desc;

-- with having
select e.emplyee_name, e.emp_id, s.sale_amount 
from employee as e
join sales as s
on e.emp_id = s.emp_id
group by e.emplyee_name, e.emp_id, s.sale_amount 
having s.sale_amount > (
select avg(sale_amount) from sales)
order by sale_amount desc;

-- 5. Find the total sales made by employees who earn more than the average salary.
select s.emp_id, e.emplyee_name, s.sale_amount
from sales as s
join employee as e
on e.emp_id = s.emp_id
group by s.emp_id, e.emplyee_name, s.sale_amount
having sum(sale_amount) >
(select avg(sale_amount) from sales)
order by sale_amount desc;

-- Advanced Level

-- 1. Find employees who have not made any sales.
select e.emplyee_name, s.sale_amount
from employee as e
left join sales as s
on e.emp_id = s.emp_id
where s.emp_id is null;

-- 2. List departments where the average salary is above ₹55,000.
select department_id, avg(salary) from employee group by department_id having avg(salary) > 55000;

-- 3. Retrieve department names where the total sales exceed ₹10,000.
select d.department_name, sum(sale_amount) from employee as e
join department as d
on e.department_id = d.department_id
join sales as s
on e.emp_id = s.emp_id
group by d.department_name, sale_amount 
having sum(sale_amount) > 10000;

-- 4. Find the employee who has made the second-highest sale.
select emp_id, sale_amount as secondhighestsales 
from (
 select emp_id, sale_amount, dense_rank() over (order by sale_amount desc) as rnk from sales) as a
where rnk = 2;

-- 5. Retrieve the names of employees whose salary is greater than the highest sale amount recorded.
select emplyee_name, salary from employee
where salary > (select max(sale_amount) from sales) order by salary desc;