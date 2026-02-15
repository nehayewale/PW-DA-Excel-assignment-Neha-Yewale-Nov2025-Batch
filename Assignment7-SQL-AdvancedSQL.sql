-- Dataset (Use for Q6–Q9)
create database product_sale_db;
use product_sale_db;

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
ProductName VARCHAR(100),
Category VARCHAR(50),
Price DECIMAL(10,2)
);
CREATE TABLE Sales (
SaleID INT PRIMARY KEY,
ProductID INT,
Quantity INT,
SaleDate DATE,
FOREIGN KEY (ProductID) REFERENCES Products (ProductID)
);
INSERT INTO Sales VALUES
(1, 1, 4, '2024-01-05'),
(2, 2, 10, '2024-01-06'),
(3, 4, 2, '2024-01-10'),
(4, 4, 1, '2024-01-10');
INSERT INTO Products VALUES
(1, 'Keyboard', 'Electronics', 1200),
(2, 'Mouse', 'Electronics', 800),
(3, 'Chair', 'Furniture', 2500),
(4, 'Desk', 'Furniture', 5500);
select * from products;

select * from sales;

-- Q6. Write a CTE to calculate the total revenue for each product
-- (Revenues = Price × Quantity), and return only products where  revenue > 3000.
with revenueCTE as (
select p.productid, p.productname, sum(p.price * s.quantity) as revenue
from products as p join sales as s
on p.productid = s.productid
group by productid, productname
)
select * from revenueCTE
where  revenue > 3000
order by productid;

-- Q7. Create a view named vw_CategorySummary that shows: Category, TotalProducts, AveragePrice.
create view vw_CategorySummary as 
select p.category, count(DISTINCT p.productid) as TotalProducts, avg(p.price) as AveragePrice
from products as p group by p.category;

-- Q8. Create an updatable view containing ProductID, ProductName, and Price.
 -- Then update the price of ProductID = 1 using the view.
create view updateProductID as
select productid, productname, price from products;
update updateProductID
set price = 2000 where productid = 1;

-- Q9. Create a stored procedure that accepts a category name and returns all products belonging to that category.
create procedure GetProductsByCategory (
in category_name varchar(40)
)

BEGIN
    SELECT 
        ProductID,
        ProductName,
        Category,
        Price
    FROM Products
    WHERE Category = category_name;
END $$

DELIMITER ;
CALL GetProductsByCategory('Electronics');

-- Q10. Create an AFTER DELETE trigger on the Products table that archives deleted product rows into a new
-- table ProductArchive. The archive should store ProductID, ProductName, Category, Price, and DeletedAt
-- timestamp.
CREATE TABLE ProductArchive (
    ProductID INT,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    DeletedAt DATETIME
);
DELIMITER $$

CREATE TRIGGER trg_after_delete_products
AFTER DELETE ON Products
FOR EACH ROW
BEGIN
    INSERT INTO ProductArchive (
        ProductID,
        ProductName,
        Category,
        Price,
        DeletedAt
    )
    VALUES (
        OLD.ProductID,
        OLD.ProductName,
        OLD.Category,
        OLD.Price,
        NOW()
    );
END $$

DELIMITER ;
DELETE FROM Products WHERE ProductID = 3;
SELECT * FROM ProductArchive;
