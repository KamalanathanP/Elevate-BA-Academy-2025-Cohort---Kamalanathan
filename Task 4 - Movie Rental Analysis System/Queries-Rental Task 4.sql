-- Create the database
CREATE DATABASE MovieRental_db;

-- Use the database
USE MovieRental_db;

     -- Create the Tables
-- Create rental_data Table
CREATE TABLE rental_data (
    MOVIE_ID INT,
    CUSTOMER_ID INT,
    GENRE VARCHAR(50),
    RENTAL_DATE DATE,
    RETURN_DATE DATE,
    RENTAL_FEE DECIMAL(10,2)
);

-- Insert into rental_data Table
INSERT INTO rental_data (MOVIE_ID, CUSTOMER_ID, GENRE, RENTAL_DATE, RETURN_DATE, RENTAL_FEE) VALUES
(101, 1, 'Action', '2024-06-01', '2024-06-03', 120.00),
(102, 2, 'Comedy', '2024-06-02', '2024-06-04', 100.00),
(103, 3, 'Drama', '2024-06-02', '2024-06-05', 130.00),
(101, 1, 'Action', '2024-06-10', '2024-06-12', 120.00),
(104, 4, 'Thriller', '2024-06-11', '2024-06-13', 140.00),
(105, 5, 'Comedy', '2024-06-15', '2024-06-17', 110.00),
(106, 6, 'Drama', '2024-06-18', '2024-06-20', 130.00),
(107, 2, 'Action', '2024-06-20', '2024-06-21', 150.00),
(108, 7, 'Thriller', '2024-06-22', '2024-06-24', 140.00),
(109, 8, 'Comedy', '2024-06-25', '2024-06-27', 105.00),
(110, 9, 'Action', '2024-06-26', '2024-06-28', 125.00),
(111, 10, 'Drama', '2024-06-27', '2024-06-29', 135.00),
(112, 3, 'Comedy', '2024-06-28', '2024-06-30', 115.00),
(113, 4, 'Action', '2024-06-29', '2024-07-01', 150.00),
(114, 1, 'Thriller', '2024-06-30', '2024-07-02', 145.00);


SELECT * 
FROM rental_data


            -- OLAP Operations:
-- a) Drill Down: Analyze rentals from genre to individual movie level.
SELECT 
    GENRE,
    RENTAL_DATE,
    SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
FROM rental_data
GROUP BY GENRE, RENTAL_DATE
ORDER BY GENRE, RENTAL_DATE;

-- b) Rollup: Summarize total rental fees by genre and then overall.
SELECT 
    GENRE,
    SUM(RENTAL_FEE) AS TOTAL_RENTAL_FEE
FROM rental_data
GROUP BY GENRE WITH ROLLUP;

-- c) Cube: Analyze total rental fees across combinations of genre, rental date, and customer.
SELECT *
FROM rental_data
WHERE GENRE = 'Action';

-- d) Slice: Extract rentals only from the ‘Action’ genre.
SELECT *
FROM rental_data
WHERE CUSTOMER_ID IN (1, 2)
  AND GENRE IN ('Action', 'Comedy');

-- e) Dice: Extract rentals where GENRE = 'Action' or 'Drama' and RENTAL_DATE is in the last 3 months.
SELECT 
    DATE_FORMAT(RENTAL_DATE, '%Y-%m') AS RENTAL_MONTH,
    SUM(RENTAL_FEE) AS TOTAL_REVENUE
FROM rental_data
GROUP BY RENTAL_MONTH
ORDER BY RENTAL_MONTH;
