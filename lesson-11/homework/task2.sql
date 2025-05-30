--Task 2

use class11Homework;

-- Create Table: Orders_DB1 (Main System)
CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Product NVARCHAR(100),
    Quantity INT
);

-- Insert data into Orders_DB1
INSERT INTO Orders_DB1 (OrderID, CustomerName, Product, Quantity)
VALUES 
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

-- Create Table: Orders_DB2 (Backup System)
CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Product NVARCHAR(100),
    Quantity INT
);

-- Insert data into Orders_DB2
INSERT INTO Orders_DB2 (OrderID, CustomerName, Product, Quantity)
VALUES 
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);


declare @MissingOrders table(
	OrderID INT PRIMARY KEY,
    CustomerName NVARCHAR(100),
    Product NVARCHAR(100),
    Quantity INT
);

insert into @MissingOrders(OrderID, CustomerName, Product, Quantity)
select 
	Orders_DB1.OrderID,
	Orders_Db1.CustomerName,
	Orders_DB1.Product,
	Orders_DB1.Quantity
from Orders_DB1
left join Orders_DB2 on Orders_DB1.OrderID = Orders_DB2.OrderID
where Orders_DB2.OrderID is null;

select * from @MissingOrders;