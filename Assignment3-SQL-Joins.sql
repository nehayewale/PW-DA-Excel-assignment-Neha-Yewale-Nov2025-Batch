-- Note : Create the following dummy tables in MySQL Workbench using CREATE FUNCTION-
-- Table 1: Customers

create database sql_joins;
use sql_joins;

create table customers(
CustomerID int,
CustomerName varchar(50),
City varchar(50)
);
select * from customers;

insert into customers(CustomerID, CustomerName, City)
values
(1, 'John Smith', 'New York'),
(2, 'Mary Johnson', 'Chicago'),
(3, 'Peter Adams', 'Los Angeles'),
(4, 'Nancy Miller', 'Houston'),
(5, 'Robert White', 'Miami');

select * from customers;

-- Table 2: Orders
create table Orders(
OrderID int,
CustomerID int,
OrderDate Date,
Amount int
);

insert into Orders
values
(101, 1, '2024-10-01', 250),
(102, 2, '2024-10-05', 300),
(103, 1, '2024-10-07', 150),
(104, 3, '2024-10-10', 450),
(105, 6, '2024-10-12', 400);

select * from Orders;

-- Table 3: Payments
create table Payments(
PaymentID varchar(20),
CustomerID int,
PaymentDate Date,
Amount int
);
insert into Payments
values
('P001', 1, '2024-10-02', 250),
('P002', 2, '2024-10-06', 300),
('P003', 3, '2024-10-11', 450),
('P004', 4, '2024-10-15', 200);

select * from Payments;

-- Table 4: Employees
create table Employees(
EmployeeID int,
EmployeeName varchar(50),
ManagerID int
);

insert into Employees
values
(1, 'Alex Green', null),
(2, 'Brian Lee', 1),
(3, 'Carol Ray', 1),
(4, 'David Kim', 2),
(5, 'Eva Smith', 2);
select * from Employees;

-- Question 1. Retrieve all customers who have placed at least one order.
select distinct Customers.CustomerID, customers.CustomerName, Customers.City, Orders.OrderID from customers inner join Orders on Customers.CustomerID = Orders.CustomerID;

-- Question 2. Retrieve all customers and their orders, including customers who have not placed any orders.
select c.CustomerID, c.CustomerName, c.City, o.OrderID 
from Customers as c left join Orders as o on c.CustomerID = o.CustomerID;

-- Question 3. Retrieve all orders and their corresponding customers, including orders placed by unknown customers.
select o.OrderID, o.OrderDate, o.Amount, c.CustomerID, c.CustomerName, c.City from 
Customers as c right join Orders as o on c.CustomerID = o.CustomerID;

-- Question 4. Display all customers and orders, whether matched or not.
select c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount from 
Customers as c left join Orders as o on c.CustomerID = o.CustomerID
UNION
select c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount from 
Customers as c right join Orders as o on c.CustomerID = o.CustomerID;

-- Question 5. Find customers who have not placed any orders.
select c.CustomerID, c.CustomerName, c.City, o.OrderID, o.OrderDate, o.Amount from 
Customers as c right join Orders as o on c.CustomerID = o.CustomerID where c.CustomerID is NULL;
-- select * from Customers where CustomerID not in (select CustomerID from Orders);

-- Question 6. Retrieve customers who made payments but did not place any orders.
select c.CustomerID, c.CustomerName, p.PaymentID from Customers as c join Payments as p
on c.CustomerID = p.CustomerID
where not exists
(select * from Orders as o where o.CustomerID = c.CustomerID);

-- Question 7. Generate a list of all possible combinations between Customers and Orders.
select * from  Customers as c left join Orders as o on o.CustomerID = c.CustomerID
union
select * from  Customers as c right join Orders as o on o.CustomerID = c.CustomerID;

-- Question 8. Show all customers along with order and payment amounts in one table.
select c.CustomerID, c.CustomerName, 
sum( p.Amount ) as PaymentAmount,
sum(o.Amount) as OrderAmount
from Customers as c 
left join orders as o
on c.CustomerID = o.CustomerID
left join Payments as p 
on c.CustomerID = p.CustomerID
group by c.CustomerID, c.CustomerName;

-- Question 9. Retrieve all customers who have both placed orders and made payments.
select distinct c.CustomerID, c.CustomerName, o.OrderID, p.PaymentID
from Customers as c join Orders as o
on c.CustomerID = o.CustomerID
join Payments as p
on c.CustomerID = p.CustomerID 
order by c.CustomerID;
