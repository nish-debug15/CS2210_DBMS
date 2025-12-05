USE LIBRARYDB;

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Price DECIMAL(6,2),
    Genre VARCHAR(50)
);

INSERT INTO Books (BookID, Title, Author, Price, Genre)
VALUES 
(1, 'Rich Dad, Poor Dad', 'Robert Kiyosaki', 599.00, 'Financial Growth'),
(2, 'Ikigai', 'Hector Gracia', 789.00, 'Self help'),
(3, 'Atomic Habits', 'James Clear', 399.00, 'Self help');

Select * From Books;

Select Title, Price From Books;

SELECT BookID FROM Books WHERE Title = 'Ikigai';
UPDATE Books SET Price = 550.00 WHERE BookID = 2;

DELETE FROM Books
WHERE Title = 'Ikigai';
