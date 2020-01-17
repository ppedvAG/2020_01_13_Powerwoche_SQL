-- VIEW WITH CHECK OPTION


CREATE TABLE Helden (
						firstname varchar(30),
						lastname varchar(30),
						age int
					)

INSERT INTO Helden (firstname, lastname, age)
		VALUES ('James', 'Bond', 40),
			   ('Bruce', 'Wayne', 35),
			   ('Peter', 'Parker', 23)


SELECT * FROM Helden


CREATE VIEW vHeldentest
AS
SELECT firstname
		, lastname
		, age
FROM Helden
WHERE age IS NOT NULL


SELECT *
FROM vHeldentest


INSERT INTO vHeldentest(firstname, lastname, age)
	VALUES    ('Luke', 'Skywalker', 18)
			, ('Obi Wan', 'Kenobi', NULL)


DROP VIEW vHeldentest



CREATE VIEW vHeldentest
AS
SELECT firstname
		, lastname
		, age
FROM Helden
WHERE age IS NOT NULL
WITH CHECK OPTION



SELECT *
FROM vHeldentest

INSERT INTO vHeldentest(firstname, lastname, age)
		VALUES   ('Mickey', 'Mouse', 42)



SELECT * FROM Helden


INSERT INTO vHeldentest(firstname, lastname, age)
		VALUES ('Donald', 'Duck', NULL)


INSERT INTO Helden(firstname, lastname, age)
		VALUES('Saphira', NULL, NULL)