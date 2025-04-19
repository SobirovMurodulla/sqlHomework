USE class2Homework;

DROP TABLE IF EXISTS worker;
CREATE TABLE worker(
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR(100)
);


BULK INSERT worker
FROM 'C:\Users\Murod\OneDrive\Desktop\SQL\lesson-2\homework\sample.csv'
WITH (
	FIRSTROW = 2,
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n'
);

SELECT * FROM worker;
