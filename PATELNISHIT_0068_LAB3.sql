-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Lab Experiment 03: Implementation of different types of SQL functions.

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- STUDENT NAME: PATEL NISHITKUMAR
-- USN: 1RUA24SCS0068
-- SECTION: B
-- -----------------------------------------------------------------------------------------------------------------------------------------
SELECT USER(), 
       @@hostname AS Host_Name, 
       VERSION() AS MySQL_Version, 
       NOW() AS Current_Date_Time;

-- Paste the Output below by execution of above command
--  root@localhost	NISHIT	8.0.43	2025-10-16 12:16:46

-- -----------------------------------------------------------------------------------------------------------------------------------------
-- PreCoded Relational Schema and Instance.
-- -----------------------------------------------------------------------------------------------------------------------------------------
USE DB_LAB;

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Salary DECIMAL(10, 2),
    BirthDate DATE,
    HireDate DATE
);

INSERT INTO Employees (FirstName, LastName, Salary, BirthDate, HireDate) VALUES
('John', 'Doe', 55000.30, '1985-06-15', '2010-01-20'),
('Jane', 'Smith', 65000.50, '1990-08-22', '2012-07-10'),
('Alice', 'Johnson', 72000.10, '1982-11-30', '2015-05-25'),
('Bob', 'Brown', 48000.90, '1978-03-12', '2018-09-15');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Orders (OrderDate, TotalAmount, EmployeeID) VALUES
('2024-07-15', 250.00, 1),
('2024-08-10', 175.50, 2),
('2024-09-01', 300.00, 3),
('2024-09-10', 450.75, 1),
('2024-08-25', 123.40, 4);
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Print the Information of the Employee and Order Table. [ Hint: SELECT * FROM TABLENAME ]
-- Write the SQL Query below this line.
SELECT * FROM EMPLOYEES;
SELECT * FROM ORDERS;


-- Output (EMPLOYEES): 
/* 
1	John	Doe	55000.30	1985-06-15	2010-01-20
2	Jane	Smith	65000.50	1990-08-22	2012-07-10
3	Alice	Johnson	72000.10	1982-11-30	2015-05-25
4	Bob	Brown	48000.90	1978-03-12	2018-09-15
*/

-- OUTPUT(ORDERS):
/*
1	2024-07-15	250.00	1
2	2024-08-10	175.50	2
3	2024-09-01	300.00	3
4	2024-09-10	450.75	1
5	2024-08-25	123.40	4
*/


-- -----------------------------------------------------------------------------------------------------------------------------------------
-- Number Functions Section
-- ------------------------------------------------------------
/* a. Round Salaries: Round employee salaries to nearest integer */
SELECT EmployeeID, FirstName, 
ROUND(Salary) AS RoundedSalary
FROM Employees;

/* OUTPUT:
1	John	55000
2	Jane	65001
3	Alice	72000
4	Bob	    48001
*/

/* b. Absolute Values: Show absolute values of salaries */
SELECT EmployeeID, FirstName,
ABS(Salary) AS AbsoluteSalary
FROM Employees;

/* OUTPUT:
1	John	55000.30
2	Jane	65000.50
3	Alice	72000.10
4	Bob		48000.90
*/

/* c. Ceiling Values: Get ceiling values of order amounts */
SELECT OrderID, EmployeeID,
CEIL(TotalAmount) AS CeilingAmount
FROM Orders;

/* OUTPUT:
1	1	250
2	2	176
3	3	300
4	1	451
5	4	124
*/

-- ------------------------------------------------------------
-- Aggregate Functions Section
-- ------------------------------------------------------------
/* a. Count of Employees: Find total number of employees */
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- Output: 4

/* b. Sum of Salaries: Calculate total salary expense */
SELECT SUM(Salary) AS TotalSalary FROM Employees;

-- Output: 240001.80

/* c. Average Order Amount: Find average order value */
SELECT AVG(SALARY) AS Averagesalary FROM EMPLOYEES;

-- Output: 60000.450000

/* d. Max/Min Salary: Find highest and lowest salaries */
SELECT MAX(SALARY) AS MaxSalary, MIN(SALARY) AS MinSalary FROM EMPLOYEES;

-- Output: 72000.10	48000.90

-- ------------------------------------------------------------
-- Character Functions Section
-- ------------------------------------------------------------
/* a. Case Conversion: Show names in uppercase and lowercase */
SELECT EmployeeID, FirstName,
UPPER(FirstName) AS Name_Uppercase,
LOWER(FirstName) AS Name_Lowercase
FROM Employees;

/* Output: 
1	John	JOHN	john
2	Jane	JANE	jane
3	Alice	ALICE	alice
4	Bob		BOB		bob
*/

/* b. Concatenate Names: Create full names */
SELECT EmployeeID, 
CONCAT(FirstName, ' ', LastName) AS FullName
FROM Employees;

/* Output:
1	John Doe
2	Jane Smith
3	Alice Johnson
4	Bob Brown
*/

/* c. Extract Substring: Get first 3 characters of first names */
SELECT EmployeeID, FirstName,
SUBSTRING(FirstName, 1, 3) AS First3Chars
FROM Employees;

/* Output: 
1	John	Joh
2	Jane	Jan
3	Alice	Ali
4	Bob	Bob
*/

-- ------------------------------------------------------------
-- Conversion Functions Section
-- ------------------------------------------------------------
/* Convert String to Date: Convert text to DATE type */
SELECT STR_TO_DATE(HIREDATE, '%Y-%m-%d') FROM EMPLOYEES;

/* Output: 
2010-01-20
2012-07-10
2015-05-25
2018-09-15
*/

-- ------------------------------------------------------------
-- Date Functions Section
-- ------------------------------------------------------------
/* a. Current Date/Time: Get current timestamp */
SELECT CURRENT_TIMESTAMP AS CurrentDateTime;

-- Output: 2025-10-16 13:03:27

/* b. Extract Year: Get year from order dates */
SELECT OrderID, YEAR(OrderDate) AS OrderYear
FROM Orders;

/* Output: 
1	2024
2	2024
3	2024
4	2024
5	2024
*/

/* c. Add Months: Add 3 months to order dates */
SELECT OrderID, OrderDate,
DATE_ADD(OrderDate, INTERVAL 3 MONTH) AS NewOrderDate
FROM Orders;

/* Output: 
1	2024-07-15	2024-10-15
2	2024-08-10	2024-11-10
3	2024-09-01	2024-12-01
4	2024-09-10	2024-12-10
5	2024-08-25	2024-11-25
*/

/* d. Days Since Order: Calculate days between order date and now */
SELECT OrderID, OrderDate, DATEDIFF(CURDATE(), OrderDate) AS DaysSinceOrder
FROM Orders
LIMIT 2000;

/* Output: 
1	2024-07-15	458
2	2024-08-10	432
3	2024-09-01	410
4	2024-09-10	401
5	2024-08-25	417
*/

-- END of the Task -- 