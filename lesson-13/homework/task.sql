use class13Homework;
DECLARE @Year INT = 2025;
DECLARE @Month INT = 6;

;WITH Dates AS (
    SELECT 
        CAST(DATEFROMPARTS(@Year, @Month, 1) AS DATE) AS CalendarDate
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, CalendarDate)
    FROM Dates
    WHERE CalendarDate < EOMONTH(DATEFROMPARTS(@Year, @Month, 1))
)
, Calendar AS (
    SELECT 
        CalendarDate,
        DATEPART(WEEK, CalendarDate) - DATEPART(WEEK, DATEFROMPARTS(@Year, @Month, 1)) + 1 AS WeekNum,
        DATEPART(WEEKDAY, CalendarDate) AS WeekDayNum
    FROM Dates
)
SELECT
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 1 THEN DAY(CalendarDate) END) AS [Sunday],
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 2 THEN DAY(CalendarDate) END) AS [Monday],
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 3 THEN DAY(CalendarDate) END) AS [Tuesday],
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 4 THEN DAY(CalendarDate) END) AS [Wednesday],
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 5 THEN DAY(CalendarDate) END) AS [Thursday],
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 6 THEN DAY(CalendarDate) END) AS [Friday],
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 7 THEN DAY(CalendarDate) END) AS [Saturday]
FROM Calendar
GROUP BY WeekNum
ORDER BY WeekNum
OPTION (MAXRECURSION 1000);