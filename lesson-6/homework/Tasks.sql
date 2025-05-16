use class6Homework;


DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);


DROP TABLE IF EXISTS Employee;
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DepartmentID INT NULL,
    Salary INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);


DROP TABLE IF EXISTS Projects;
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(50),
    EmployeeID INT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);


INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);


INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);

select * from Employees;
select * from Departments;
select * from Projects;


--Tasks
--Inner JOIN
SELECT E.EmployeeID, E.Name, D.DepartmentName
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

--Left JOIN
SELECT E.EmployeeID, E.Name, D.DepartmentName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID;


--Right JOIN
SELECT E.EmployeeID, E.Name, D.DepartmentName
FROM Employees E
RIGHT JOIN Departments D ON E.DepartmentID = D.DepartmentID;


--Full Outer JOIN
SELECT E.EmployeeID, E.Name, D.DepartmentName
FROM Employees E
FULL OUTER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

--JOIN with Aggregation
SELECT D.DepartmentName, SUM(E.Salary) AS TotalSalary
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;

--Cross JOIN
SELECT D.DepartmentName, P.ProjectName
FROM Departments D
CROSS JOIN Projects P;


--Multiple JOINs
SELECT E.EmployeeID, E.Name AS EmployeeName, D.DepartmentName, P.ProjectName
FROM Employees E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN Projects P ON E.EmployeeID = P.EmployeeID;
