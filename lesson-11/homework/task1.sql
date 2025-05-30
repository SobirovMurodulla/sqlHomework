--Task 1


use class11Homework;
create table Employees(
	EmployeeID INT,
	Name Varchar(50),
	Department Varchar(5),
	Salary INT
);

Insert into Employees
Values
(1, 'Alice', 'HR', 5000 ),
(2, 'Bob', 'IT', 7000),
(3,'Charlie', 'Sales', 6000),
(4, 'David','HR', 5500),
(5, 'Emma', 'IT', 7200);
--=============================================
CREATE TABLE #EmployeeTransfers (
    EmployeeID INT,
    Name NVARCHAR(100),
    Department NVARCHAR(50),
    Salary DECIMAL(10, 2)
);
INSERT INTO #EmployeeTransfers (EmployeeID, Name, Department, Salary)
SELECT
    EmployeeID,
    Name,
    CASE 
        WHEN Department = 'HR' THEN 'IT'
        WHEN Department = 'IT' THEN 'Sales'
        WHEN Department = 'Sales' THEN 'HR'
        ELSE Department
    END AS Department,
    Salary
FROM Employees;
--===============================================
SELECT * FROM #EmployeeTransfers;
