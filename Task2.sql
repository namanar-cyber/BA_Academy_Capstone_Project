CREATE DATABASE payroll_database;

CREATE TABLE employees (
    EMPLOYEE_ID INTEGER PRIMARY KEY,
    NAME TEXT,
    DEPARTMENT TEXT,
    EMAIL TEXT,
    PHONE_NO NUMERIC,
    JOINING_DATE DATE,
    SALARY NUMERIC,
    BONUS NUMERIC,
    TAX_PERCENTAGE NUMERIC
);
INSERT INTO employees VALUES
(1, 'Raj Shamani', 'Sales', 'raj.shamani@company.com', 9876543210, '2023-12-15', 85000, 5000, 10),
(2, 'Priya Panday', 'IT', 'priya.panday@company.com', 9876543211, '2023-08-20', 95000, 8000, 12),
(3, 'Amit Kapoor', 'HR', 'amit.kapoor@company.com', 9876543212, '2024-01-10', 75000, 4000, 8),
(4, 'Neha Verma', 'Sales', 'neha.verma@company.com', 9876543213, '2023-11-05', 82000, 6000, 10),
(5, 'Honey Singh', 'IT', 'honey.singh@company.com', 9876543214, '2023-09-30', 98000, 9000, 12),
(6, 'Meet Singh', 'Finance', 'meet.singh@company.com', 9876543215, '2024-02-15', 88000, 7000, 11),
(7, 'Karthik Iyer', 'IT', 'karthik.iyer@company.com', 9876543216, '2023-07-01', 92000, 8500, 12),
(8, 'Anita Desai', 'HR', 'anita.desai@company.com', 9876543217, '2024-03-01', 72000, 3500, 8),
(9, 'Rohit Malhotra', 'Sales', 'rohit.malhotra@company.com', 9876543218, '2023-10-12', 86000, 5500, 10),
(10, 'Deepa Goyal', 'Finance', 'deepa.goyal@company.com', 9876543219, '2023-12-20', 84000, 6500, 11);

-- a) Employees sorted by salary
SELECT NAME, SALARY FROM employees ORDER BY SALARY DESC;

-- b) Employees with total compensation > $100,000
SELECT NAME, (SALARY + BONUS) as TOTAL_COMPENSATION 
FROM employees 
WHERE (SALARY + BONUS) > 100000;

-- c) Update bonus for Sales department
UPDATE employees 
SET BONUS = BONUS * 1.10 
WHERE DEPARTMENT = 'Sales';

-- d) Calculate net salary after tax
SELECT NAME, 
       SALARY, 
       (SALARY * (1 - TAX_PERCENTAGE/100)) as NET_SALARY 
FROM employees;


SELECT DEPARTMENT, 
       AVG(SALARY) as AVG_SALARY,
       MIN(SALARY) as MIN_SALARY,
       MAX(SALARY) as MAX_SALARY 
FROM employees 
GROUP BY DEPARTMENT;

-- a) Recent employees (last 6 months)
SELECT NAME, JOINING_DATE 
FROM employees 
WHERE JOINING_DATE > '2023-12-17'; 

-- b) Employee count by department
SELECT DEPARTMENT, COUNT(1) as COUNT
FROM employees 
GROUP BY DEPARTMENT;

-- c) Department with highest average salary
WITH dept_avg AS (
    SELECT DEPARTMENT, AVG(SALARY) as AVG_SAL
    FROM employees 
    GROUP BY DEPARTMENT
)
SELECT * FROM dept_avg 
WHERE AVG_SAL = (SELECT MAX(AVG_SAL) FROM dept_avg);

-- d) Employees with matching salaries
SELECT DISTINCT a.NAME, a.SALARY
FROM employees a, employees b
WHERE a.SALARY = b.SALARY 
AND a.EMPLOYEE_ID <> b.EMPLOYEE_ID;
