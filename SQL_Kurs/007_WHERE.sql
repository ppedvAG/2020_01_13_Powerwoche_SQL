-- WHERE clause, WHERE-Klausel, WHERE-Bedingung
-- wenn nur bestimmte Ergebnisse zurückgegeben werden sollen


/*

	SELECT Spalte, Spalte,...
	FROM Tabelle
	WHERE eine Bedingung zutriff
	ORDER BY Spalte


	WHERE Operatoren
						=, <, >, <=, >=
						!=, <> -- darf NICHT diesem Wert entsprechen
						

			-- nicht so gut für Performance:
			NOT IS
			NOT LIKE
			NOT BETWEEN


			-- kann ich auch verwenden:
			IN
			LIKE
			BETWEEN

			AND, OR


*/

USE Northwind


-- nur die Kunden aus Deutschland

SELECT *
FROM Customers
WHERE Country = 'Germany'


SELECT *
FROM Customers
WHERE Country = 'Austria'

-- alle in Deutschland in Berlin
SELECT *
FROM Customers
WHERE Country = 'Germany'
		AND City = 'Berlin'

-- alle deutschen und österreichischen Kunden
SELECT *
FROM Customers
WHERE Country = 'Germany'
	OR Country = 'Austria' -- OR!! (die leben nicht gleichzeitig in D und A)


SELECT *
FROM Customers
WHERE Country = 'Germany'
	OR Country = 'Austria'
	AND City = 'Salzburg'


-- alle Frachtkosten unter 50
SELECT *
FROM Orders
WHERE Freight < 50
ORDER BY Freight DESC


-- Frachtkosten, die NICHT 48.83 sind
SELECT *
FROM Orders
WHERE Freight != 48.83
ORDER BY Freight DESC

-- 1) Gib nur die Kunden aus, die in Frankreich wohnen.
SELECT *
FROM Customers
WHERE Country = 'France'


--2) Gib alle Kunden aus, die in Buenos Aires in Argentinien wohnen.

SELECT *
FROM Customers
WHERE Country = 'Argentina'
		AND City = 'Buenos Aires'


-- 4) Gib alle Produkte aus, von denen mehr als 100 vorhanden sind.

SELECT *
FROM Products
WHERE UnitsInStock > 100


SELECT *
FROM Orders
WHERE Freight >= 100 AND Freight <= 200


-- ODER:

SELECT*
FROM Orders
WHERE Freight BETWEEN 100 AND 200

SELECT *
FROM Orders
WHERE EmployeeID = 3
		OR EmployeeID = 5
		OR EmployeeID = 7
ORDER BY EmployeeID


SELECT *
FROM Orders
WHERE (EmployeeID = 3
		OR EmployeeID = 5
		OR EmployeeID = 7)
		AND ShipCountry = 'Germany'
ORDER BY EmployeeID

-- ODER:

SELECT *
FROM Orders
WHERE EmployeeID IN(3, 5, 7)



SELECT *
FROM Orders
WHERE EmployeeID IN(3, 5, 7)
	AND ShipCountry = 'Germany'

-- 5) Gib alle Produkte aus, deren ProduktID zwischen 10 und 15 (inklusive) liegt.
SELECT *
FROM Products
WHERE ProductID BETWEEN 10 AND 15

-- 6) Gib alle Produkte aus, die vom Anbieter (SupplierID) 2, 7 oder 15 geliefert werden.

SELECT *
FROM Products
WHERE SupplierID IN(2, 7, 15)
