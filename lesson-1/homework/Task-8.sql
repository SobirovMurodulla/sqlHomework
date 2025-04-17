USE class1Homework;

DROP TABLE IF EXISTS books;
CREATE TABLE books(
	book_id INT PRIMARY KEY IDENTITY,
	title VARCHAR(100) NOT NULL,
	price DECIMAL(10,2) CHECK (price > 0),
	genre VARCHAR(15) DEFAULT 'Unknown'
);

INSERT INTO books(title,price)
values
('1984',64)
select * from books;