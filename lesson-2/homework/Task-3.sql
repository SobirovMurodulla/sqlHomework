USE class2Homework;

DROP TABLE IF EXISTS photos;
CREATE TABLE photos(
	id INT IDENTITY,
	image VARBINARY(MAX)
);

INSERT INTO photos
select BulkColumn from OPENROWSET(
	BULK 'C:\Users\Murod\OneDrive\Desktop\SQL\lesson-2\homework\city.png', SINGLE_BLOB
)as img;

SELECT * FROM photos;


