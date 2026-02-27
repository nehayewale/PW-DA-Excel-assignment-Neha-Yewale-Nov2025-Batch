create database Sales_Transactions;
use Sales_Transactions;

-- Write an SQL query on Sales_Transactions to list all duplicate keys and their counts using the business key 
-- (Customer_ID + Product_ID + Txn_Date + Txn_Amount ).
create table customer_txn(
Txn_ID int,
Customer_ID varchar(10),
Customer_Name varchar(50),
Product_ID varchar(10),
Quantity int,
Txn_Amount int,
Txn_Date date,
City varchar(50)
);

insert into customer_txn(Txn_ID, Customer_ID, Customer_Name, Product_ID, Quantity, Txn_Amount, Txn_Date, City)
values
(201, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(202, 'C102', 'Anjali Rao', 'P12', 1, 1500, '2025-12-01', 'Bengaluru'),
(203, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai'),
(204, 'C103', 'Suresh Iyer', 'P13', 3, 6000, '2025-12-02', 'Chennai'),
(205, 'C104', 'Neha Singh', 'P14', null, 2500, '2025-12-02', 'Delhi'),
(206, 'C105', 'N/A', 'P15', 1, null, '2025-12-03', 'Pune'),
(207, 'C106', 'Amit Verma', 'P16', 1, 1800, null, 'Pune'),
(208, 'C101', 'Rahul Mehta', 'P11', 2, 4000, '2025-12-01', 'Mumbai');

select * from customer_txn;

SELECT Customer_ID, Product_ID, Txn_Date, Txn_Amount, COUNT(*) AS Duplicate_Count
FROM customer_txn
GROUP BY Customer_ID, Product_ID, Txn_Date, Txn_Amount
HAVING COUNT(*) > 1;

-- Question 8 : Enforcing Referential Integrity. Assume the following Customers_Master table:
-- Identify Sales_Transactions.Customer_ID values that violate referential integrity when joined with 
-- Customers_Master and write a query to detect such violations.
create table Customers_Master(
CustomerID varchar(10),
CustomerName varchar(50),
City varchar(50)
);

insert into Customers_Master(CustomerID, CustomerName, City)
values
('C101', 'Rahul Mehta', 'Mumbai'),
('C102', 'Anjali Rao', 'Bengaluru'),
('C103', 'Suresh Iyer', 'Chennai'),
('C104', 'Neha Singh', 'Delhi');

select * from Customers_Master;

SELECT DISTINCT ct.Customer_ID
FROM customer_txn ct
LEFT JOIN Customers_Master c
ON ct.Customer_ID = c.CustomerID
WHERE c.CustomerID IS NULL;
