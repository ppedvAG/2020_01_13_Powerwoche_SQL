-- Stored Procedure

-- Syntax
-- CREATE PROC pName
-- AS
-- SELECT...
-- SELECT..


-- Bsp.:

CREATE PROC Demo01
AS
SELECT Top 1 * FROM Orders ORDER BY Freight
SELECT TOP 3 Freight FROM Orders WHERE Freight < 30
SELECT Country FROM Customers

-- aufrufen mit EXEC (execute)

EXEC Demo01



-- mit Variablen

CREATE PROC pAllCustomers01 @City varchar(30)
AS
SELECT * FROM Customers WHERE City = @City


EXEC pAllCustomers01 @City = 'Berlin'


CREATE PROC pAllCustomers02 @City varchar(30), @Country varchar(30)
AS
SELECT * FROM Customers WHERE City = @City AND Country = @Country


EXEC pAllCustomers02 @City = 'Berlin', @Country = 'Germany'