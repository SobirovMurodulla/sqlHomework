USE class1Homework;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id INT PRIMARY KEY,
	customer_name VARCHAR(50),
	order_date DATE
);

ALTER TABLE orders
DROP CONSTRAINT PK__orders__46596229DAB74A36;

ALTER TABLE orders
ADD CONSTRAINT order_id_primary_key PRIMARY KEY(order_id);

