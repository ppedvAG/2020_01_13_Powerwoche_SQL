-- Datumsfunktionen

-- *********************** Datum abfragen ******************************
-- 3-4 Millisekunden genau
SELECT GETDATE()

-- auf Nanosekunden genau
SELECT SYSDATETIME()


-- ************************ Datumsberechnungen ********************************
-- DATEADD

SELECT DATEADD(hh, 10, '2020-01-14')

SELECT DATEADD(hh, 10, '2020-01-14 09:23:00.000')

SELECT DATEADD(dd, 10, HireDate)
FROM Employees


SELECT DATEADD(hh, 10, SYSDATETIME())

-- auch negative Vorzeichen sind erlaubt: wie spät war es vor 10 Stunden?
SELECT DATEADD(hh, -10, SYSDATETIME()) -- 2020-01-13 23:32:03.5536787


-- **************************** Datumsdifferenz ********************************

SELECT DATEDIFF(dd, '2020-01-14', '2019-12-24') -- -21

SELECT DATEDIFF(dd, '2019-12-24', '2020-01-14') -- 21

SELECT DATEDIFF(dd, SYSDATETIME(), '2019-12-24')


-- **************** Datumsteile ausgeben *******************************

SELECT DATEPART(dd, '2020-01-14')

SELECT DATEPART(MM, '2020-01-14')

SELECT DATEPART(yyyy, SYSDATETIME())

/*

Intervalle:

year, yyyy, yy = Year
quarter, qq, q = Quarter (Quartal)
month, MM, M = Month
week, ww, wk = Week
day, dd, d = Day
hour, hh = hour
minute, mi, n = minute
second, ss, s = second
millisecond, ms = millisecond
nanosecond, ns

weekday, dw, w = Day of Week
dayofyear, dy, y = Day of Year

*/


-- ************************************** DATENAME *******************************

SELECT DATENAME(dd, '2020-01-14') -- 14

SELECT DATENAME(dw, '2020-01-14') -- Tuesday

SELECT DATENAME(month, '2020-01-14') -- January


-- **************************** Übungen
--1) Welches Datum haben wir in 38 Tagen?

SELECT DATEADD(dd, 38, SYSDATETIME()) -- 2020-02-21 10:05:16.9707601


--2) Welcher Wochentag war Dein Geburtstag?

SELECT DATENAME(dw, '1981-04-22') -- Wednesday



--3) Vor wievielen Jahren kam der erste Star Wars Film in die Kinos? (25. Mai 1977 )

SELECT DATEDIFF(yy, '1977-05-25', GETDATE()) -- 43


--4) In welchem Quartal liegt der österreichische Nationalfeiertag (26.10.)?

SELECT DATEPART(q, '2020-10-26') -- 4


--5) Gib Tag, Monat und Jahr Deines Geburtstages in einer eigenen Spalte mit der jeweils entsprechenden Überschrift an:

SELECT	  DATEPART(dd, '1976-04-04') AS Tag
		, DATEPART(MM, '1976-04-04') AS Monat
		, DATEPART(yyyy, '1976-04-04') AS Jahr

-- oder: (exakt gleiches Ergebnis, nur andere Schreibweise)
SELECT	  DAY('1976-04-04') AS Tag
		, MONTH('1976-04-04') AS Monat
		, YEAR('1976-04-04') AS Jahr


-- mit DB:

SELECT	  YEAR(HireDate) AS Einstellungsjahr
		, HireDate
FROM Employees


-- Übungen
-- Gib die Datumsdifferenz zwischen Lieferdatum und Wunschtermin der Bestellungen aus.

SELECT DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
ORDER BY Lieferverzögerung DESC



SELECT	  DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
		, OrderID
		, CustomerID
FROM Orders
ORDER BY Lieferverzögerung DESC



-- Gib die Bestellnummer, den Wunschtermin, das Lieferdatum und die Lieferverzögerung aus.

SELECT	  OrderID
		, RequiredDate
		, ShippedDate
		, DATEDIFF(dd, RequiredDate, ShippedDate) AS Lieferverzögerung
FROM Orders
ORDER BY Lieferverzögerung DESC


-- Gib die Nettofrachtkosten, Bruttofrachtkosten und die Mehrwertsteuer aus (Berechnung).




