use class3Homework;

DROP TABLE IF EXISTS Employees;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

DROP TABLE IF EXISTS Products;
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);


INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, Salary, HireDate) VALUES
(1, 'John', 'Doe', 'HR', 90000.00, '2015-06-15'),
(2, 'Jane', 'Smith', 'Finance', 75000.00, '2017-08-20'),
(3, 'Alice', 'Johnson', 'IT', 50000.00, '2018-04-10'),
(4, 'Bob', 'Brown', 'IT', 85000.00, '2016-01-05'),
(5, 'Charlie', 'Davis', 'Marketing', 45000.00, '2020-11-30'),
(6, 'Eve', 'Miller', 'Finance', 95000.00, '2014-03-25'),
(7, 'Frank', 'Wilson', 'HR', 30000.00, '2019-07-01'),
(8, 'Grace', 'Lee', 'Marketing', 52000.00, '2021-01-15'),
(9, 'Henry', 'Clark', 'IT', 70000.00, '2013-09-17'),
(10, 'Ivy', 'Walker', 'Finance', 62000.00, '2022-05-22');


INSERT INTO Orders (OrderID, CustomerName, OrderDate, TotalAmount, Status) VALUES
(1, 'Michael Scott', '2023-01-05', 500.00, 'Pending'),
(2, 'Jim Halpert', '2023-01-10', 7500.00, 'Shipped'),
(3, 'Pam Beesly', '2023-01-12', 6000.00, 'Delivered'),
(4, 'Dwight Schrute', '2023-02-20', 300.00, 'Cancelled'),
(5, 'Stanley Hudson', '2023-03-15', 1000.00, 'Delivered'),
(6, 'Kevin Malone', '2023-04-01', 400.00, 'Pending'),
(7, 'Angela Martin', '2023-04-07', 9500.00, 'Shipped'),
(8, 'Oscar Martinez', '2023-05-20', 1100.00, 'Pending'),
(9, 'Toby Flenderson', '2023-06-15', 250.00, 'Cancelled'),
(10, 'Ryan Howard', '2023-07-10', 800.00, 'Shipped');


INSERT INTO Products (ProductID, ProductName, Category, Price, Stock) VALUES
(1, 'Laptop', 'Electronics', 1500.00, 20),
(2, 'Smartphone', 'Electronics', 800.00, 35),
(3, 'Tablet', 'Electronics', 450.00, 40),
(4, 'Desk Chair', 'Furniture', 120.00, 50),
(5, 'Office Desk', 'Furniture', 300.00, 15),
(6, 'Monitor', 'Electronics', 200.00, 25),
(7, 'Keyboard', 'Electronics', 40.00, 100),
(8, 'Mouse', 'Electronics', 30.00, 120),
(9, 'Printer', 'Electronics', 250.00, 18),
(10, 'Bookshelf', 'Furniture', 180.00, 12);


--Task-2--
SELECT 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END AS OrderStatus,
    COUNT(*) AS TotalOrders,
    SUM(TotalAmount) AS TotalRevenue
FROM Orders
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    CASE 
        WHEN Status IN ('Shipped', 'Delivered') THEN 'Completed'
        WHEN Status = 'Pending' THEN 'Pending'
        WHEN Status = 'Cancelled' THEN 'Cancelled'
    END
HAVING SUM(TotalAmount) > 5000
ORDER BY TotalRevenue DESC;