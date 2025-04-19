USE class2Homework;

DROP TABLE IF EXISTS test_identity;
CREATE TABLE test_identity(
	id INT PRIMARY KEY IDENTITY(1,1),
	name VARCHAR(25)
);

INSERT INTO test_identity (name)
VALUES ('A'), ('B'), ('C'), ('D'), ('E');

SELECT * FROM test_identity;
/*DELETE*/
DELETE FROM test_identity;
SELECT * FROM test_identity;
INSERT INTO test_identity (name) VALUES ('F');
SELECT * FROM test_identity;

/*TRUNCATE*/
TRUNCATE TABLE test_identity;

INSERT INTO test_identity (name) VALUES ('G');

SELECT * FROM test_identity;

/*DROP*/

DROP TABLE test_identity;

--select * from test_identity gives error