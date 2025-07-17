-- Create the database
CREATE DATABASE Task_1_LibraryDB;

-- Use the database
USE Task_1_LibraryDB;

-- 1. Create Books table
CREATE TABLE Books (
    BOOK_ID INT PRIMARY KEY,
    TITLE VARCHAR(100),
    AUTHOR VARCHAR(100),
    GENRE VARCHAR(50),
    YEAR_PUBLISHED INT,
    AVAILABLE_COPIES INT
);

-- 2. Create Members table
CREATE TABLE Members (
    MEMBER_ID INT PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE_NO VARCHAR(15),
    ADDRESS VARCHAR(255),
    MEMBERSHIP_DATE DATE
);

-- 3. Create BorrowingRecords table
CREATE TABLE BorrowingRecords (
    BORROW_ID INT PRIMARY KEY,
    MEMBER_ID INT,
    BOOK_ID INT,
    BORROW_DATE DATE,
    RETURN_DATE DATE,
    FOREIGN KEY (MEMBER_ID) REFERENCES Members(MEMBER_ID),
    FOREIGN KEY (BOOK_ID) REFERENCES Books(BOOK_ID)
);

-- Insert into Books
INSERT INTO Books (BOOK_ID, TITLE, AUTHOR, GENRE, YEAR_PUBLISHED, AVAILABLE_COPIES) VALUES
(1, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 1999, 2),
(2, 'Thirukkural', 'Thiruvalluvar', 'Classic Tamil Literature', 500, 4),
(3, 'Ponniyin Selvan', 'Kalki Krishnamurthy', 'Historical Fiction', 1950, 3),
(4, 'One Indian Girl', 'Chetan Bhagat', 'Fiction', 2016, 5),
(5, 'Manimegalai', 'Sattanar', 'Classic Tamil Literature', 600, 2),
(6, 'The White Tiger', 'Aravind Adiga', 'Fiction', 2008, 3),
(7, 'Yavana Rani', 'Sandilyan', 'Historical Fiction', 1963, 2),
(8, 'Playing It My Way', 'Sachin Tendulkar', 'Autobiography', 2014, 1);



-- Insert into Members
INSERT INTO Members (MEMBER_ID, NAME, EMAIL, PHONE_NO, ADDRESS, MEMBERSHIP_DATE) VALUES
(101, 'Ravi', 'ravi@aaLibrary.com', '9876543210', 'Chennai', '2023-01-15'),
(102, 'Priya', 'priya@aaLibrary.com', '9999955555', 'Mumbai', '2023-02-10'),
(103, 'Ram', 'john@aaLibrary.com', '9988776655', 'Bangalore', '2023-03-20'),
(104, 'Meena', 'meena@aaLibrary.com', '9123456780', 'Hyderabad', '2023-04-25'),
(105, 'Rahul', 'rahul@aaLibrary.com', '', 'Pune', '2023-05-30'),
(106, 'Anita', 'anita@aaLibrary.com', '9012345678', 'Coimbatore', '2023-06-12'),
(107, 'Karthik', 'karthik@aaLibrary.com', '9023456789', 'Madurai', '2023-07-08'),
(108, 'Divya', 'divya@aaLibrary.com', '9034567890', 'Trichy', '2023-08-01'),
(109, 'Suresh', 'suresh@aaLibrary.com', '9045678901', 'Salem', '2023-08-18'),
(110, 'Lakshmi', 'lakshmi@aaLibrary.com', '9056789012', 'Tirunelveli', '2023-09-05');
(111, 'Gopal', 'gopal@aaLibrary.com', '9067890123', 'Erode', '2023-09-12'),
(112, 'Sneha', 'sneha@aaLibrary.com', '9078901234', 'Nagercoil', '2023-10-01');


-- Insert into BorrowingRecords
INSERT INTO BorrowingRecords (BORROW_ID, MEMBER_ID, BOOK_ID, BORROW_DATE, RETURN_DATE) VALUES
(201, 101, 1, '2024-06-10', '2024-06-25'),
(202, 102, 2, '2024-05-15', '2024-06-01'),
(203, 102, 3, '2024-06-25', NULL),
(204, 103, 4, '2024-06-20', '2024-07-01'),
(205, 104, 5, '2024-05-05', NULL),
(206, 105, 6, '2024-06-28', NULL),
(207, 102, 7, '2024-07-01', NULL),
(208, 103, 1, '2024-06-15', '2024-07-05'),
(209, 101, 8, '2024-07-05', NULL);
(210, 102, 5, '2024-07-10', NULL),
(211, 102, 4, '2024-07-11', NULL);
(212, 106, 3, '2024-07-01', NULL),
(213, 107, 3, '2024-07-02', NULL),
(214, 108, 3, '2024-07-03', NULL),
(215, 109, 3, '2024-07-04', NULL),
(216, 110, 3, '2024-07-05', NULL),
(217, 101, 3, '2024-07-06', NULL),
(218, 104, 3, '2024-07-07', NULL);

select *
from Members

                             -- Information Retrieval:
-- a) Retrieve a list of books currently borrowed by a specific member.

SELECT B.TITLE, B.AUTHOR, BR.BORROW_DATE
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
WHERE M.NAME = 'Priya' AND BR.RETURN_DATE IS NULL;

-- b) Find members who have overdue books (borrowed more than 30 days ago, not returned).
SELECT M.NAME, M.EMAIL, BR.BORROW_DATE
FROM BorrowingRecords BR
JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
WHERE BR.RETURN_DATE IS NULL 
  AND BR.BORROW_DATE < CURDATE() - INTERVAL 30 DAY;


-- c) Retrieve books by genre along with the count of available copies.
SELECT GENRE, COUNT(*) AS NUM_BOOKS, SUM(AVAILABLE_COPIES) AS TOTAL_AVAILABLE_COPIES
FROM Books
GROUP BY GENRE;


-- d) Find the most borrowed book(s) overall.
SELECT B.TITLE, COUNT(*) AS TIMES_BORROWED
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
GROUP BY B.TITLE
ORDER BY TIMES_BORROWED DESC
LIMIT 1;

-- e) Retrieve members who have borrowed books from at least three different genres.
SELECT M.NAME, COUNT(DISTINCT B.GENRE) AS GENRE_COUNT
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
GROUP BY M.NAME;


               -- Reporting and Analytics:
-- a) Calculate the total number of books borrowed per month.

SELECT 
DATE_FORMAT(BORROW_DATE, '%Y-%m') AS MONTH,
COUNT(*) AS TOTAL_BORROWED
FROM BorrowingRecords
GROUP BY MONTH
ORDER BY MONTH;

-- b) Find the top three most active members based on the number of books borrowed.
SELECT 
    M.MEMBER_ID,
    M.NAME,
    COUNT(BR.BORROW_ID) AS Books_Borrowed
FROM BorrowingRecords BR
JOIN Members M ON BR.MEMBER_ID = M.MEMBER_ID
GROUP BY M.MEMBER_ID, M.NAME
ORDER BY Books_Borrowed DESC
LIMIT 3;

-- c) Retrieve authors whose books have been borrowed at least 10 times.
SELECT 
    B.AUTHOR,
    COUNT(BR.BORROW_ID) AS Times_Borrowed
FROM BorrowingRecords BR
JOIN Books B ON BR.BOOK_ID = B.BOOK_ID
GROUP BY B.AUTHOR
HAVING COUNT(BR.BORROW_ID) >= 3
ORDER BY Times_Borrowed DESC;

-- d) Identify members who have never borrowed a book.
SELECT M.MEMBER_ID, M.NAME
FROM Members M
LEFT JOIN BorrowingRecords BR ON M.MEMBER_ID = BR.MEMBER_ID
WHERE BR.MEMBER_ID IS NULL;

