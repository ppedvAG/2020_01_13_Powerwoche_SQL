-- TOP Befehl, TOP Abfragen
-- ORDER BY zwingend notwendig für sinnvolle Ausgabe



USE Northwind

SELECT *
FROM Customers

-- erste Zeile wovon??
SELECT TOP 1 *
FROM Customers

-- ORDER BY! 1. Zeile wovon??
SELECT TOP 1 *
FROM Customers
ORDER BY City


SELECT TOP 3 *
FROM Customers
ORDER BY City


SELECT TOP 10 PERCENT *
FROM Customers
ORDER BY City

/*

SELECT TOP # [PERCENT] * | [Spaltenname, Spaltenname,...]
FROM Tabelle [JOINS]
[WHERE Bedingung]
ORDER BY Spalte[, Spalte]


*/


SELECT TOP 5 PERCENT 
				   CustomerID
				 , CompanyName
				 , ContactName
				 , Phone
FROM Customers
ORDER BY City


-- die letzten 3
SELECT TOP 3 *
FROM Customers
ORDER BY City DESC -- Reihenfolge mit DESC umkehren


SELECT TOP 1 PERCENT WITH TIES *
FROM [Order Details]
ORDER BY UnitPrice DESC


-- 1)	Gib das teuerste Produkt aus. 
SELECT TOP 1 ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

-- überprüfen?
SELECT ProductName, UnitPrice
FROM Products
ORDER BY UnitPrice DESC

/*
2)
Suche die Top 10% der Produkte mit den größten Einkaufsmengen (ProductName, Quantity). 
	a. Optional: Einschließlich Produkte mit der gleichen Einkaufsmenge wie das letzte in der ursprünglichen Ausgabe. 
*/

SELECT DISTINCT TOP 10 PERCENT ProductName, Quantity
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
ORDER BY Quantity DESC


-- optional:
SELECT DISTINCT TOP 10 PERCENT WITH TIES ProductName, Quantity
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID
ORDER BY Quantity DESC


-- 3) Gib die drei Mitarbeiter, die als erste eingestellt wurden, aus (die schon am längsten beim Unternehmen sind). 

SELECT TOP 3 LastName, FirstName, FORMAT(HireDate, 'dd.MM.yyyy') AS HireDate
FROM Employees
ORDER BY HireDate -- ASC


-- angenommen 13 Topkunden bekommen Bonus (die mit den geringsten Frachtkosten)
-- wer sind die Glücklichen? CompanyName

SELECT TOP 13 CompanyName
			, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY Freight


-- der 14. auch die gleichen Frachtkosten hat, wie Nr. 13
SELECT TOP 13 WITH TIES CompanyName
			, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY Freight


SELECT *
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY Freight


SELECT TOP 20 WITH TIES CompanyName
			, Freight
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
ORDER BY Freight





