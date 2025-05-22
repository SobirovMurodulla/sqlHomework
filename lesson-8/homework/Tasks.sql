use class8Homework;

CREATE TABLE Groupings (
    [Step Number] INT PRIMARY KEY,
    Status VARCHAR(10)
);


INSERT INTO Groupings ([Step Number], Status) VALUES
(1, 'Passed'),
(2, 'Passed'),
(3, 'Passed'),
(4, 'Passed'),
(5, 'Failed'),
(6, 'Failed'),
(7, 'Failed'),
(8, 'Failed'),
(9, 'Failed'),
(10, 'Passed'),
(11, 'Passed'),
(12, 'Passed');


select * from Groupings;
--task 1
WITH StatusGroups AS (
    SELECT 
        [Step Number],
        Status,
        CASE 
            WHEN LAG(Status) OVER (ORDER BY [Step Number]) = Status THEN 0
            ELSE 1
        END AS NewGroupFlag
    FROM Groupings
),
GroupWithNumbers AS (
    SELECT 
        [Step Number],
        Status,
        SUM(NewGroupFlag) OVER (ORDER BY [Step Number]) AS GroupNumber
    FROM StatusGroups
)
SELECT 
    MIN([Step Number]) AS [Min Step Number],
    MAX([Step Number]) AS [Max Step Number],
    Status,
    COUNT(*) AS [Consecutive Count]
FROM GroupWithNumbers
GROUP BY GroupNumber, Status
ORDER BY [Min Step Number];


--task 2

CREATE TABLE [dbo].[EMPLOYEES_N]
(
    [EMPLOYEE_ID] [int] NOT NULL,
    [FIRST_NAME] [varchar](20) NULL,
    [HIRE_DATE] [date] NOT NULL
);

INSERT INTO EMPLOYEES_N (EMPLOYEE_ID, FIRST_NAME, HIRE_DATE)
VALUES 
(1, 'Alice', '1975-06-15'),
(2, 'Bob',   '1976-04-12'),
(3, 'Carol', '1977-08-20'),
(4, 'David', '1979-01-10'),
(5, 'Eve',   '1980-09-05'),
(6, 'Frank', '1982-11-03'),
(7, 'Grace', '1983-03-14'),
(8, 'Hank',  '1984-07-22'),
(9, 'Ivy',   '1985-12-01'),
(10, 'Jack', '1990-05-17'),
(11, 'Kara', '1997-10-09');

--WITH RankedEmployees AS (
--    SELECT *,
--           ROW_NUMBER() OVER(PARTITION BY YEAR(HIRE_DATE) ORDER BY EMPLOYEE_ID) AS rn
--    FROM EMPLOYEES_N
--)
--SELECT YEAR(HIRE_DATE)
--FROM RankedEmployees
--WHERE rn = 1;



WITH AllYears AS (
    SELECT 1975 AS yr
    UNION ALL
    SELECT yr + 1 FROM AllYears WHERE yr + 1 <= 2025
),

HiredYears AS (
    SELECT DISTINCT YEAR(HIRE_DATE) AS yr
    FROM EMPLOYEES_N
),

MissingYears AS (
    SELECT ay.yr
    FROM AllYears ay
    LEFT JOIN HiredYears hy ON ay.yr = hy.yr
    WHERE hy.yr IS NULL
),

GroupedMissing AS (
    SELECT 
        yr,
        yr - ROW_NUMBER() OVER (ORDER BY yr) AS grp
    FROM MissingYears
)

SELECT 
    CONCAT(MIN(yr), ' - ', MAX(yr)) AS Missing_Year_Range
FROM GroupedMissing
GROUP BY grp