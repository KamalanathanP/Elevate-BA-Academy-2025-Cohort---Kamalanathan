
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
