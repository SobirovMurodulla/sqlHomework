--CREATE DATABASE class1Homework;
--GO
USE class1Homework;
DROP TABLE IF EXISTS student
CREATE TABLE student(
	id INT,
	name VARCHAR(50),
	age INT
);

ALTER TABLE student
ALTER COLUMN id INT NOT NULL;
