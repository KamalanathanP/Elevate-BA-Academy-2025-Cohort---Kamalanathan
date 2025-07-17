-- Create the database
CREATE DATABASE OnlineStore_db;

-- Use the database
USE OnlineStore_db;

     -- Create the Tables
-- Customers Table
CREATE TABLE Customers (
    CUSTOMER_ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE VARCHAR(15),
    ADDRESS VARCHAR(255)
);

-- Products Table
CREATE TABLE Products (
    PRODUCT_ID INT PRIMARY KEY AUTO_INCREMENT,
    PRODUCT_NAME VARCHAR(100),
    CATEGORY VARCHAR(50),
    PRICE DECIMAL(10,2),
    STOCK INT
);

-- Orders Table
CREATE TABLE Orders (
    ORDER_ID INT PRIMARY KEY AUTO_INCREMENT,
    CUSTOMER_ID INT,
    PRODUCT_ID INT,
    QUANTITY INT,
    ORDER_DATE DATE,
    FOREIGN KEY (CUSTOMER_ID) REFERENCES Customers(CUSTOMER_ID),
    FOREIGN KEY (PRODUCT_ID) REFERENCES Products(PRODUCT_ID)
);

            -- Inserting data
-- Insert into Customers
INSERT INTO Customers (NAME, EMAIL, PHONE, ADDRESS) VALUES
('Ravi', 'ravi@icleaf.com', '9876543210', 'Chennai'),
('Priya', 'priya@icleaf.com', '9887654321', 'Bangalore'),
('Karthik', 'karthik@icleaf.com', '9898765432', 'Hyderabad'),
('Divya', 'divya@icleaf.com', '9876123450', 'Mumbai'),
('Arjun', 'arjun@icleaf.com', '9823456789', 'Pune');

-- Insert into Products
INSERT INTO Products (PRODUCT_NAME, CATEGORY, PRICE, STOCK) VALUES
('Wireless Mouse', 'Electronics', 499.00, 50),
('Gaming Keyboard', 'Electronics', 1499.00, 30),
('Water Bottle', 'Home & Kitchen', 299.00, 100),
('Running Shoes', 'Footwear', 2499.00, 25),
('Notebook', 'Stationery', 99.00, 200),
('Bluetooth Speaker', 'Electronics', 1999.00, 15);

-- Insert into Orders
INSERT INTO Orders (CUSTOMER_ID, PRODUCT_ID, QUANTITY, ORDER_DATE) VALUES
(1, 1, 2, '2024-07-01'),
(2, 3, 1, '2024-07-02'),
(3, 2, 1, '2024-07-03'),
(4, 4, 1, '2024-07-03'),
(1, 5, 5, '2024-07-04'),
(5, 6, 1, '2024-07-05'),
(2, 1, 1, '2024-07-06'),
(3, 5, 10, '2024-07-07'),
(4, 2, 2, '2024-07-08');

SELECT * 
FROM Customers

SELECT * 
FROM Products

SELECT * 
FROM Orders

           -- Order Management queries
-- a) Retrieve all orders placed by a specific customer.
SELECT 
    O.ORDER_ID,
    C.NAME AS CUSTOMER_NAME,
    P.PRODUCT_NAME,
    O.QUANTITY,
    O.ORDER_DATE
FROM Orders O
JOIN Customers C ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
WHERE C.NAME = 'Priya';

-- b) Find products that are out of stock.
SELECT PRODUCT_ID, PRODUCT_NAME, CATEGORY, PRICE
FROM Products
WHERE STOCK = 0;

UPDATE Products
SET STOCK = 0
WHERE PRODUCT_ID = 3;

-- c) Calculate the total revenue generated per product.
SELECT 
    P.PRODUCT_ID,
    P.PRODUCT_NAME,
    SUM(O.QUANTITY * P.PRICE) AS TOTAL_REVENUE
FROM Orders O
JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
GROUP BY P.PRODUCT_ID, P.PRODUCT_NAME
ORDER BY TOTAL_REVENUE DESC;

-- d) Retrieve the top 5 customers by total purchase amount.
SELECT 
    C.CUSTOMER_ID,
    C.NAME AS CUSTOMER_NAME,
    SUM(O.QUANTITY * P.PRICE) AS TOTAL_SPENT
FROM Orders O
JOIN Customers C ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
GROUP BY C.CUSTOMER_ID, C.NAME
ORDER BY TOTAL_SPENT DESC
LIMIT 5;

-- e) Find customers who placed orders in at least two different product categories.
SELECT 
    C.CUSTOMER_ID,
    C.NAME AS CUSTOMER_NAME,
    COUNT(DISTINCT P.CATEGORY) AS CATEGORY_COUNT
FROM Orders O
JOIN Customers C ON O.CUSTOMER_ID = C.CUSTOMER_ID
JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
GROUP BY C.CUSTOMER_ID, C.NAME
HAVING CATEGORY_COUNT >= 2;

       -- Analytics
-- a) Find the month with the highest total sales.
SELECT 
    DATE_FORMAT(O.ORDER_DATE, '%Y-%m') AS ORDER_MONTH,
    SUM(O.QUANTITY * P.PRICE) AS TOTAL_SALES
FROM Orders O
JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID
GROUP BY ORDER_MONTH
ORDER BY TOTAL_SALES DESC
LIMIT 1;

-- b) Identify products with no orders in the last 6 months.
SELECT P.PRODUCT_ID, P.PRODUCT_NAME, P.CATEGORY
FROM Products P
WHERE P.PRODUCT_ID NOT IN (
    SELECT DISTINCT PRODUCT_ID
    FROM Orders
    WHERE ORDER_DATE >= CURDATE() - INTERVAL 6 MONTH
);

-- adding inputs to customers 
INSERT INTO Customers (NAME, EMAIL, PHONE, ADDRESS)
VALUES ('Sneha', 'sneha@icleaf.com', '9090909090', 'Coimbatore');


-- c) Retrieve customers who have never placed an order.
SELECT C.CUSTOMER_ID, C.NAME, C.EMAIL
FROM Customers C
LEFT JOIN Orders O ON C.CUSTOMER_ID = O.CUSTOMER_ID
WHERE O.CUSTOMER_ID IS NULL;

-- d) Calculate the average order value across all orders.
SELECT 
    ROUND(AVG(O.QUANTITY * P.PRICE), 2) AS AVERAGE_ORDER_VALUE
FROM Orders O
JOIN Products P ON O.PRODUCT_ID = P.PRODUCT_ID;
