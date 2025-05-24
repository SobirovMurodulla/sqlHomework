use class9Homework;

--Task 1
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');


WITH EmployeeHierarchy AS (
    SELECT
        EmployeeID,
        ManagerID,
        JobTitle,
        0 AS Depth
    FROM Employees
    WHERE ManagerID IS NULL

    UNION ALL

    SELECT
        e.EmployeeID,
        e.ManagerID,
        e.JobTitle,
        eh.Depth + 1 AS Depth
    FROM Employees e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)

SELECT *
FROM EmployeeHierarchy
ORDER BY Depth, EmployeeID;


--Task 2
WITH FactorialCTE (Num, Fact) AS (
    SELECT 1 AS Num, 1 AS Fact
    UNION ALL
    SELECT Num + 1, Fact * (Num + 1)
    FROM FactorialCTE
    WHERE Num < 10
)
SELECT Num, Fact AS Factorial
FROM FactorialCTE;


--Task 3

WITH FibonacciCTE (n, Fibonacci_Number, Prev_Number) AS (
    SELECT 
        1 AS n, 
        1 AS Fibonacci_Number, 
        0 AS Prev_Number

    UNION ALL

    SELECT 
        n + 1, 
        Fibonacci_Number + Prev_Number, 
        Fibonacci_Number
    FROM FibonacciCTE
    WHERE n < 10
)
SELECT 
    n, 
    Fibonacci_Number
FROM FibonacciCTE;
