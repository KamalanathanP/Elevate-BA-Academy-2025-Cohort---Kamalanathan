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

