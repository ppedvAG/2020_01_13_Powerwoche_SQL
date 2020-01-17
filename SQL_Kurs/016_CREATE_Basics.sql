-- einfache Begriffe CREATE, INSERT, UPDATE, DELETE

-- Datenbank erstellen

CREATE DATABASE MyFirstDB

-- ganze Datenbank unwiederruflich löschen!!!! NEEEEEEIIIIIN!!!
-- DROP DATABASE MyFirstDB

-- Tabelle erstellen
-- CREATE TABLE Tabellenname
USE MyFirstDB

CREATE TABLE Produkte 
	(
		ProduktID int identity,
		Bezeichnung varchar(30),
		Preis money

	)


INSERT INTO Produkte (Bezeichnung, Preis)
VALUES ('Spaghetti', 2.50)

SELECT *
FROM Produkte


INSERT INTO Produkte (Bezeichnung, Preis)
VALUES ('Tiramisu', 4.50)



INSERT INTO Produkte (Bezeichnung, Preis)
VALUES	('Soße', 1.99),
		('Profiterols', 4.99),
		('Tartufo', 5.99),
		('Limoncello', 3.99)


DELETE FROM Produkte
WHERE ProduktID = 2

UPDATE Produkte
SET Preis = 1.98
WHERE ProduktID = 1


