USE class10Homework;
DROP TABLE IF EXISTS Shipments;
CREATE TABLE Shipments (
    N INT PRIMARY KEY,
    Num INT
);

INSERT INTO Shipments (N, Num) VALUES
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1),
(9, 2), (10, 2), (11, 2), (12, 2), (13, 2), (14, 4), (15, 4), 
(16, 4), (17, 4), (18, 4), (19, 4), (20, 4), (21, 4), (22, 4), 
(23, 4), (24, 4), (25, 4), (26, 5), (27, 5), (28, 5), (29, 5), 
(30, 5), (31, 5), (32, 6), (33, 7);


WITH ShipmentCounts AS (
    SELECT Num, COUNT(*) AS freq
    FROM Shipments
    GROUP BY Num

    UNION ALL

    SELECT 0 AS Num, 7 AS freq
),

Tally AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Tally WHERE n < 40
),
Expanded AS (
    SELECT sc.Num
    FROM ShipmentCounts sc
    JOIN Tally t ON t.n <= sc.freq
),
Ordered AS (
    SELECT Num, ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM Expanded
),
MedianVals AS (
    SELECT Num
    FROM Ordered
    WHERE rn IN (20, 21)
)
SELECT AVG(1.0 * Num) AS median
FROM MedianVals
OPTION (MAXRECURSION 100);

