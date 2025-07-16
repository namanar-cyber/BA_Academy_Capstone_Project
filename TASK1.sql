CREATE DATABASE library_management;
USE library_management;

CREATE TABLE Books (
    BOOK_ID INT PRIMARY KEY,
    TITLE VARCHAR(100) NOT NULL,
    AUTHOR VARCHAR(100) NOT NULL,
    GENRE VARCHAR(50),
    YEAR_PUBLISHED INT,
    AVAILABLE_COPIES INT DEFAULT 0
);

CREATE TABLE Members (
    MEMBER_ID INT PRIMARY KEY,
    NAME VARCHAR(100) NOT NULL,
    EMAIL VARCHAR(100) UNIQUE,
    PHONE_NO VARCHAR(20),
    ADDRESS TEXT,
    MEMBERSHIP_DATE DATE
);

CREATE TABLE BorrowingRecords (
    BORROW_ID INT PRIMARY KEY,
    MEMBER_ID INT,
    BOOK_ID INT,
    BORROW_DATE DATE,
    RETURN_DATE DATE,
    FOREIGN KEY (MEMBER_ID) REFERENCES Members(MEMBER_ID),
    FOREIGN KEY (BOOK_ID) REFERENCES Books(BOOK_ID)
);

INSERT INTO Books VALUES
(1, 'Five Point Someone', 'Chetan Bhagat', 'Fiction', 2004, 3),
(2, 'The God of Small Things', 'Arundhati Roy', 'Literary Fiction', 1997, 2),
(3, 'The Inheritance of Loss', 'Kiran Desai', 'Literary Fiction', 2006, 1),
(4, 'A Suitable Boy', 'Vikram Seth', 'Fiction', 1993, 4),
(5, 'Midnight''s Children', 'Salman Rushdie', 'Magical Realism', 1981, 2);

INSERT INTO Members VALUES
(1, 'Rahul Sharma', 'rahul@email.com', '9876543210', 'Bandra, Mumbai', '2023-01-01'),
(2, 'Priya Patel', 'priya@email.com', '9876543211', 'Indiranagar, Bangalore', '2023-02-15'),
(3, 'Amit Kumar', 'amit@email.com', '9876543212', 'Salt Lake, Kolkata', '2023-03-20'),
(4, 'Ananya Singh', 'ananya@email.com', '9876543213', 'Connaught Place, Delhi', '2023-04-05'),
(5, 'Vikram Mehta', 'vikram@email.com', '9876543214', 'Jubilee Hills, Hyderabad', '2023-05-10');

INSERT INTO BorrowingRecords VALUES
(1, 1, 1, '2023-06-01', '2023-06-15'),
(2, 2, 3, '2023-06-10', NULL),
(3, 3, 2, '2023-06-15', '2023-06-30'),
(4, 1, 4, '2023-07-01', NULL),
(5, 2, 5, '2023-07-05', '2023-07-20');

SELECT DATE_FORMAT(BORROW_DATE, '%Y-%m') as MONTH,
       COUNT(*) as TOTAL_BORROWED
FROM BorrowingRecords
GROUP BY MONTH
ORDER BY MONTH;

SELECT m.NAME, COUNT(*) as BOOKS_BORROWED
FROM Members m
JOIN BorrowingRecords br ON m.MEMBER_ID = br.MEMBER_ID
GROUP BY m.MEMBER_ID, m.NAME
ORDER BY BOOKS_BORROWED DESC
LIMIT 3;

SELECT b.AUTHOR, COUNT(*) as TOTAL_BORROWS
FROM Books b
JOIN BorrowingRecords br ON b.BOOK_ID = br.BOOK_ID
GROUP BY b.AUTHOR
HAVING TOTAL_BORROWS >= 10;

MEMBER_IDMEMBER_IDMEMBER_IDSELECT m.NAME
FROM Members m
LEFT JOIN BorrowingRecords br ON m.MEMBER_ID = br.MEMBER_ID
WHERE br.BORROW_ID IS NULL;

