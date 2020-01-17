-- Tabelle erstellen

USE MyFirstDB

CREATE TABLE Leser (
	LeserID int identity(10, 1) PRIMARY KEY,
	Vorname varchar(50) NOT NULL,
	Nachname varchar(50) NOT NULL,
	GebDatum date
)


CREATE TABLE Verleih(
	LeserID int,
	BuchID int,
	von date,
	bis date
)


ALTER TABLE Verleih
ADD CONSTRAINT FK_LeserVerleih
FOREIGN KEY (LeserID) REFERENCES Leser(LeserID)

