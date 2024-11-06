CREATE DATABASE Library;

USE Library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(50),
    Position VARCHAR(50),
    Salary INT,
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);

CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(100),
    Category VARCHAR(50),
    Rental_Price DECIMAL(10, 2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(100),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, '123, MG Road, Mumbai, Maharashtra', '022-12345678'),
(2, 102, '456, Brigade Road, Bangalore, Karnataka', '080-23456789'),
(3, 103, '789, Park Street, Kolkata, West Bengal', '033-34567890');

INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(1, 'Amit Sharma', 'Manager', 60000, 1),
(2, 'Priya Gupta', 'Librarian', 45000, 1),
(3, 'Rajesh Kumar', 'Assistant Librarian', 30000, 2),
(4, 'Sneha Patel', 'Librarian', 55000, 3);

INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-1234567897', 'The Great Indian Novel', 'Fiction', 15.00, 'yes', 'Shashi Tharoor', 'Penguin'),
('978-2345678901', 'India After Gandhi', 'History', 20.00, 'no', 'Ramachandra Guha', 'HarperCollins'),
('978-3456789012', 'Wings of Fire', 'Biography', 25.00, 'yes', 'A. P. J. Abdul Kalam', 'Universities Press'),
('978-4567890123', 'My Experiments with Truth', 'Autobiography', 18.00, 'no', 'Mahatma Gandhi', 'Navajivan Trust'),
('978-5678901234', 'Ignited Minds', 'Inspirational', 30.00, 'yes', 'A. P. J. Abdul Kalam', 'Penguin');

INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'Rahul Mehta', '101, Sector 15, Noida, Uttar Pradesh', '2021-05-20'),
(2, 'Nisha Reddy', '202, MG Road, Bangalore, Karnataka', '2020-11-15'),
(3, 'Suresh Joshi', '303, Shyam Nagar, Jaipur, Rajasthan', '2019-07-30'),
(4, 'Anjali Singh', '404, Ashok Vihar, Delhi', '2023-01-10');

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 1, 'The Great Indian Novel', '2023-06-15', '978-1234567897'),
(2, 2, 'Wings of Fire', '2023-06-20', '978-3456789012');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 1, 'The Great Indian Novel', '2023-07-01', '978-1234567897'),
(2, 2, 'Wings of Fire', '2023-07-05', '978-3456789012');

#Retrieve the book title, category, and rental price of all available books.

SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'yes';

#List the employee names and their respective salaries in descending order of salary.

SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

#Retrieve the book titles and the corresponding customers who have issued those books.

SELECT B.Book_title, C.Customer_name 
FROM Books B
JOIN IssueStatus I ON B.ISBN = I.Isbn_book 
JOIN Customer C ON I.Issued_cust = C.Customer_Id;

#Display the total count of books in each category.

SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

/*Retrieve the employee names and their positions for the employees 
whose salaries are above Rs. 50,000.*/

SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

/*List the customer names who registered before 2022-01-01 
and have not issued any books yet.*/

SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT DISTINCT Issued_cust FROM IssueStatus);

#Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(Emp_Id) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no;

#Display the names of customers who have issued books in the month of June 2023.

SELECT C.Customer_name 
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
WHERE MONTH(I.Issue_date) = 6 AND YEAR(I.Issue_date) = 2023;

#Retrieve book_title from the book table containing history.

SELECT Book_title FROM Books WHERE Category LIKE '%history%';

/*Retrieve the branch numbers along with the 
count of employees for branches having more than 5 employees.*/

SELECT Branch_no, COUNT(Emp_Id) AS Total_Employees 
FROM Employee 
GROUP BY Branch_no 
HAVING COUNT(Emp_Id) > 5;

/*Retrieve the names of employees 
who manage branches and their respective branch addresses.*/

SELECT E.Emp_name, B.Branch_address 
FROM Employee E 
JOIN Branch B ON E.Branch_no = B.Branch_no 
WHERE E.Position = 'Manager';

/*Display the names of customers who have issued books with 
a rental price higher than Rs. 25.*/

SELECT C.Customer_name
FROM Customer C
JOIN IssueStatus I ON C.Customer_Id = I.Issued_cust
JOIN Books B ON I.Isbn_book = B.ISBN
WHERE B.Rental_Price > 25;

