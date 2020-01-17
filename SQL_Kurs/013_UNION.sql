-- UNION

-- bisher: Ergebnis neue Tabelle mit entsprechend mehr Spalten

-- UNION kann Liste erstellen


USE Northwind
-- alt: wir bekommen mehrere Spalten
SELECT CompanyName, OrderID
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID


-- wir bekommen Liste
SELECT 'Testtext1' AS Test
UNION
SELECT 'Testtext2' -- AS Test (nicht notwendig, aber erlaubt)


SELECT CompanyName, ContactName, Phone
FROM Customers
UNION
SELECT CompanyName, ContactName, Phone
FROM Suppliers

-- geht nicht, muss gleich viele Spalten haben
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT HomePhone
FROM Employees


-- geht, SINN??
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT HomePhone, 'Text'
FROM Employees

-- NULL geht, aber SINN??
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT HomePhone, NULL
FROM Employees


-- geht nicht: müssen gleiche Datentypen sein (CompanyName ist nvarchar, EmployeeID ist int)
SELECT CompanyName, Phone
FROM Customers
UNION
SELECT EmployeeID, HomePhone
FROM Employees


-- Liste von allen Kontaktpersonen
-- Customers und Suppliers
SELECT c.CompanyName AS Customer, c.ContactName, c.Phone, s.CompanyName AS Supplier, s.ContactName, s.Phone 
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID
				 INNER JOIN Suppliers s ON s.SupplierID = p.SupplierID

-- UNION macht auch ein DISTINCT
SELECT 'Testtext'
UNION
SELECT 'Testtext'


-- wenn ich kein DISTINCT möchte: UNION ALL
SELECT 'Testtext'
UNION ALL
SELECT 'Testtext'

-- eigenen Text einfügen + Spaltenüberschrift
SELECT 'Text' AS Spaltenname


-- 1) Gib den Firmennamen, die Kontaktperson und die Telefonnummern aller Kunden und aller Supplier in einer Liste aus.
-- a.	Optional: Füge eine Kategorie „C“ für Customer und „S“ für Supplier hinzu.

SELECT CompanyName, ContactName, Phone, 'C' AS Category
FROM Customers
UNION
SELECT CompanyName, ContactName, Phone, 'S' -- AS Category
FROM Suppliers


-- 2) Gib alle Regionen der Kunden und der Angestellten aus.
-- a.	Optional: Füge eine Kategorie "C" für Customer und "E" für Employee hinzu.

SELECT Region, 'C' AS Category
FROM Customers
UNION
SELECT Region, 'E' -- AS Category (muss nicht dabeistehen)
FROM Employees


-- niedrigsten Frachtkostenwert
-- höchsten Frachtkostenwert
-- mit UNION untereinander


-- geht NICHT: 
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Auswertung
FROM Orders
ORDER BY Freight
UNION
SELECT TOP 1 OrderID, Freight, 'höchster Wert'
FROM Orders
ORDER BY Freight DESC -- dieses ORDER BY gilt auch für das obere SELECT


-- Möglichkeiten:
SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Auswertung
FROM Orders
WHERE Freight < 0.1
UNION
SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Auswertung
FROM Orders
WHERE Freight > 1000



-- andere Möglichkeit: temporäre Tabelle

SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Auswertung
INTO #niedrigsterWert
FROM Orders
ORDER BY Freight



SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Auswertung
INTO #hoechsterWert
FROM Orders
ORDER BY Freight DESC



SELECT *
FROM #niedrigsterWert
UNION
SELECT *
FROM #hoechsterWert

-- DROP TABLE #hoechsterWert


SELECT *
FROM #niedrigsterWert
UNION
SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Auswertung
FROM Orders
ORDER BY Freight DESC

SELECT *
FROM Orders


-- mit MIN/MAX

SELECT MIN(Freight) AS Frachtkosten
FROM Orders
UNION
SELECT MAX(Freight)
FROM Orders

-- geht NICHT:
SELECT OrderID, MIN(Freight) AS Frachtkosten
FROM Orders
-- GROUP BY OrderID -- funktioniert nicht, weil MIN Frachtkosten PRO OrderID = Frachtkosten
UNION
SELECT OrderID, MAX(Freight)
FROM Orders
-- GROUP BY OrderID



-- geht auch mit SUBSELECT:

SELECT *
FROM	(SELECT TOP 1 OrderID, Freight, 'niedrigster Wert' AS Auswertung 
		  FROM Orders 
		  ORDER BY Freight
		) lowest
UNION
SELECT *
FROM	(SELECT TOP 1 OrderID, Freight, 'höchster Wert' AS Auswertung
		  FROM Orders
		  ORDER BY Freight DESC
		) highest

