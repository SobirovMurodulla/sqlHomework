USE class1Homework;
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
	customer_id INT PRIMARY KEY,
	name VARCHAR(50),
	city VARCHAR DEFAULT 'Unknown'
);

ALTER TABLE customer
DROP CONSTRAINT DF__customer__city__02FC7413;

ALTER TABLE customer
ADD CONSTRAINT DF_city_name DEFAULT 'Unknown' FOR city;