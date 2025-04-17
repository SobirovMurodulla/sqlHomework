USE class1Homework;
DROP TABLE IF EXISTS product;
CREATE TABLE product(
	product_id INT UNIQUE,
	product_name VARCHAR(100),
	price DECIMAL(10, 2)
);

ALTER TABLE product
DROP CONSTRAINT UQ__product__47027DF4AB52E17A;

ALTER TABLE product
ADD CONSTRAINT unique_product_id UNIQUE(product_id, product_name);
