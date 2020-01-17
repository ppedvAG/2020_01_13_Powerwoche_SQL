USE MyFirstDB

SELECT *
INTO Suppliers
FROM Northwind.dbo.Suppliers


SELECT *
FROM Suppliers

ALTER TABLE Suppliers
ADD Email varchar(50)


-- geht nicht, Datentyp nvarchar kann nicht in Datentyp int umgewandelt werden!
ALTER TABLE Suppliers
ALTER COLUMN City int

-- Datentyp von varchar(50) zu varchar(70) ändern geht:
ALTER TABLE Suppliers
ALTER COLUMN Email varchar(70)


-- Spalte unwiederruflich löschen... VORSICHT!!! Die ist dann WEG!!!
ALTER TABLE Suppliers
DROP COLUMN Region



-- Employees aus Northwind -> MyFirstDB
-- Employees bekommen neue Spalte Salary; Dateityp z.B. money
-- EmployeeID 1 = 2500
-- 2 = 8000
-- 3 = 1800
-- 4 = 5000
-- 5 = 3200
-- 6 = 3100
-- 7 = 2300
-- 8 = 2800
-- 9 = 3000
-- Gehalt einfügen

UPDATE Suppliers
SET Email = 'abcdefg'

UPDATE Employees
SET Salary = 3000
WHERE EmployeeID IN(1,3,4)

-- SUBQUERY- Übungen
-- 1)	(Employees in der MyFirstDB): Gib die EmployeeID, den Vor- und Nachnamen und das Gehalt aller Mitarbeiter aus, die ein höheres Gehalt beziehen als der Mitarbeiter mit der EmployeeID 8.

SELECT EmployeeID, CONCAT(FirstName, ' ' , LastName) AS Name, Salary
FROM Employees
WHERE Salary > (SELECT Salary from Employees WHERE EmployeeID = 8)


-- 2) MyFirstDB: Gib die EmployeeID, Name, Gehalt und Land der Mitarbeiter aus, die das niedrigste Gehalt in ihrem Land beziehen.

-- kleinster Gehalt pro Land:
SELECT MIN(Salary) FROM Employees GROUP BY Country

-- meine Abfrage, was möchte ich ausgegeben haben:
SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, Salary
		, Country
FROM Employees


SELECT	  EmployeeID
		, CONCAT(FirstName, ' ', LastName) AS FullName
		, Salary
		, Country
FROM Employees
WHERE Salary IN(SELECT MIN(Salary) FROM Employees GROUP BY Country)


-- 3)	MyFirstDB: Gib die Namen der Employees aus, deren Gehalt zwischen dem niedrigsten Gehalt und 3000 liegt.

-- wie bekomme ich niedrigsten Gehalt?
SELECT MIN(Salary) FROM Employees

-- Abfrage?
SELECT	  FirstName
		, LastName
		, Salary
FROM Employees
WHERE Salary BETWEEN (SELECT MIN(Salary) FROM Employees) AND 3000
ORDER BY Salary


-- 4)	Northwind oder MyFirstDB: Gib die Namen und das EinstellungsJAHR der Mitarbeiter aus, die im selben JAHR eingestellt wurden wie der Angestellte namens King.

-- wie bekomme ich das Jahr, in dem King eingestellt worden ist
SELECT FORMAT(HireDate, 'yyyy') FROM Employees WHERE LastName = 'King' AND FirstName = 'Robert' AND TitleOfCourtesy = 'Mr.'
-- oder:
SELECT YEAR(HireDate) FROM Employees WHERE LastName = 'King' AND FirstName = 'Robert' AND TitleOfCourtesy = 'Mr.'


SELECT FirstName, LastName, YEAR(HireDate) AS HireDate
FROM Employees
WHERE YEAR(HireDate) = (SELECT YEAR(HireDate) FROM Employees WHERE LastName = 'King' AND FirstName = 'Robert' AND TitleOfCourtesy = 'Mr.')
	AND LastName != 'King'


-- 5)	Northwind-DB oder MyFirstDB: Gib die SupplierID, den CompanyName, die Kontaktinformation und das Land aller Supplier aus, die aus dem gleichen Land sind wie der Supplier mit der ID 2.

--USE Northwind
SELECT *
FROM Suppliers
ORDER BY Country


-- Land vom Supplier mit ID 2?
SELECT Country FROM Suppliers WHERE SupplierID = 2



SELECT	  SupplierID
		, CompanyName
		, ContactTitle
		, ContactName
		, Phone
		, Country
		, [Address]
FROM Suppliers
WHERE Country = (SELECT Country FROM Suppliers WHERE SupplierID = 2)

-- 6)	MyFirstDB: Gib die EmployeeID, den Namen, das Gehalt und die Region der Mitarbeiter aus, deren Gehalt über 2500 liegt und deren Region nicht NULL ist.

-- IS NULL - Abfrage im WHERE
-- IS NOT NULL
-- ISNULL(WAS, 'Alternative') - Funktion im SELECT
-- ISNULL(Region, 'keine Angabe')
-- ISNULL(Region, ' ') - Leerstring, dann kommt bei der Ausgabe ein leeres Feld statt 'NULL'

-- wo Region nicht NULL
-- geht mit Subselect... ist aber nicht sehr schlau...
SELECT * FROM Employees WHERE Region IS NOT NULL

SELECT	  EmployeeID
		, FirstName
		, LastName
		, Salary
		, Region
FROM (SELECT * FROM Employees WHERE Region IS NOT NULL) AS rnn
WHERE Salary > 2500

-- wir brauchen hier keine Subquery!!!
SELECT	  EmployeeID
		, FirstName
		, LastName
		, Salary
		, Region
FROM Employees
WHERE Region IS NOT NULL AND Salary > 2500



-- ***********************************************

-- Experten SELECT
-- JOIN auf selbe Tabelle
-- so tun, als wären es mehrere Tabellen

/*

Name vom Employee - EmployeeID - ReportsTo - Name vom Chef - EmployeeID vom Chef
Robert King				3			2		  Andrew Fuller		      2



SELECT *
FROM Employees
*/

USE Northwind

SELECT    CONCAT(emp.FirstName, ' ', emp.LastName) AS EmployeeName
		, emp.EmployeeID
		, ISNULL(CAST(emp.ReportsTo AS varchar(20) ), 'ist Chef')
		, CONCAT(ISNULL(chef.FirstName, 'ist Chef'), ' ', chef.LastName) AS ChefName
		, chef.EmployeeID
FROM Employees emp LEFT JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID



SELECT    CONCAT(emp.FirstName, ' ', emp.LastName) AS EmployeeName
		, emp.EmployeeID
		, ISNULL(CAST(emp.ReportsTo AS varchar(20) ), 'ist Chef')
		, CONCAT(chef.FirstName, 'x', chef.LastName) AS ChefName
		, chef.EmployeeID
FROM Employees emp LEFT JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID





SELECT    CONCAT(emp.FirstName, ' ', emp.LastName) AS EmployeeName
		, emp.EmployeeID
		, ISNULL(CAST(emp.ReportsTo AS varchar(20) ), 'ist Chef')
		, chef.FirstName, 
		 chef.LastName
		, chef.EmployeeID
FROM Employees emp LEFT JOIN Employees chef ON emp.ReportsTo = chef.EmployeeID


--'2'
--'3'
--'4'
--ISNULL(CAST(Spalte AS varchar(20)), 'Text')
--CAST(Spalte AS varchar(20))


SELECT    
		  LastName
		, EmployeeID
		, ReportsTo
INTO #Angestellte
FROM Employees

SELECT    CONCAT(FirstName, ' ', LastName) as chef
		, EmployeeID
INTO #Chef
FROM Employees

--DROP TABLE #Chef
SELECT *
FROM #Angestellte as A LEFT JOIN #Chef as C ON A.ReportsTo = C.EmployeeID


select *
from Employees

SELECT * FROM #Chef

-- UPDATE mit CASE
UPDATE Suppliers
SET Email = CASE
				WHEN SupplierID = 2 THEN 'uvw'
				WHEN SupplierID = 5 THEN 'xyz'
				ELSE Email
			END

SELECT SupplierID, Email
FROM Suppliers


-- Employees: Gehalt (Salary) mit CASE
UPDATE Employees
SET Salary = CASE
				WHEN EmployeeID = 1 THEN 2900
				ELSE Salary
			 END

SELECT EmployeeID, Salary
FROM Employees


UPDATE Employees
SET Salary = CASE
				WHEN EmployeeID IN(1,3,4) THEN 1000
				ELSE Salary
			 END



USE MyFirstDB
UPDATE Employees
SET Salary 
	= CASE
			WHEN EmployeeID <= (SELECT AVG(Salary) FROM Employees) THEN Salary*1.027
			WHEN EmployeeID > (SELECT AVG(Salary) FROM Employees) THEN Salary*1.018
			ELSE Salary
		END



