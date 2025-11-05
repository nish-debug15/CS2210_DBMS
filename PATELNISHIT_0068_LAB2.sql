-- ======================================================================
-- Lab Experiment 02 – Implementation of DML Commands in SQL
-- ======================================================================

-- Objective:
-- To implement DML (Data Manipulation Language) commands such as 
-- INSERT, UPDATE, and DELETE using suitable examples.

-- Scenario:
-- You are managing a database for a library with two tables: Books and Members.

-- ======================================================================
-- Step 1: Create Database
DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- ======================================================================
-- Task 01: Create Tables
-- Create Books and Members tables as per given structure.

CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100),
    author VARCHAR(50),
    published_year YEAR,
    available_copies INT,
    total_copies INT,
    genre VARCHAR(50),
    ISBN VARCHAR(20)
);

CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    membership_date DATE,
    membership_type VARCHAR(20),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(100)
);

-- write the query here to verify the creation
SHOW TABLES;
DESC Books;
DESC Members;

/* OUTPUT: (TABLES)
books
members
*/

/* OUTPUT: (BOOKS)
book_id	int	NO	PRI		auto_increment
title	varchar(100)	YES			
author	varchar(50)	YES			
published_year	year	YES			
available_copies	int	YES			
total_copies	int	YES			
genre	varchar(50)	YES			
ISBN	varchar(20)	YES			
*/

/* OUTPUT: (MEMBERS)
member_id	int	NO	PRI		auto_increment
first_name	varchar(50)	YES			
last_name	varchar(50)	YES			
membership_date	date	YES			
membership_type	varchar(20)	YES			
email	varchar(100)	YES			
phone_number	varchar(20)	YES			
address	varchar(100)	YES			
*/


-- ======================================================================
-- Task 02: Integrity Constraints
-- Ensure that available_copies is always less than or equal to total_copies.

-- WRITE YOUR QUERY BELOW
ALTER TABLE Books
ADD CONSTRAINT chk_copies CHECK (available_copies <= total_copies);


-- OUTPUT:
-- (Display confirmation message or describe constraint added.)
-- WRITE YOUR OUTPUT BELOW
-- 11:28:58	ALTER TABLE Books ADD CONSTRAINT chk_copies CHECK (available_copies <= total_copies)	0 row(s) affected Records: 0  Duplicates: 0  Warnings: 0	0.046 sec



-- ======================================================================
-- Task 03: Insert a New Book
-- Scenario: Insert a record for the new book titled 
-- '1984_The Black Swan' by George Orwell (published in 1949, 4 copies available).
-- WRITE YOUR QUERY BELOW
INSERT INTO Books (title, author, published_year, available_copies, total_copies, genre, ISBN)
VALUES ('1984_The Black Swan', 'George Orwell', 1949, 4, 4, 'Dystopian Fiction', '9780451524935');

SELECT *  FROM BOOKS;

-- OUTPUT:
-- (Run SELECT * FROM Books; to verify insertion)
-- WRITE YOUR OUTPUT BELOW

-- 1	1984_The Black Swan	George Orwell	1949	4	4	Dystopian Fiction	9780451524935

							


-- ======================================================================
-- Task 04: Add New Members
-- Scenario:
-- Member 1: David Lee, Membership Date – 2024-04-15, Membership Type – Platinum
-- Member 2: Emma Wilson, Membership Date – 2024-05-22, Membership Type – Silver
-- WRITE YOUR QUERIES BELOW
INSERT INTO Members (first_name, last_name, membership_date, membership_type, email, phone_number, address)
VALUES
('David', 'Lee', '2024-04-15', 'Platinum', 'david.lee@email.com', '9876543210', 'Bangalore, India'),
('Emma', 'Wilson', '2024-05-22', 'Silver', 'emma.wilson@email.com', '8765432109', 'Mumbai, India');

SELECT * FROM MEMBERS;

-- OUTPUT:
-- (Run SELECT * FROM Members; to verify insertion)
-- WRITE YOUR OUTPUT BELOW
/*
1	David	Lee	2024-04-15	Platinum	david.lee@email.com	9876543210	Bangalore, India
2	Emma	Wilson	2024-05-22	Silver	emma.wilson@email.com	8765432109	Mumbai, India
*/


-- ======================================================================
-- Task 05: Update Book Details
-- Scenario: The library has acquired 2 additional copies of the book '1984'.
-- Update the record accordingly.
-- WRITE YOUR QUERY BELOW
UPDATE Books
SET available_copies = available_copies + 2, total_copies = total_copies + 2
WHERE book_id = 1;

SELECT * FROM BOOKS;

-- OUTPUT:
-- (Run SELECT * FROM Books; to check updated copies)
-- WRITE YOUR OUTPUT BELOW
-- 1	1984_The Black Swan	George Orwell	1949	6	6	Dystopian Fiction	9780451524935


-- ======================================================================
-- Task 06: Modify a Member's Information
-- Scenario: Emma Wilson has upgraded her membership from 'Silver' to 'Gold'.
-- WRITE YOUR QUERY BELOW
SET SQL_SAFE_UPDATES = 0;

UPDATE Members
SET membership_type = 'Gold'
WHERE first_name = 'Emma' AND last_name = 'Wilson';

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM MEMBERS;

-- OUTPUT:
-- (Run SELECT * FROM Members; to check updated membership)
-- WRITE YOUR OUTPUT BELOW
/* 
1	David	Lee	2024-04-15	Platinum	david.lee@email.com	9876543210	Bangalore, India
2	Emma	Wilson	2024-05-22	Gold	emma.wilson@email.com	8765432109	Mumbai, India
*/


-- ======================================================================
-- Task 07: Delete a Book Record
-- Scenario: The book '1984_The Black Swan' is no longer available in the library.
-- Remove it from the database.
-- WRITE YOUR QUERY BELOW
DELETE FROM Books
WHERE book_id = 1;

SELECT * FROM BOOKS;

-- OUTPUT:
-- (Run SELECT * FROM Books; to verify deletion)
-- WRITE YOUR OUTPUT BELOW
-- NULL


-- ======================================================================
-- Task 08: Remove a Member
-- Scenario: David Lee has canceled his membership. Remove his record.
-- WRITE YOUR QUERY BELOW
DELETE FROM Members
WHERE member_id = 1;

SELECT * FROM MEMBERS;

-- OUTPUT:
-- (Run SELECT * FROM Members; to verify deletion)
-- WRITE YOUR OUTPUT BELOW
-- 2	Emma	Wilson	2024-05-22	Gold	emma.wilson@email.com	8765432109	Mumbai, India


-- ======================================================================
-- Extension (Optional)
-- Task: Create a Borrowing table to track which members have borrowed which books.
-- Include foreign keys referencing Books(book_id) and Members(member_id).
-- WRITE YOUR TABLE CREATION QUERY BELOW


-- OUTPUT:
-- (Run DESC Borrowing; to verify structure)
-- WRITE YOUR OUTPUT BELOW



-- ======================================================================
-- END OF EXPERIMENT 02
-- ======================================================================