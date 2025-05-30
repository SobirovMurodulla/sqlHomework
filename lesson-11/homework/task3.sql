--Task 3

use class11Homework;
-- Create the WorkLog table
CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName NVARCHAR(100),
    Department NVARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

-- Insert data into WorkLog
INSERT INTO WorkLog (EmployeeID, EmployeeName, Department, WorkDate, HoursWorked)
VALUES 
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

select * from WorkLog;


CREATE VIEW vw_MonthlyWorkSummary AS
SELECT 
    E.EmployeeID,
    E.EmployeeName,
    E.Department,
    SUM(E.HoursWorked) AS TotalHoursWorked,
    D.TotalHoursDepartment,
    D.AvgHoursDepartment
FROM WorkLog E
JOIN (
    SELECT 
        Department,
        SUM(HoursWorked) AS TotalHoursDepartment,
        AVG(HoursWorked * 1.0) AS AvgHoursDepartment
    FROM WorkLog
    GROUP BY Department
) D ON E.Department = D.Department
GROUP BY E.EmployeeID, E.EmployeeName, E.Department, D.TotalHoursDepartment, D.AvgHoursDepartment;

select * from vw_MonthlyWorkSummary;