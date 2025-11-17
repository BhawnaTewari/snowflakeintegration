-- 01_create_tables.sql
-- Create a simple library database schema

CREATE TABLE Authors (
    AuthorID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    BirthYear INT
);

CREATE TABLE Books (
    BookID INT PRIMARY KEY,
    Title VARCHAR(200) NOT NULL,
    AuthorID INT,
    PublishedYear INT,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID)
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    JoinDate DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    BookID INT,
    MemberID INT,
    LoanDate DATE DEFAULT CURRENT_DATE,
    ReturnDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

-- 02_insert_sample_data.sql
-- Insert sample data into the library database

INSERT INTO Authors (AuthorID, Name, BirthYear) VALUES
(1, 'Jane Austen', 1775),
(2, 'George Orwell', 1903),
(3, 'Mark Twain', 1835);

INSERT INTO Books (BookID, Title, AuthorID, PublishedYear) VALUES
(1, 'Pride and Prejudice', 1, 1813),
(2, '1984', 2, 1949),
(3, 'Animal Farm', 2, 1945),
(4, 'Adventures of Huckleberry Finn', 3, 1884);

INSERT INTO Members (MemberID, FullName, Email, JoinDate) VALUES
(1, 'Alice Johnson', 'alice.j@example.com', '2023-01-15'),
(2, 'Bob Smith', 'bob.smith@example.com', '2023-03-22');

INSERT INTO Loans (LoanID, BookID, MemberID, LoanDate) VALUES
(1, 2, 1, '2024-04-01'),
(2, 4, 2, '2024-04-15');

-- 03_sample_queries.sql
-- Sample queries for the library database

-- 1. List all books with their authors
SELECT 
    b.Title,
    a.Name AS Author,
    b.PublishedYear
FROM Books b
JOIN Authors a ON b.AuthorID = a.AuthorID
ORDER BY b.PublishedYear;

-- 2. List members currently borrowing books
SELECT 
    m.FullName,
    b.Title,
    l.LoanDate
FROM Loans l
JOIN Members m ON l.MemberID = m.MemberID
JOIN Books b ON l.BookID = b.BookID
WHERE l.ReturnDate IS NULL;

-- 3. Count number of books per author
SELECT 
    a.Name,
    COUNT(b.BookID) AS NumberOfBooks
FROM Authors a
LEFT JOIN Books b ON a.AuthorID = b.AuthorID
GROUP BY a.Name
ORDER BY NumberOfBooks DESC;