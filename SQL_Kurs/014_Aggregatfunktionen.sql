-- Aggregatfunktionen
-- aggregate functions


USE Northwind


SELECT ProductID
FROM Products


-- zähle, wieviele Produkte es gibt:

SELECT COUNT(ProductID) AS Produktanzahl
FROM Products


-- Durchschnitt berechnen (average)

SELECT AVG(UnitPrice)
FROM Products


SELECT AVG(Freight) AS [durchschnittliche Frachtkosten]
FROM Orders


-- geht NICHT:
SELECT AVG(CompanyName)
FROM Customers

-- niedrigsten Preis
SELECT MIN(UnitPrice)
FROM Products

-- höchster Preis
SELECT MAX(UnitPrice)
FROM Products


-- Summe
SELECT SUM(UnitPrice)
FROM Products
-- (Sinn?)


-- Summe Frachtkosten PRO Kunde

SELECT SUM(Freight) AS FreightSum, CustomerID, ShipCountry
FROM Orders
GROUP BY CustomerID, ShipCountry

-- nur 89 Ergebnisse, weil 2 Kunden noch nichts bestellt haben
-- Gruppieren nach CustomerID und ShipCountry (alle, die noch im Select stehen)


-- wieviele Kunden gibts PRO Stadt im jeweiligen Land?
-- Country, City, Anzahl Kunden


SELECT Country, City, COUNT(CustomerID)
FROM Customers
GROUP BY Country, City
ORDER BY Country, City



SELECT OrderID, ProductID, Quantity, UnitPrice*Quantity AS Preis
FROM [Order Details]


-- wie bekomme ich die Rechnungssumme?
SELECT OrderID, SUM(UnitPrice*Quantity) AS Rechnungssumme
FROM [Order Details]
-- WHERE OrderID = 10253  -- (Rechnungssumme von einer bestimmten Bestellung)
GROUP BY OrderID
 



-- inklusive Frachtkosten:
SELECT od.OrderID, SUM(UnitPrice*Quantity+Freight) AS Rechnungssumme
FROM [Order Details] od INNER JOIN Orders o ON od.OrderID = o.OrderID
GROUP BY od.OrderID
