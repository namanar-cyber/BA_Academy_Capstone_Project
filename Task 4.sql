-- 1. Create Movie Rental database
CREATE DATABASE MovieRentaldb;
USE MovieRentaldb;

DROP TABLE IF EXISTS rental_data;

CREATE TABLE rental_data (
    MOVIE_ID integer,
    CUSTOMER_ID integer,
    MOVIE_NAME varchar(50),
    GENRE varchar(50),
    RENTAL_DATE date,
    RETURN_DATE date,
    RENTAL_FEE numeric(5,2)
);

-- 3. Insert data
INSERT INTO rental_data (MOVIE_ID, CUSTOMER_ID, MOVIE_NAME, GENRE, RENTAL_DATE, RETURN_DATE, RENTAL_FEE)
VALUES
(1, 101, 'Saiyaara', 'Romantic', '2025-07-01', '2025-07-03', 100),
(2, 102, 'Metro Inn Dino', 'Romantic', '2025-07-02', '2025-07-04', 200),
(3, 103, '3 Idiots', 'Comedy', '2025-07-03', '2025-07-05', 250),
(4, 104, 'Partner', 'Drama', '2025-07-04', '2025-07-06', 180),
(5, 105, 'Jab We Met', 'Romantic', '2025-07-05', '2025-07-07', 210),
(6, 106, 'Gully Boy', 'Drama', '2025-07-06', '2025-07-08', 190),
(7, 107, 'Ek Tah Tiger', 'Action', '2025-07-07', '2025-07-09', 100),
(8, 108, 'Munna Bhai MBBS', 'Drama', '2025-07-08', '2025-07-10', 150),
(9, 109, 'DDLJ', 'Romantic', '2025-07-09', '2025-07-11', 220),
(10, 110, 'Jatt & Juliet', 'Romantic', '2025-07-10', '2025-07-12', 200),
(11, 111, 'Sardarji', 'Drama', '2025-07-11', '2025-07-13', 200),
(12, 112, 'Animal', 'Action', '2025-07-12', '2025-07-14', 250),
(13, 113, 'Shaitaan', 'Drama', '2025-07-13', '2025-07-15', 180),
(14, 114, 'Aashiqui 2', 'Romantic', '2025-07-14', '2025-07-16', 150),
(15, 115, 'Rowdy Rathore', 'Action', '2025-07-15', '2025-07-17', 100);

-- 4. OLAP Operations

SELECT GENRE, MOVIE_NAME, COUNT(*) as Rental_Count, SUM(RENTAL_FEE) as Total_Fee
FROM rental_data
GROUP BY GENRE, MOVIE_NAME
ORDER BY GENRE, MOVIE_NAME;

SELECT COALESCE(GENRE, 'All Genres') as GENRE, SUM(RENTAL_FEE) as Total_Fee
FROM rental_data
GROUP BY GENRE WITH ROLLUP;

SELECT 
    IFNULL(GENRE, 'All Genres') as GENRE,
    IFNULL(DATE_FORMAT(RENTAL_DATE, '%Y-%m-%d'), 'All Dates') as RENTAL_DATE,
    IFNULL(CAST(CUSTOMER_ID AS CHAR), 'All Customers') as CUSTOMER_ID,
    SUM(RENTAL_FEE) as Total_Fee
FROM rental_data
GROUP BY GENRE, RENTAL_DATE, CUSTOMER_ID WITH ROLLUP;


SELECT *
FROM rental_data
WHERE GENRE = 'Action';


SELECT *
FROM rental_data
WHERE (GENRE = 'Action' OR GENRE = 'Drama')
    AND RENTAL_DATE >= DATE_SUB('2025-07-17', INTERVAL 3 MONTH);
