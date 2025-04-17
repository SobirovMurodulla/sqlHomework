USE class1Homework;

DROP TABLE IF EXISTS category;
CREATE TABLE category(
	category_id INT PRIMARY KEY,
	category_name VARCHAR(50)
);

DROP TABLE IF EXISTS item;
CREATE TABLE item(
	item_id INT PRIMARY KEY,
	item_name VARCHAR(50),
	category_id INT FOREIGN KEY(category_id) REFERENCES category(category_id)
);

ALTER TABLE item
DROP CONSTRAINT FK__item__category_i__71D1E811;

ALTER TABLE item
ADD CONSTRAINT fk_category_id FOREIGN KEY(category_id) REFERENCES category(category_id);
