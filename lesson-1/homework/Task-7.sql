USE class1Homework;

DROP TABLE IF EXISTS invoice;
CREATE TABLE invoice(
	invoice_id INT IDENTITY(1,1),
	amount DECIMAL(10,3)
);
INSERT INTO invoice(amount)
values
(1000),
(2000),
(4000),
(8000),
(3000);

SET IDENTITY_INSERT invoice ON;
INSERT INTO invoice(invoice_id, amount)
values(8, 9000);
SET IDENTITY_INSERT invoice OFF;