-- Subselect, subquery
-- Unterabfragen

--SELECT Spalte - Subselect wie Spalte verwenden
--FROM Tabelle - Subselect wie Tabelle verwenden (als Datenquelle)
--WHERE Bedingung - Subselect als Bedingung

USE Northwind

-- Subselect wie eine Spalte verwenden (darf dann nur eine Spalte haben)

SELECT	  'Text'
		, 100
		, Freight
		, (SELECT TOP 1 Freight FROM Orders) -- das hier steht dann in allen Zeilen ;)
											 -- Spaltenüberschrift macht Sinn, muss aber nicht unbedingt
FROM Orders



-- Subselect wie Tabelle verwenden (Subselect als Datenquelle)

SELECT *
FROM -- Tabelle??
-- ->
		(SELECT OrderID, Freight FROM Orders WHERE EmployeeID = 3) t1 -- wenn Subselect Datenquelle, dann MUSS Name vergeben werden (t1)
WHERE t1.Freight > 100

--SELECT Spalte
--FROM Tabelle
--WHERE Bedingung
-- [ORDER BY]


-- Subselect in WHERE- Abfrage

SELECT *
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight

-- 1) Gib mittels Subselect alle Kunden aus, die in einem Land wohnen, aus dem auch Bestellungen verschifft werden.

-- in welche Länder wird geliefert?
SELECT DISTINCT ShipCountry
FROM Orders

SELECT *
FROM Customers
WHERE Country = 'Germany'
  OR Country = 'Austria'


SELECT *
FROM Customers
WHERE Country IN ('Germany', 'Austria')


set statistics io, time on
SELECT *
FROM Customers
WHERE Country IN (SELECT ShipCountry FROM Orders)


-- funktioniert so nicht, weil da stehen die zwei, die noch nix bestellt haben, nicht dabei:
SELECT DISTINCT *
FROM (SELECT CustomerID, ShipCountry FROM Orders WHERE ShipCountry IS NOT NULL) t1


-- 2) Gib alle Bestellungen aus, deren Frachtkosten kleiner sind als der Durchschnitt der Frachtkosten.
-- a.	Optional: In absteigender Reihenfolge geordnet (vom größten zum kleinsten Wert).

SELECT *
FROM Orders
WHERE Freight < (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight DESC
