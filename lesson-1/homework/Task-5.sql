USE class1Homework;

DROP TABLE IF EXISTS account;
CREATE TABLE account(
	account_id INT PRIMARY KEY,
	balance DECIMAL(10,2) CHECK (balance >= 0),
	account_type VARCHAR(20) CHECK (account_type in ('Saving', 'Checking'))
);

ALTER TABLE account
DROP CONSTRAINT CK__account__balance__75A278F5;

ALTER TABLE account
DROP CONSTRAINT CK__account__account__76969D2E;

ALTER TABLE account
ADD CONSTRAINT CK_account_balance CHECK (balance >= 0);

ALTER TABLE account
ADD CONSTRAINT CK_account_type CHECK (account_type IN ('Saving', 'Checking'));

