-- JOINS

-- INNER JOIN

-- LEFT JOIN
				-- OUTER JOINS
-- RIGHT JOIN


USE Northwind

-- INNER JOIN 

SELECT *
FROM Customers INNER JOIN Orders
						ON Customers.CustomerID = Orders.CustomerID

-- wenn ein Name mehrmals vorkommt, dann muss ich dazuschreiben, aus welcher Tabelle
SELECT	  OrderID
		, Customers.CustomerID
		, CompanyName
		, [Address]
FROM Customers INNER JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID


-- ich kann, muss aber nicht dazuschreiben, aus welcher Tabelle:
SELECT	  Orders.OrderID
		, Customers.CustomerID
		, Customers.CompanyName
		, Customers.[Address]
FROM Customers INNER JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID


-- kürzere Schreibweise
SELECT	  o.OrderID AS Bestellnummer
		, c.CustomerID
		, c.CompanyName
		, c.[Address]
FROM Customers AS c INNER JOIN Orders AS o
		ON c.CustomerID = o.CustomerID


-- noch ein bisschen kürzere Schreibweise
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, c.[Address]
FROM Customers c INNER JOIN Orders o  -- AS darf weggelassen werden
		ON c.CustomerID = o.CustomerID


-- auch hier können wir weiter einschränken
SELECT	  o.OrderID
		, c.CustomerID
		, c.CompanyName
		, c.[Address]
	--  , City
FROM Customers c INNER JOIN Orders o  
		ON c.CustomerID = o.CustomerID
WHERE Country = 'Germany'
ORDER BY c.City



-- alle, auch die, die noch nix bestellt haben
SELECT *
FROM Customers c LEFT JOIN Orders o  
		ON c.CustomerID = o.CustomerID


-- nur die, die schon etwas bestellt haben
SELECT *
FROM Customers c RIGHT JOIN Orders o  
		ON c.CustomerID = o.CustomerID

-- nur die, die noch nix bestellt haben
SELECT *
FROM Customers c LEFT JOIN Orders o
		ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


-- mehrere Tabellen miteinander verknüpfen:

SELECT *
FROM Orders o INNER JOIN [Order Details] od
				ON o.OrderID = od.OrderID
			  INNER JOIN Products p
				ON od.ProductID = p.ProductID


SELECT	  c.CustomerID -- c. muss man dazuschreiben, wenn Name in mehreren Tabellen vorkommt
		, CompanyName
		, Country
		, o.OrderID  -- o. kann man, muss man aber nicht dazuschreiben
		, OrderDate -- geht auch ohne
FROM Customers c LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE OrderID IS NULL


-- 1) Gib den Namen des Anbieters, der Chai Tee verkauft, aus. (CompanyName, ProductName; optional: Ansprechperson, Telefonnummer)

SELECT	  CompanyName
		, ProductName
		, ContactName
		, Phone
FROM Suppliers s INNER JOIN Products p ON s.SupplierID = p.SupplierID
WHERE ProductName LIKE '%chai%'


-- 2) Welche Kunden haben Chai Tee gekauft und wieviel? (OrderID, CompanyName, ProductName, Quantity)

SELECT	  o.OrderID
		, CompanyName
		, ProductName
		, Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE ProductName LIKE '%chai%'


-- 3) Gib alle Kunden aus den USA und deren Frachtkosten aus.
SELECT	  CompanyName
		, Freight
		, Country
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE Country = 'USA'
ORDER BY CompanyName, Freight

--4) Suche alle Bestellungen, bei denen Bier verkauft wurde. Welcher Kunde? Wieviel? Welches Bier? (Der 
--Produktname kann "Bier" oder "Lager" enthalten oder mit "Ale" enden.)  
--a. Optional: Nach Menge und Kundenname geordnet. 
--b. Optional: Menge absteigend (größte zuerst), Kundenname aufsteigend (A-Z) 


SELECT	  o.OrderID
		, ProductName
		, CompanyName
		, Quantity
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
				 INNER JOIN Products p ON od.ProductID = p.ProductID
WHERE ProductName LIKE '%bier%'
			OR ProductName LIKE '%lager%'
			OR ProductName LIKE '%ale'
ORDER BY Quantity DESC, CompanyName ASC