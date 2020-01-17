-- VIEWS
-- Sichten

USE Northwind

-- Syntax:
-- CREATE VIEW vName
-- AS
-- SELECT


-- Bsp.:

CREATE VIEW vTest01
AS
SELECT CustomerID, CompanyName
FROM Customers
WHERE Country = 'Germany'


SELECT CustomerID, CompanyName
FROM vTest01


CREATE VIEW vCustomerContacts
AS
SELECT	  CustomerID
		, ContactName
		, ContactTitle
		, Phone
FROM Customers

SELECT *
FROM vCustomerContacts

SELECT *
FROM vCustomerContacts
WHERE CustomerID LIKE '[a-f]%'


-- Übung


CREATE VIEW vKundenbestellungen
AS
SELECT	  o.OrderID
		, c.CompanyName
		, ProductName
		, Quantity
		, od.UnitPrice*od.Quantity AS Rechnungsposten
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
				 INNER JOIN [Order Details] od ON od.OrderID = o.OrderID
				 INNER JOIN Products p ON p.ProductID = od.ProductID


SELECT *
FROM vKundenbestellungen


