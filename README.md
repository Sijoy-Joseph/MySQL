Library Management System
A SQL-based Library Management System that manages and tracks information about library books, employees, branches, customers, and the status of book issues and returns. This system organizes library data efficiently and allows for simple data retrieval.

Project Structure
This project includes SQL scripts to create and populate tables for a library management system and SQL queries for common operations.

Database: library
Tables
Branch - Stores branch information
Employee - Stores employee data
Books - Stores book information
Customer - Stores customer information
IssueStatus - Tracks the status of issued books
ReturnStatus - Tracks the status of returned books
Table Structure
Branch
Branch_no (PRIMARY KEY)
Manager_Id
Branch_address
Contact_no
Employee
Emp_Id (PRIMARY KEY)
Emp_name
Position
Salary
Branch_no (FOREIGN KEY references Branch table)
Books
ISBN (PRIMARY KEY)
Book_title
Category
Rental_Price
Status (Indicates availability of the book)
Author
Publisher
Customer
Customer_Id (PRIMARY KEY)
Customer_name
Customer_address
Reg_date
IssueStatus
Issue_Id (PRIMARY KEY)
Issued_cust (FOREIGN KEY references Customer table)
Issued_book_name
Issue_date
Isbn_book (FOREIGN KEY references Books table)
ReturnStatus
Return_Id (PRIMARY KEY)
Return_cust (FOREIGN KEY references Customer table)
Return_book_name
Return_date
Isbn_book2 (FOREIGN KEY references Books table)
SQL Scripts
Files Included
create_tables.sql - Creates the above tables with the necessary primary and foreign key constraints.
insert_data.sql - Inserts sample data into the tables.
queries.sql - Contains SQL queries for:
Retrieving book titles, categories, and rental prices of available books.
Listing employee names and their salaries in descending order.
Displaying book titles and the names of customers who have issued them.
Counting books in each category.
Displaying employee names and positions for employees with a salary above 50,000.
Listing customer names registered before a certain date who have not issued books.
Showing branch numbers and the employee count for each branch.
Retrieving customer names who issued books in June 2023.
Finding books with a title containing “history.”
Displaying branches with more than five employees.
Listing branch managers and their respective branch addresses.
Displaying names of customers who issued books with rental prices above 25.
