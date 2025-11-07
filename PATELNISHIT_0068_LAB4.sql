-- ======================================================================
-- Lab Experiment 04 – Implementation of Different Types of Operators in SQL
-- ======================================================================

-- Step 1: Create Database
DROP DATABASE IF EXISTS OperatorLab;
CREATE DATABASE OperatorLab;
USE OperatorLab;

-- Step 2: Create Tables
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Salary DECIMAL(10, 2),
    Department VARCHAR(50),
    HireDate DATE,
    Address VARCHAR(100)
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Step 3: Insert Sample Data
INSERT INTO Employees (EmployeeID, Name, Age, Salary, Department, HireDate, Address) VALUES
(1001, 'Ashish', 28, 60000, 'IT', '2024-05-01', '123 Main St, New York'),
(1002, 'Binay', 45, 80000, 'HR', '2020-07-15', '456 Elm St, Chicago'),
(1003, 'Charlie', 32, 55000, 'Finance', '2022-01-10', '789 Oak St, Los Angeles'),
(1004, 'Dhruv', 38, 75000, 'HR', '2021-10-30', '101 Pine St, New York');

INSERT INTO Departments (DepartmentID, DepartmentName, EmployeeID) VALUES
(1, 'IT', 1001),
(2, 'HR', 1002),
(3, 'Finance', 1003);

-- ======================================================================
-- PRACTICE TASKS
-- ======================================================================

-- ========================
-- Exercise 1: Arithmetic Operators
-- ========================

-- a. Add a bonus (10% of Salary) to each employee's salary.
-- WRITE YOUR QUERY BELOW
SET SQL_SAFE_UPDATES = 0;
UPDATE Employees
SET Salary = Salary + (Salary * 0.10);
SET SQL_SAFE_UPDATES = 1;

SELECT EmployeeID, Name, Salary FROM Employees;
/* OUTPUT:
1001	Ashish	66000.00
1002	Binay	88000.00
1003	Charlie	60500.00
1004	Dhruv	82500.00
*/


-- b. Subtract tax (15% of Salary) from each employee's salary.
-- WRITE YOUR QUERY BELOW
SET SQL_SAFE_UPDATES = 0;
UPDATE Employees
SET Salary = Salary - (Salary * 0.15);
SET SQL_SAFE_UPDATES = 1;

SELECT EmployeeID, Name, Salary FROM Employees;
/* OUTPUT:
1001	Ashish	56100.00
1002	Binay	74800.00
1003	Charlie	51425.00
1004	Dhruv	70125.00
*/


-- c. Calculate the yearly salary from the monthly salary (Salary * 12).
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name,
Salary AS Monthly_Salary,
(Salary * 12) AS Yearly_Salary
FROM Employees;

/* OUTPUT:
1001	Ashish	56100.00	673200.00
1002	Binay	74800.00	897600.00
1003	Charlie	51425.00	617100.00
1004	Dhruv	70125.00	841500.00
*/

-- d. Find the remainder when employees' ages are divided by 5.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Age,
(Age % 5) AS Remainder FROM Employees;

/* OUTPUT:
1001	Ashish	28	3
1002	Binay	45	0
1003	Charlie	32	2
1004	Dhruv	38	3
*/

-- ========================
-- Exercise 2: Logical Operators
-- ========================

-- a. Employees older than 30 and salary greater than 50000.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Age, Salary, Department
FROM Employees
WHERE Age > 30 AND Salary > 50000;

/* OUTPUT:
1002	Binay	45	74800.00	HR
1003	Charlie	32	51425.00	Finance
1004	Dhruv	38	70125.00	HR
*/

-- b. Employees either in 'HR' department OR salary > 70000.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Department, Salary
FROM Employees
WHERE Department = 'HR' OR Salary > 70000;

/* OUTPUT:
1002	Binay	HR	74800.00
1004	Dhruv	HR	70125.00
*/


-- c. Employees who do NOT live in 'New York'.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Address
FROM Employees
WHERE Address NOT LIKE '%New York%';

/* OUTPUT:
1002	Binay	456 Elm St, Chicago
1003	Charlie	789 Oak St, Los Angeles
*/


-- ========================
-- Exercise 3: Comparison Operators
-- ========================

-- a. Find employees with salary = 60000.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Salary, Department
FROM Employees
WHERE Salary = 60000;

-- OUTPUT: NULL

-- b. List employees not in the 'IT' department.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Department
FROM Employees
WHERE NOT Department = 'IT';

/* OUTPUT:
1002	Binay	HR
1003	Charlie	Finance
1004	Dhruv	HR
*/

-- c. Retrieve employees younger than 25 with salary > 50000.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Age, Salary, Department
FROM Employees
WHERE Age < 25 AND Salary > 50000;

-- OUTPUT: NULL

-- ========================
-- Exercise 4: Special Operators
-- ========================

-- a. BETWEEN → List employees with age between 25 and 35.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Age, Department
FROM Employees
WHERE Age BETWEEN 25 AND 35;

/* OUTPUT:
1001	Ashish	28	IT
1003	Charlie	32	Finance
*/

-- b. IN → Find employees working in 'HR', 'IT', or 'Finance'.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Department
FROM Employees
WHERE Department IN ('HR', 'IT', 'Finance');

/* OUTPUT:
1001	Ashish	IT
1002	Binay	HR
1003	Charlie	Finance
1004	Dhruv	HR
*/

-- c. LIKE → Find employees whose names start with 'A'.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Department
FROM Employees
WHERE Name LIKE 'A%';

-- OUTPUT: 1001	Ashish	IT
		
-- d. IS NULL → List employees whose address is not available.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Address
FROM Employees
WHERE Address IS NULL;

-- OUTPUT: NULL

-- ========================
-- Exercise 5: Set Operators
-- ========================

-- NOTE: For these, assume you have two Employee tables (Employees2022 and Employees2023).

CREATE TABLE Employees2022 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50)
);

INSERT INTO Employees2022 (EmployeeID, Name, Department)
VALUES 
(1001, 'Ashish', 'IT'),
(1002, 'Binay', 'HR'),
(1003, 'Charlie', 'Finance');

CREATE TABLE Employees2023 (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50)
);

INSERT INTO Employees2023 (EmployeeID, Name, Department)
VALUES 
(1004, 'Dhruv', 'HR'),
(1005, 'Meera', 'HR'),
(1006, 'Riya', 'Finance');


-- a. UNION → Retrieve employees from 'HR' department in 2023 and 2022.
-- WRITE YOUR QUERY BELOW
SELECT EmployeeID, Name, Department
FROM Employees2022
WHERE Department = 'HR'

UNION

SELECT EmployeeID, Name, Department
FROM Employees2023
WHERE Department = 'HR';

/* OUTPUT:
1002	Binay	HR
1004	Dhruv	HR
1005	Meera	HR
*/

-- b. INTERSECT → Find common employees in 'IT' department across 2022 & 2023.
-- (MySQL doesn’t have INTERSECT directly – use INNER JOIN / EXISTS workaround)
-- WRITE YOUR QUERY BELOW
SELECT e22.EmployeeID, e22.Name, e22.Department
FROM Employees2022 e22
INNER JOIN Employees2023 e23 ON e22.EmployeeID = e23.EmployeeID
WHERE e22.Department = 'IT' AND e23.Department = 'IT';

-- OUTPUT: NULL

-- c. EXCEPT → Find employees who worked in 2023 but not in 2022.
-- (MySQL doesn’t have EXCEPT directly – use LEFT JOIN / NOT EXISTS workaround)
-- WRITE YOUR QUERY BELOW
SELECT e23.EmployeeID, e23.Name, e23.Department
FROM Employees2023 e23
LEFT JOIN Employees2022 e22 ON e23.EmployeeID = e22.EmployeeID
WHERE e22.EmployeeID IS NULL;

/* OUTPUT:
1004	Dhruv	HR
1005	Meera	HR
1006	Riya	Finance
*/

-- ======================================================================
-- END OF EXPERIMENT 04
-- ======================================================================