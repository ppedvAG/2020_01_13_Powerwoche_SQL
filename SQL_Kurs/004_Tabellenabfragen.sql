-- einfache Tabellenabfragen
-- SELECT auf Tabellen

--SELECT *
--FROM Tabellenname


USE Northwind

SELECT * -- * = Wildcard - alle Spalten dieser Tabelle
FROM Customers

SELECT	  CustomerID
		, ContactName
		, ContactTitle
		, Phone
FROM Customers


SELECT	  CustomerID AS Kundennummer
		, ContactName AS Kontaktperson
		, ContactTitle AS Position
		, Phone AS Telefonnummer
FROM Customers


-- von Bestellungen Bestellnummer, welcher Kunde (CustomerID), welcher Angestellte (EmployeeID) hat verkauft, in welches Land ist geliefert worden?

SELECT	  OrderID AS Bestellnummer
		, CustomerID AS Kundennummer
		, EmployeeID AS Angestellter
		, ShipCountry AS Land
FROM Orders

-- Übung
-- Von der Telefonnummer aus der Customers-Tabelle sollen nur die letzten 3 Zeichen angezeigt werden; alle anderen sollen mit x ersetzt werden. (xxxxxxxxxxxxxxx789) 

-- Lösungsmöglichkeit:


SELECT	  STUFF(Phone, 1, (LEN(Phone)-3), REPLICATE('x', LEN(Phone)-3)) AS Xes
		, LEN(Phone) AS PhoneLenght
		, LEN(STUFF(Phone, 1, (LEN(Phone)-3), REPLICATE('x', LEN(Phone)-3))) AS XLength
		, Phone 
	
FROM Customers


-- andere Lösung

SELECT CONCAT(REPLICATE('x', LEN(Phone)-3), RIGHT(Phone, 3))
		, Phone
FROM Customers


-- andere Lösung


SELECT CONCAT(REPLICATE('x', LEN(Phone)-3), SUBSTRING(Phone, LEN(Phone)-2, 3))
		, Phone
FROM Customers



-- Übung 2
-- Gib die ProduktID, den Produktnamen und den Stückpreis aus.

SELECT	  ProductID AS ProduktID
		, ProductName AS Produktname
		, UnitPrice AS Stückpreis
FROM Products


-- Berechungen

SELECT	  ProductID
		, ProductName
		, UnitPrice
		, UnitPrice * 10 AS Berechnung
	--	, 100 *3 AS Berechnung -- nicht so sinnvoll
	--	, 'a' AS Test
FROM Products


-- Frachtkosten, Brutto-/Nettofrachtkosten? MwSt? (19%)

SELECT	  Freight AS Nettofrachtkosten
		, Freight*1.19 AS Bruttofrachtkosten
		, Freight*0.19 AS MwSt
FROM Orders


SELECT *
FROM Employees
ORDER BY LastName


SELECT *
FROM Employees
ORDER BY City, LastName

-- per Default in aufsteigender Reihenfolge (ascending)
SELECT *
FROM Employees
ORDER BY LastName ASC

-- in absteigender Reihenfolge (vom Größten zum Kleinsten oder Alphabet in umgekehrter Reihenfolge)

SELECT *
FROM Employees
ORDER BY LastName DESC -- (descending)


-- nach Unitprice geordnet
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products
ORDER BY UnitPrice


-- teuerste Produkte zuerst:
SELECT	  ProductID
		, ProductName
		, UnitPrice
FROM Products
ORDER BY UnitPrice DESC


-- SELECT Text, Zahlen, Berechnungen, Spalten
-- FROM Tabelle, wo es herkommt
-- ORDER BY in welcher Reihenfolge soll Ausgabe erfolgen ASC/DESC


-- WH zum Aufwärmen:
-- ProduktID, Produktname, Stückpreis (Annahme Netto), Stückpreis Brutto, dt. Spaltenüberschriften

SELECT	  ProductID AS ProduktID
		, ProductName AS Produktname
		, UnitPrice AS [Stückpreis Netto]
		, UnitPrice*1.19 AS Bruttopreis
FROM Products

SELECT OrderID, UnitPrice
FROM [Order Details]