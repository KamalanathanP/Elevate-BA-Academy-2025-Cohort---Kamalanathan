-- Create the database
CREATE DATABASE payroll_db;

-- Use the database
USE payroll_db;

-- Create employees Table
CREATE TABLE employees (
    EMPLOYEE_ID INT PRIMARY KEY AUTO_INCREMENT,
    NAME VARCHAR(100),
    DEPARTMENT VARCHAR(50),
    EMAIL VARCHAR(100),
    PHONE_NO VARCHAR(15),
    JOINING_DATE DATE,
    SALARY DECIMAL(10,2),
    BONUS DECIMAL(10,2),
    TAX_PERCENTAGE DECIMAL(5,2)
);

-- Insert Sample Employee Records
INSERT INTO employees (NAME, DEPARTMENT, EMAIL, PHONE_NO, JOINING_DATE, SALARY, BONUS, TAX_PERCENTAGE) VALUES
('Ravi', 'Sales', 'ravi@icleaf.com', '9876543210', '2023-01-10', 85000, 5000, 10),
('Priya', 'HR', 'priya@icleaf.com', '9887654321', '2023-03-05', 72000, 4000, 8),
('Amit', 'Sales', 'amit@icleaf.com', '9898765432', '2022-11-15', 96000, 7000, 12),
('Divya', 'IT', 'divya@icleaf.com', '9876123450', '2023-06-20', 110000, 10000, 15),
('Karthik', 'Finance', 'karthik@icleaf.com', '9823456789', '2023-02-25', 95000, 8000, 10),
('Meena', 'IT', 'meena@icleaf.com', '9845678910', '2022-12-10', 105000, 9000, 12),
('Arjun', 'HR', 'arjun@icleaf.com', '9812345678', '2023-07-01', 80000, 6000, 9),
('Suresh', 'Finance', 'suresh@icleaf.com', '9878098765', '2023-01-20', 92000, 7000, 11),
('Lakshmi', 'Sales', 'lakshmi@icleaf.com', '9867543210', '2022-10-15', 99000, 9000, 10),
('Anjali', 'IT', 'anjali@icleaf.com', '9843210987', '2023-04-12', 115000, 9500, 14);

Select *
From employees

           -- Payroll Queries
-- a) Retrieve the list of employees sorted by salary in descending order
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, SALARY
FROM employees
ORDER BY SALARY DESC;

-- b) Find employees with a total compensation (SALARY + BONUS) greater than $100,000.
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, SALARY, BONUS, 
       (SALARY + BONUS) AS TOTAL_COMPENSATION
FROM employees
WHERE (SALARY + BONUS) > 100000
ORDER BY TOTAL_COMPENSATION DESC;

-- c) Update the bonus for employees in the ‘Sales’ department by 10%.
-- Update 10%

SET SQL_SAFE_UPDATES = 0;
UPDATE employees
SET BONUS = BONUS * 1.10
WHERE DEPARTMENT = 'Sales';
SET SQL_SAFE_UPDATES = 1;

-- Result after 10%
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, BONUS
FROM employees
WHERE DEPARTMENT = 'Sales';

SELECT *
FROM employees;

-- d) Calculate the net salary after deducting tax for all employees
SELECT 
    EMPLOYEE_ID,
    NAME,
    SALARY,
    BONUS,
    TAX_PERCENTAGE,
    (SALARY + BONUS) AS GROSS_SALARY,
    ROUND((SALARY + BONUS) * (1 - (TAX_PERCENTAGE / 100)), 2) AS NET_SALARY
FROM employees;

-- e) Retrieve the average, minimum, and maximum salary per department
SELECT 
    DEPARTMENT,
    ROUND(AVG(SALARY), 2) AS AVERAGE_SALARY,
    MIN(SALARY) AS MIN_SALARY,
    MAX(SALARY) AS MAX_SALARY
FROM employees
GROUP BY DEPARTMENT;

-- adding some entry
INSERT INTO employees (NAME, DEPARTMENT, EMAIL, PHONE_NO, JOINING_DATE, SALARY, BONUS, TAX_PERCENTAGE)
VALUES ('Gopal', 'IT', 'gopal@icleaf.com', '9090909090', '2025-05-20', 85000, 7000, 10);


      -- Advanced Queries
-- a) Retrieve employees who joined in the last 6 months.      
SELECT EMPLOYEE_ID, NAME, DEPARTMENT, JOINING_DATE
FROM employees
WHERE JOINING_DATE >= CURDATE() - INTERVAL 6 MONTH;

-- b) Group employees by department and count how many employees each has.
SELECT 
    DEPARTMENT,
    COUNT(*) AS TOTAL_EMPLOYEES
FROM employees
GROUP BY DEPARTMENT;

-- c) Find the department with the highest average salary.
SELECT DEPARTMENT, 
       ROUND(AVG(SALARY), 2) AS AVERAGE_SALARY
FROM employees
GROUP BY DEPARTMENT
ORDER BY AVERAGE_SALARY DESC
LIMIT 1;

-- d) Identify employees who have the same salary as at least one other employee.
SELECT EMPLOYEE_ID, NAME, SALARY
FROM employees
WHERE SALARY IN (
    SELECT SALARY
    FROM employees
    GROUP BY SALARY
    HAVING COUNT(*) > 1
)
ORDER BY SALARY;
