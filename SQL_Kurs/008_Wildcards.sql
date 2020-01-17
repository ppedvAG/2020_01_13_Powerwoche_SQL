-- Wildcards nur beim LIKE
-- außer * beim SELECT (alle Spalten)


-- % steht für beliebig viele unbekannte Zeichen (0 - ?)

USE Northwind

-- soll mit ALF beginnen
SELECT *
FROM Customers
WHERE CustomerID LIKE 'ALF%'


-- soll mit MI enden
SELECT *
FROM Customers
WHERE CustomerID LIKE '%MI'

-- wo IRGENDWO im Namen kist vorkommt
SELECT *
FROM Customers
WHERE CompanyName LIKE '%kist%'


-- alle, deren Firmenname mit D beginnt
SELECT *
FROM Customers
WHERE CompanyName LIKE 'd%'

-- Gib alle Produkte aus, deren Name mit Coffee endet.
SELECT *
FROM Products
WHERE ProductName LIKE '%coffee'

-- 8) Gib alle Produkte aus, deren Name mit 'L' beginnt.
SELECT *
FROM Products
WHERE ProductName LIKE 'L%'



-- 9) Gib alle Produkte aus, die ein 'ost' im Namen haben.
SELECT *
FROM Products
WHERE ProductName LIKE '%ost%'


-- 10) Gib alle Produkte aus, die vom Anbieter (SupplierID) 5, 10 oder 15 stammen, von denen mehr als 10 Stück vorrätig sind und deren Stückpreis unter 100 liegt. Ordne das Ergebnis absteigend vom höchsten zum niedrigsten Stückpreis.

SELECT *
FROM Products
WHERE	  SupplierID IN(5, 10, 15)
	AND	  UnitsInStock > 10
	AND	  UnitPrice < 100
ORDER BY UnitPrice DESC

-- 11) Wieviele Produkte bietet der Anbieter Nr. 17 an?
SELECT COUNT(ProductID)
FROM Products
WHERE SupplierID = 17 -- 3


-- alle Kunden, die ein d im Namen haben und mit e enden
SELECT *
FROM Customers
WHERE CompanyName LIKE '%d%' AND CompanyName LIKE '%e'
-- oder:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%d%e'


-- alle die mit a beginnen, irgendwo im Namen ein f haben und aus Deutschland sind
SELECT *
FROM Customers
WHERE CompanyName LIKE 'a%f%'
	AND Country = 'Germany'


-- alle Bestellungen, von Angestellten 1, 3, 5, von Kunden, die mit R beginnen und wo Frachtkosten kleiner als 100 sind

SELECT *
FROM Orders
WHERE EmployeeID IN (1, 3, 5)
		AND CustomerID LIKE 'r%'
		AND Freight < 100

-- eckige Klammern Spaltenname AS [Frachtkosten Brutto]
-- FROM [Order Details]

-- Wertebereiche []
-- steht für genau 1 unbekanntes Zeichen in einem bestimmten Bereich
-- von bis


-- beginnt mit a, b oder c
SELECT *
FROM Customers
WHERE CompanyName LIKE '[a-c]%'


-- beginnt mit a oder c
SELECT *
FROM Customers
WHERE CompanyName LIKE '[ac]%'

SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%' -- irgendwo im Namen muss ein %-Zeichen vorkommen


SELECT *
FROM Customers
WHERE CompanyName LIKE '%''%'

-- 12) Gib alle Produkte aus, deren Name mit D-L beginnt und mit a, b, c, d oder m, n, o endet.


--1 
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[a-dm-o]' -- ??

-- 2
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%' AND ProductName LIKE '%[abcdmno]'

-- 3
SELECT *
FROM Products
WHERE ProductName LIKE '[d-l]%[a-d | m-o]'



-- ESCAPE - für Suche nach Sonderzeichen

SELECT *
FROM Customers
WHERE CompanyName LIKE '%[%]%' -- sucht nach %-Zeichen

-- ODER SO:
SELECT *
FROM Customers
WHERE CompanyName LIKE '%!%%' ESCAPE '!'


SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-47[0-9]9'

-- ODER SO:
SELECT *
FROM Customers
WHERE Phone LIKE '(5) 555-47_9' -- Unterstrich steht für genau 1 unbekanntes Zeichen


-- % steht für beliebig viele (0 - ??) unbekannte Zeichen
-- _ steht für genau 1 unbekanntes Zeichen
-- [] steht für genau 1 Zeichen aus einem bestimmten Bereich



-- alle Kunden, die mit d-f beginnen, der letzte Buchstabe ist ein l und der DRITTletzte ist ein d

SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%d_l'

-- oder:

SELECT *
FROM Customers
WHERE CompanyName LIKE '[d-f]%' AND RIGHT(CompanyName, 3) LIKE 'd_l'


/*
mögliche Lösungen:

		ddel
		edel
		fdal
		fxxxxxxxxxxxdyl

		Ernst Handel
		E........d.l


*/