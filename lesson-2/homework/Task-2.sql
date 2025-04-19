USE class2Homework;

DROP TABLE IF EXISTS data_types_demo;
CREATE TABLE data_types_demo(
	id INT PRIMARY KEY IDENTITY,
	Tint TINYINT,
	Sint SMALLINT,
	Bint BIGINT,
	birth_date DATE,
	birth_time TIME,
	firstCry DATETIME
);

INSERT INTO data_types_demo
VALUES(1,255,1456,'1950-11-23', '12:50:23',GETDATE());

SELECT * FROM data_types_demo;