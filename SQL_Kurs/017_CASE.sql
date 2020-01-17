-- CASE

USE Northwind

SELECT OrderID, Quantity,
	CASE
			WHEN Quantity > 10 THEN 'größer 10'
			WHEN Quantity < 10 THEN 'kleiner 10'
			ELSE 'unbekannt'
	END AS Anzahl
FROM [Order Details]
ORDER BY Quantity

-- Übung:
-- von Customers
-- CustomerID, Country... 
-- wenn EU Mitglied, dann 'EU'
-- wenn nicht EU Mitglied, dann 'nicht EU'
-- wenn nicht bekannt, dann 'keine Ahnung'


SELECT CustomerId, Country,
		CASE
				WHEN Country = 'Germany' THEN 'EU'
				WHEN Country = 'Austria' THEN 'EU'
				WHEN Country = 'France' THEN 'EU'
				WHEN Country = 'USA' THEN 'nicht EU'
				WHEN Country = 'Argentina' THEN 'nicht EU'
				WHEN Country = 'Brazil' THEN 'nicht EU'
				WHEN Country = 'UK' THEN 'Brexit'
				ELSE 'keine Ahnung'
		END AS Mitglied
FROM Customers



SELECT CustomerId, Country,
		CASE
				WHEN Country IN('Germany', 'Austria', 'France')THEN 'EU'
				WHEN Country IN('USA', 'Argentina', 'Brazil') THEN 'nicht EU'
				WHEN Country = 'UK' THEN 'Brexit'
				ELSE 'keine Ahnung'
		END AS Mitglied
FROM Customers


