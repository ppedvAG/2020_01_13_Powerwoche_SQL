-- DISTINCT

USE Northwind

-- in welche Länder liefern wir?

SELECT Country
FROM Customers
ORDER BY Country


SELECT DISTINCT Country
FROM Customers
ORDER BY Country
-- 21 Zeilen Ergebnis - so viele, wie Länder


SELECT DISTINCT CustomerID, Country
FROM Customers
ORDER BY Country
-- bringt nix, weil jetzt so viele ausgegeben werden, wie Customers da sind (91)


SELECT DISTINCT Country, City
FROM Customers
ORDER BY Country, City



SELECT DISTINCT City, Country
FROM Customers
ORDER BY Country, City

-- Länder, in denen Angestellte wohnen
SELECT DISTINCT Country
FROM Employees

-- Überprüfen: ja, stimmt, UK und USA
SELECT *
FROM Employees
ORDER BY Country

-- Städte, in denen wir auch Kunden haben?
SELECT DISTINCT City
FROM Customers





