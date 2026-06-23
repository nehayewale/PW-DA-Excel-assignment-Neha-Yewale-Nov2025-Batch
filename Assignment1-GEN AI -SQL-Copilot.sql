-- Question 1
CREATE TABLE SalesData
(
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    City VARCHAR(50),
    PurchaseAmount DECIMAL(10,2),
    PurchaseDate DATE
);

SET NOCOUNT ON;

DECLARE @Counter INT = 1;

WHILE @Counter <= 10000
BEGIN

    INSERT INTO SalesData
    (
        Name,
        Age,
        City,
        PurchaseAmount,
        PurchaseDate
    )
    VALUES
    (
        CONCAT('Customer_', @Counter),
        FLOOR(RAND(CHECKSUM(NEWID())) * 43) + 18,
        CHOOSE(
            FLOOR(RAND(CHECKSUM(NEWID())) * 5) + 1,
            'Mumbai',
            'Pune',
            'Delhi',
            'Bangalore',
            'Hyderabad'
        ),
        CAST((RAND(CHECKSUM(NEWID())) * 50000) + 500 AS DECIMAL(10,2)),
        DATEADD(
            DAY,
            -FLOOR(RAND(CHECKSUM(NEWID())) * 365),
            GETDATE()
        )
    );

    SET @Counter = @Counter + 1;
END;

SELECT TOP 10 *
FROM SalesData;

-- Question 2
SELECT
    City,
    SUM(PurchaseAmount) AS TotalSales
FROM SalesData
GROUP BY City
ORDER BY TotalSales DESC;

SELECT TOP 5
    City,
    SUM(PurchaseAmount) AS Revenue
FROM SalesData
GROUP BY City
ORDER BY Revenue DESC;

--Question 3
SELECT
    CustomerID,
    Name,
    City,
    PurchaseAmount
FROM SalesData
WHERE PurchaseAmount >
(
    SELECT AVG(PurchaseAmount)
    FROM SalesData
)
ORDER BY PurchaseAmount DESC;