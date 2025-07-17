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
