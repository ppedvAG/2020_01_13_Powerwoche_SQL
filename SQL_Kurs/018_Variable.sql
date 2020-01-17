-- Variablen
USE Northwind

-- lokale Variablen
-- @var1
-- Lebenszeit: solange der Batch l‰uft
-- Zugriff in der Session, in der sie erstellt wurde


-- globale Variablen
-- @@var1
-- Lebenszeit: solange der Batch l‰uft
-- Zugriff auch von auﬂerhalb der Session


-- Syntax:
-- DECLARE @varname AS Datentyp


-- Bsp:
DECLARE @var1 AS int


-- Wert zuweisen
SET @var1 = 100


SELECT @var1

-- Bsp.:

DECLARE @myDate datetime2 = SYSDATETIME()
SELECT FORMAT(@myDate, 'dd.MM.yyyy')


-- Vorsicht:
DECLARE @myDate2 datetime2 = '2020-01-16' -- Vorsicht Datentyp, Vorsicht System: was ist Tag, was ist Monat?
SELECT FORMAT(@myDate2, 'dd.MM.yyyy')


-- Bsp.:

DECLARE @fracht AS money = 10

SELECT *
FROM Orders
WHERE Freight < @fracht