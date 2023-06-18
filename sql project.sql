CREATE DATABASE library;
USE library;

CREATE TABLE Branch (
  Branch_no INT PRIMARY KEY,
  Manager_Id INT,
  Branch_address VARCHAR(255),
  Contact_no VARCHAR(20)
);
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
  (1, 101, 'Mumbai, Maharashtra', '9876543210'),
  (2, 102, 'Delhi, Delhi', '9876543211'),
  (3, 103, 'Chennai, Tamil Nadu', '9876543212'),
  (4, 104, 'Kolkata, West Bengal', '9876543213'),
  (5, 105, 'Bengaluru, Karnataka', '9876543214'),
  (6, 106, 'Hyderabad, Telangana', '9876543215'),
  (7, 107, 'Ahmedabad, Gujarat', '9876543216'),
  (8, 108, 'Pune, Maharashtra', '9876543217'),
  (9, 109, 'Jaipur, Rajasthan', '9876543218'),
  (10, 110, 'Lucknow, Uttar Pradesh', '9876543219');


CREATE TABLE Employee (
  Emp_Id INT PRIMARY KEY,
  Emp_name VARCHAR(255),
  Position VARCHAR(255),
  Salary DECIMAL(10, 2)
);
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary)
VALUES
  (101, 'Rajesh Sharma', 'Manager', 75000),
  (102, 'Priya Verma', 'Assistant Manager', 55000),
  (103, 'Amit Patel', 'Librarian', 45000),
  (104, 'Neeta Singh', 'Clerk', 35000),
  (105, 'Sanjay Gupta', 'Clerk', 35000),
  (106, 'Divya Joshi', 'Clerk', 35000),
  (107, 'Rahul Malhotra', 'Clerk', 35000),
  (108, 'Anita Bhatia', 'Clerk', 35000),
  (109, 'Vivek Kumar', 'Clerk', 35000),
  (110, 'Neha Sharma', 'Clerk', 35000);

CREATE TABLE Customer (
  Customer_Id INT PRIMARY KEY,
  Customer_name VARCHAR(255),
  Customer_address VARCHAR(255),
  Reg_date DATE
);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
  (1001, 'Anjali Gupta', 'Mumbai, Maharashtra', '2021-03-15'),
  (1002, 'Amit Khanna', 'Delhi, Delhi', '2021-05-20'),
  (1003, 'Pooja Sharma', 'Chennai, Tamil Nadu', '2021-08-10'),
  (1004, 'Ravi Singh', 'Kolkata, West Bengal', '2021-06-25'),
  (1005, 'Deepika Patel', 'Bengaluru, Karnataka', '2021-01-12'),
  (1006, 'Rajat Verma', 'Hyderabad, Telangana', '2021-07-05'),
  (1007, 'Neha Gupta', 'Ahmedabad, Gujarat', '2021-04-18'),
  (1008, 'Kunal Shah', 'Pune, Maharashtra', '2021-02-07'),
  (1009, 'Aarti Singh', 'Jaipur, Rajasthan', '2021-09-01'),
  (1010, 'Mohan Agarwal', 'Lucknow, Uttar Pradesh', '2021-11-30');

CREATE TABLE IssueStatus (
  Issue_Id INT PRIMARY KEY,
  Issued_cust INT,
  Issued_book_name VARCHAR(255),
  Issue_date DATE,
  Isbn_book VARCHAR(255),
  FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES (1, 1001, 'Book1', '2023-06-05', 'ISBN001'),
       (2, 1002, 'Book2', '2023-06-10', 'ISBN002'),
       (3, 1003, 'Book3', '2023-06-15', 'ISBN003'),
       (4, 1004, 'Book4', '2023-06-20', 'ISBN004'),
       (5, 1005, 'Book5', '2023-06-25', 'ISBN005');



CREATE TABLE ReturnStatus (
  Return_Id INT PRIMARY KEY,
  Return_cust INT,
  Return_book_name VARCHAR(255),
  Return_date DATE,
  Isbn_book2 VARCHAR(255),
  FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
  FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES (1, 1001, 'Book1', '2023-06-10', 'ISBN001'),
       (2, 1002, 'Book2', '2023-06-15', 'ISBN002'),
       (3, 1003, 'Book3', '2023-06-20', 'ISBN003'),
       (4, 1004, 'Book4', '2023-06-25', 'ISBN004'),
       (5, 1005, 'Book5', '2023-06-30', 'ISBN005');


CREATE TABLE Books (
  ISBN VARCHAR(255) PRIMARY KEY,
  Book_title VARCHAR(255),
  Category VARCHAR(255),
  Rental_Price DECIMAL(10, 2),
  Status VARCHAR(3),
  Author VARCHAR(255),
  Publisher VARCHAR(255)
);


INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES ('ISBN001', 'Book1', 'Fiction', 50, 'yes', 'Author1', 'Publisher1'),
       ('ISBN002', 'Book2', 'Mystery', 60, 'yes', 'Author2', 'Publisher2'),
       ('ISBN003', 'Book3', 'History', 70, 'yes', 'Author3', 'Publisher3'),
       ('ISBN004', 'Book4', 'Science', 80, 'no', 'Author4', 'Publisher4'),
       ('ISBN005', 'Book5', 'Biography', 90, 'yes', 'Author5', 'Publisher5');





-- 1. Retrieve the book title, category, and rental price of all available books.
SELECT Book_title, Category, Rental_Price FROM Books WHERE Status = 'yes';

-- 2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary FROM Employee ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books.
SELECT b.Book_title, c.Customer_name
FROM Books b
JOIN IssueStatus i ON b.ISBN = i.Isbn_book
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Count
FROM Books
GROUP BY Category;

-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
  AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- 7. Display the branch numbers and the total count of employees in each branch.
SELECT b.Branch_no, COUNT(*) AS Total_Count
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no;

-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT c.Customer_name
FROM Customer c
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust
WHERE YEAR(i.Issue_date) = 2023 AND MONTH(i.Issue_date) = 6;

-- 9. Retrieve book_title from
SELECT Book_title
FROM Books
WHERE Category = 'History';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.
SELECT b.Branch_no, COUNT(*) AS Employee_Count
FROM Branch b
JOIN Employee e ON b.Manager_Id = e.Emp_Id
GROUP BY b.Branch_no
HAVING Employee_Count > 5;
