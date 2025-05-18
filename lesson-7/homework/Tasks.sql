use class7Homework;

drop table if exists Customers;
drop table if exists Orders;
drop table if exists OrderDetails;
drop table if exists Products;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

-- Insert data into Customers
INSERT INTO Customers (CustomerID, CustomerName) VALUES
(11,'Keyl Mkkeny'),
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Davis'),
(4, 'Diana Moore'),
(5, 'Edward King'),
(6, 'Fiona Clark'),
(7, 'George Hill'),
(8, 'Hannah Wright'),
(9, 'Ian Scott'),
(10, 'Jane Adams');

-- Insert data into Products
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Smartphone', 'Electronics'),
(103, 'Desk Chair', 'Furniture'),
(104, 'Coffee Table', 'Furniture'),
(105, 'Headphones', 'Accessories'),
(106, 'Monitor', 'Electronics'),
(107, 'Keyboard', 'Accessories'),
(108, 'Mouse', 'Accessories'),
(109, 'Notebook', 'Stationery'),
(110, 'Pen Set', 'Stationery');

-- Insert data into Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1001, 1, '2024-01-10'),
(1002, 2, '2024-01-15'),
(1003, 3, '2024-02-01'),
(1004, 4, '2024-02-05'),
(1005, 5, '2024-02-10'),
(1006, 6, '2024-03-01'),
(1007, 7, '2024-03-15'),
(1008, 8, '2024-03-20'),
(1009, 9, '2024-04-01'),
(1010, 10, '2024-04-10');

-- Insert data into OrderDetails
INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(2001, 1001, 101, 1, 1000.00),
(2002, 1010, 107, 2, 25.00),
(2003, 1002, 103, 1, 150.00),
(2004, 1003, 105, 3, 50.00),
(2005, 1004, 108, 1, 20.00),
(2006, 1005, 106, 2, 200.00),
(2007, 1006, 109, 5, 3.00),
(2008, 1007, 102, 1, 600.00),
(2009, 1008, 104, 1, 120.00),
(2010, 1009, 110, 10, 2.50),
(2011, 1010, 101, 1, 1000.00);


select * from Customers;
select * from Products;
select * from Orders;
select * from OrderDetails;
--task 1
select distinct Customers.CustomerName
from
Customers
join
Orders on Orders.CustomerID = Customers.CustomerID
join
OrderDetails on Orders.OrderID = OrderDetails.OrderID

--task2
select Customers.CustomerName
from
Customers
full outer join
Orders on Orders.CustomerID = Customers.CustomerID
where Orders.OrderID is NULL;

--task3
select Orders.OrderID, Products.ProductName, OrderDetails.Quantity
from
Customers
join
Orders on Orders.CustomerID = Customers.CustomerID
join
OrderDetails on Orders.OrderID = OrderDetails.OrderID
join
Products on OrderDetails.ProductID = Products.ProductID

--task4
select Customers.CustomerName
from
Customers
join
Orders on Orders.CustomerID = Customers.CustomerID
join
OrderDetails on Orders.OrderID = OrderDetails.OrderID
join
Products on OrderDetails.ProductID = Products.ProductID
group by Customers.CustomerName
having count(distinct Orders.OrderID) > 1

--task5
SELECT Price
FROM (
    SELECT 
        OrderDetails.OrderID,
        OrderDetails.Price,
        RANK() OVER (PARTITION BY OrderDetails.OrderID ORDER BY OrderDetails.Price DESC) AS rank
    FROM Customers
    JOIN Orders ON Orders.CustomerID = Customers.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
) ranked_orders
WHERE rank = 1;

--task6
SELECT OrderID, OrderDate 
FROM (
    SELECT
        OrderDetails.OrderID,
		Orders.OrderDate,
        OrderDetails.Price,
        RANK() OVER (PARTITION BY OrderDetails.OrderID ORDER BY Orders.OrderDate DESC) AS rank
    FROM Customers
    JOIN Orders ON Orders.CustomerID = Customers.CustomerID
    JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
    JOIN Products ON OrderDetails.ProductID = Products.ProductID
) ranked_orders

--task7
SELECT DISTINCT Customers.CustomerID, Customers.CustomerName
FROM Customers
JOIN
Orders ON Customers.CustomerID = Orders.CustomerID
JOIN
OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN
Products ON OrderDetails.ProductID = Products.ProductID
GROUP BY Customers.CustomerID, Customers.CustomerName
HAVING COUNT(DISTINCT CASE WHEN Products.Category != 'Electronics' THEN Products.ProductID END) = 0;

--task8
SELECT DISTINCT Customers.CustomerID, Customers.CustomerName
FROM Customers
JOIN
Orders ON Customers.CustomerID = Orders.CustomerID
JOIN
OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN
Products ON OrderDetails.ProductID = Products.ProductID
WHERE Products.Category = 'Stationery';

--task9
SELECT 
    Customers.CustomerID,
    Customers.CustomerName,
    SUM(OrderDetails.Quantity * OrderDetails.Price) AS TotalSpent
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CustomerID, Customers.CustomerName;


