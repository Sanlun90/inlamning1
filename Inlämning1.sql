/* Inlämningsuppgift 1: ER-diagram och Relationsmodell
Kurs: Databaser
Av: Sandra Bäckström */

-- Skapa databasen Liten bokhandel
CREATE DATABASE Bookshop;
USE Bookshop;

-- Skapa tabell Böcker
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    ISBN VARCHAR(100) UNIQUE NOT NULL,
    Author VARCHAR(100) NOT NULL,
    Title VARCHAR(255) UNIQUE NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock VARCHAR(255) NOT NULL
);

-- Skapa tabell Kunder
CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(255) NOT NULL,
    Adress VARCHAR(255) NOT NULL
);

-- Skapa tabell Beställningar
CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL, 
    TotalAmount DECIMAL(10,2) NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- Skapa tabell Orderrader
CREATE TABLE Orderrows (
    OrderowsID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    BookID INT NOT NULL,
    ISBN VARCHAR(100) NOT NULL,
    Amount INT NOT NULL CHECK (Amount > 0),
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Infoga data Böcker
INSERT INTO Books (ISBN, Title, Author, Price, Stock) VALUES
('978-0-13-110362-7', 'The C Programming Language', 'Brian Kernighan & Dennis Ritchie', 45.99, 10),
('978-1-491-95479-3', 'Learning SQL', 'Alan Beaulieu', 39.99, 15),
('978-0-321-87758-1', 'Database System Concepts', 'Silberschatz, Korth & Sudarshan', 59.99, 8);

-- Infoga data Kunder
INSERT INTO Customer (Name, Email, Phone, Adress) VALUES
('Alice Johnson', 'alice@example.com', '123-456-7890', '123 Main St, Cityville'),
('Bob Smith', 'bob@example.com', '987-654-3210', '456 Oak St, Townsville'),
('Charlie Brown', 'charlie@example.com', '555-123-4567', '789 Pine St, Villagetown');

-- Infoga data Beställningar
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-03-10', 85.98),  -- Alices beställning
(2, '2024-03-11', 39.99),  -- Bobs beställning
(3, '2024-03-12', 59.99);  -- Charlies beställning

-- Infoga data Orderrader
INSERT INTO Orderrows (OrderID, BookID, ISBN, Amount, Price) VALUES
(1, 1, '978-0-13-110362-7', 1, 45.99),  -- Alice beställde 1 exemplar av "The C Programming Language"
(1, 2, '978-1-491-95479-3', 1, 39.99),  -- Alice beställde också 1 exemplar av "Learning SQL"
(2, 2, '978-1-491-95479-3', 1, 39.99),  -- Bob beställde 1 exemplar av "Learning SQL"
(3, 3, '978-0-321-87758-1', 1, 59.99);  -- Charlie beställde 1 exemplar av "Database System Concepts"


