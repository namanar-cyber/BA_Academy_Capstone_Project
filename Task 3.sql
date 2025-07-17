CREATE DATABASE OnlineStore;

USE OnlineStore;
CREATE TABLE Customers (
    CUSTOMER_ID SERIAL PRIMARY KEY,
    NAME VARCHAR(100),
    EMAIL VARCHAR(100),
    PHONE VARCHAR(15),
    ADDRESS TEXT
);

CREATE TABLE Products (
    PRODUCT_ID SERIAL PRIMARY KEY,
    PRODUCT_NAME VARCHAR(100),
    CATEGORY VARCHAR(50),
    PRICE DECIMAL(10,2),
    STOCK INTEGER
);

-- Create Orders Table
CREATE TABLE Orders (
    ORDER_ID SERIAL PRIMARY KEY,
    CUSTOMER_ID INTEGER REFERENCES Customers(CUSTOMER_ID),
    PRODUCT_ID INTEGER REFERENCES Products(PRODUCT_ID),
    QUANTITY INTEGER,
    ORDER_DATE DATE
);

INSERT INTO Customers (NAME, EMAIL, PHONE, ADDRESS) VALUES
('Raj Kapoor', 'raj@email.com', '9876543210', 'Mumbai, Maharashtra'),
('Priya Setty', 'priya@email.com', '9876543211', 'Delhi'),
('Amit Panday', 'amit@email.com', '9876543212', 'Ahmedabad, Gujarat'),
('Neha Singh', 'neha@email.com', '9876543213', 'Bangalore, Karnataka'),
('Suresh Sharma', 'suresh@email.com', '9876543214', 'Hyderabad, Telangana');


INSERT INTO Customers (NAME, EMAIL, PHONE, ADDRESS) VALUES
('Raj Kapoor', 'raj@email.com', '1234567890', 'Mumbai, Maharashtra'),
('Priya Setty', 'priya@email.com', '2345678901', 'Delhi'),
('Amit Panday', 'amit@email.com', '3456789012', 'Ahmedabad, Gujarat'),
('Neha Singh', 'neha@email.com', '4567890123', 'Bangalore, Karnataka'),
('Suresh Sharma', 'suresh@email.com', '5678901234', 'Hyderabad, Telangana');

INSERT INTO Products (PRODUCT_NAME, CATEGORY, PRICE, STOCK) VALUES
('Basmati Rice', 'Groceries', 150.00, 100),
('Masala Dosa', 'Ready-to-Cook', 80.00, 0),
('Pants', 'Clothing', 1500.00, 50),
('Pressure Cooker', 'Kitchen', 999.00, 30),
('Tandoori Spice', 'Spices', 120.00, 75);

INSERT INTO Orders (CUSTOMER_ID, PRODUCT_ID, QUANTITY, ORDER_DATE) VALUES
(1, 1, 2, '2024-01-15'),
(2, 3, 1, '2024-02-20'),
(3, 4, 1, '2024-03-10'),
(4, 2, 3, '2024-03-25'),
(5, 5, 2, '2024-04-01');


SELECT o.ORDER_ID, p.PRODUCT_NAME, o.QUANTITY, o.ORDER_DATE
FROM Orders o
JOIN Products p ON o.PRODUCT_ID = p.PRODUCT_ID
WHERE o.CUSTOMER_ID = 1;

SELECT PRODUCT_NAME, CATEGORY, STOCK
FROM Products
WHERE STOCK = 0;

SELECT p.PRODUCT_NAME, SUM(o.QUANTITY * p.PRICE) as TOTAL_REVENUE
FROM Orders o
JOIN Products p ON o.PRODUCT_ID = p.PRODUCT_ID
GROUP BY p.PRODUCT_NAME;

SELECT c.NAME, SUM(o.QUANTITY * p.PRICE) as TOTAL_PURCHASE
FROM Customers c
JOIN Orders o ON c.CUSTOMER_ID = o.CUSTOMER_ID
JOIN Products p ON o.PRODUCT_ID = p.PRODUCT_ID
GROUP BY c.NAME
ORDER BY TOTAL_PURCHASE DESC
LIMIT 5;

SELECT c.NAME
FROM Customers c
JOIN Orders o ON c.CUSTOMER_ID = o.CUSTOMER_ID
JOIN Products p ON o.PRODUCT_ID = p.PRODUCT_ID
GROUP BY c.NAME
HAVING COUNT(DISTINCT p.CATEGORY) >= 2;

SELECT 
    DATE_FORMAT(ORDER_DATE, '%M %Y') as Month,
    SUM(p.PRICE * o.QUANTITY) as Total_Sales
FROM Orders o
JOIN Products p ON o.PRODUCT_ID = p.PRODUCT_ID
GROUP BY DATE_FORMAT(ORDER_DATE, '%M %Y')
ORDER BY Total_Sales DESC
LIMIT 1;

SELECT PRODUCT_NAME
FROM Products p
WHERE PRODUCT_ID NOT IN (
    SELECT PRODUCT_ID 
    FROM Orders 
    WHERE ORDER_DATE >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
);


SELECT NAME, EMAIL
FROM Customers
WHERE CUSTOMER_ID NOT IN (
    SELECT CUSTOMER_ID 
    FROM Orders
);

SELECT 
    ROUND(AVG(order_total), 2) as Average_Order_Value
FROM (
    SELECT 
        o.ORDER_ID,
        SUM(p.PRICE * o.QUANTITY) as order_total
    FROM Orders o
    JOIN Products p ON o.PRODUCT_ID = p.PRODUCT_ID
    GROUP BY o.ORDER_ID
) as order_summary;


SELECT 
    c.NAME,
    COUNT(o.ORDER_ID) as Total_Orders
FROM Customers c
LEFT JOIN Orders o ON c.CUSTOMER_ID = o.CUSTOMER_ID
GROUP BY c.NAME
ORDER BY Total_Orders DESC;


SELECT 
    p.CATEGORY,
    SUM(p.PRICE * o.QUANTITY) as Total_Revenue
FROM Products p
JOIN Orders o ON p.PRODUCT_ID = o.PRODUCT_ID
GROUP BY p.CATEGORY
ORDER BY Total_Revenue DESC;