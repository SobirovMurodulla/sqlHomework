use class5Homework;

drop table if exists Employees;

create table Employees(
	EmployeeID INT,
	Name VARCHAR(50),
	Department VARCHAR(50),
	Salary DECIMAL(10,2),
	HireDate DATE
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)
VALUES
(1, 'Alice', 'HR', 50000, '2021-01-01'),
(2, 'Bob', 'IT', 80000, '2020-05-10'),
(3, 'Charlie', 'IT', 75000, '2022-07-20'),
(4, 'David', 'HR', 55000, '2021-06-15'),
(5, 'Eva', 'IT', 60000, '2022-03-30'),
(6, 'Frank', 'HR', 45000, '2021-09-10'),
(6, 'Jean', 'IT', 55000, '2021-12-10');

--Tasks
--1
SELECT EmployeeID, Name, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;
--2
SELECT EmployeeID, Name, Salary,
       RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees
WHERE Salary IN (
    SELECT Salary
    FROM Employees
    GROUP BY Salary
    HAVING COUNT(Salary) > 1
);

--3
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rn
    FROM Employees
) AS Ranked
WHERE rn <= 2;

--4
SELECT EmployeeID, Name, Department, Salary
FROM (
    SELECT EmployeeID, Name, Department, Salary,
           RANK() OVER (PARTITION BY Department ORDER BY Salary ASC) AS SalaryRank
    FROM Employees
) AS RankedEmployees
WHERE SalaryRank = 1;

--5
SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees;


--6
SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees;

--7
SELECT EmployeeID, Name, Department, Salary,
       AVG(Salary) OVER (PARTITION BY Department) AS AverageSalary
FROM Employees;

--8
SELECT EmployeeID, Name, Department, Salary,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS SalaryDifference
FROM Employees;

--9
SELECT EmployeeID, Name, Department, Salary,
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvgSalary
FROM Employees;

--10
SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS SumLast3Salaries
FROM Employees;

--11
SELECT EmployeeID, Name, Department, Salary,
       AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningAvgSalary
FROM Employees;

--12
SELECT EmployeeID, Name, Department, Salary,
       MAX(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MaxSalaryWindow
FROM Employees;

--13
SELECT EmployeeID, Name, Department, Salary,
       (Salary * 100.0) / SUM(Salary) OVER (PARTITION BY Department) AS SalaryPercentage
FROM Employees;




