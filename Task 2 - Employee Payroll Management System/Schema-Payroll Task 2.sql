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
