use class4Homework;

DROP TABLE IF EXISTS EmpBirth;

CREATE TABLE EmpBirth
(
    EmpId INT  IDENTITY(1,1) 
    ,EmpName VARCHAR(50) 
    ,BirthDate DATETIME 
);
 
INSERT INTO EmpBirth(EmpName,BirthDate)
SELECT 'Pawan' , '12/04/1983'
UNION ALL
SELECT 'Zuzu' , '11/28/1986'
UNION ALL
SELECT 'Parveen', '05/07/1977'
UNION ALL
SELECT 'Mahesh', '01/13/1983'
UNION ALL
SELECT'Ramesh', '05/09/1983';

select EmpName, FORMAT(BirthDate, 'yyyy-MM-dd') AS BirthDate 
from EmpBirth
where MONTH(BirthDate) = 5 --which is May
	AND DAY(BirthDate) BETWEEN 7 AND 15
