USE class1Homework;
DROP TABLE IF EXISTS Book, Member, Loan;
CREATE TABLE Book(
	book_id INT PRIMARY KEY,
	title VARCHAR(50),
	author VARCHAR(50),
	published_year INT
);

CREATE TABLE Member(
	member_id INT PRIMARY KEY,
	name VARCHAR(50),
	email VARCHAR(50),
	phone_number VARCHAR(20),
);

CREATE TABLE Loan(
	loan_id INT PRIMARY KEY,
	book_id INT FOREIGN KEY(book_id) REFERENCES Book(book_id),
	member_id INT FOREIGN KEY(member_id) REFERENCES Member(member_id),
	loan_date DATE,
	return_date DATE NULL,
);

INSERT INTO Book (book_id, title, author, published_year)
VALUES 
    (1, '1984', 'George Orwell', 1949),
    (2, 'The Alchemist', 'Paulo Coelho', 1988),
    (3, 'To Kill a Mockingbird', 'Harper Lee', 1960);

INSERT INTO Member (member_id, name, email, phone_number)
VALUES 
    (1, 'Ali Karimov', 'ali.karimov@example.com', '998901234567'),
    (2, 'Zarina Sodiqova', 'zarina.sodiqova@example.com', '998911112233');

INSERT INTO Loan (loan_id, book_id, member_id, loan_date, return_date)
VALUES 
    (1, 1, 1, '2025-04-01', '2025-04-10'),
    (2, 2, 2, '2025-04-05', NULL),
    (3, 3, 1, '2025-04-07', '2025-04-12');

select * from book;
select * from Member;
select * from Loan;
