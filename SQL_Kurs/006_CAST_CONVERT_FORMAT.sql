-- CAST, CONVERT, FORMAT


-- ********************* CAST: Umwandeln von Datentypen *********************

-- funktioniert (ist aber nicht sehr schlau)
SELECT '123' + 2

-- funktioniert NICHT:
SELECT '123.3' + 2
-- Conversion failed when converting the varchar value '123.3' to data type int.

/*
		https://docs.microsoft.com/de-de/sql/t-sql/data-types/data-type-conversion-database-engine?view=sql-server-ver15

*/

-- muss explizit umgewandelt werden, dann gehts wieder
SELECT CAST('123.3' AS float) + 2


-- geht auch mit Datum, aber kein Einfluss aufs Format:
SELECT CAST(SYSDATETIME() AS varchar)

-- VORSICHT: wieviele Zeichen??
SELECT CAST(SYSDATETIME() AS varchar(3))

-- funktioniert, ist aber keine schöne Lösung:
SELECT CAST(SYSDATETIME() AS varchar(10))

-- auch mit DB möglich; aber kein Einfluss auf Datentyp
SELECT	  BirthDate
		, CAST(BirthDate AS varchar)
FROM Employees

-- VORSICHT: ob das funktioniert, ist systemabhängig
SELECT CAST('2020-01-14' AS date)



-- ****************************** CONVERT *********************************

-- Syntax: CONVERT(data_type[(length)], expression[, style])

-- möglich, aber SINN??
SELECT CONVERT(varchar(10), 12345.5)

-- möglich... Sinn? -> man kann dann damit rechnen
SELECT CONVERT(float, '123.3')

-- funktioniert auch mit Datum, Vorsicht mit Länge
SELECT CONVERT(varchar(10), SYSDATETIME())
SELECT CONVERT(varchar(3), SYSDATETIME()) -- Länge -> Blödsinn

SELECT CONVERT(varchar, SYSDATETIME(), 104)

/*
		https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017#date-and-time-styles

*/

SELECT	  CONVERT(varchar, SYSDATETIME(), 104) AS DE
		, CONVERT(varchar, SYSDATETIME(), 101) AS US
		, CONVERT(varchar, SYSDATETIME(), 103) AS GB


-- ************************************ FORMAT ********************************
-- nvarchar
-- Syntax: FORMAT(expression, format[, culture-parameter])


SELECT FORMAT(1234567890, '###-###/##-##') -- 123-456/78-90

SELECT FORMAT(431234567890, '+' + '##/### ## ## ###') -- +43/123 45 67 890

-- sehr flexibel beim Datum

SELECT FORMAT(SYSDATETIME(), 'dd.MM.yyyy') -- ACHTUNG!! MM Groß schreiben, sonst Minute!!

SELECT FORMAT(SYSDATETIME(), 'dd.M.yyyy') -- einstellig/zweistellig theoretisch auch vermischbar (Sinn??)

-- geht nicht! Fehlermeldung!
SELECT FORMAT('2020-01-14', 'dd.MM.yyyy')


-- das geht: (da kommt ein verwertbarer Datentyp aus der DB)
SELECT FORMAT(HireDate, 'dd.MM.yyyy')
FROM Employees

-- klein d: Datum in Zahlen: 14.01.2020
SELECT FORMAT(SYSDATETIME(), 'd', 'de-de')

-- groß D: Datum wird ausgeschrieben: Dienstag, 14. Januar 2020
SELECT	  FORMAT(SYSDATETIME(), 'D', 'de-de') AS DE
		, FORMAT(SYSDATETIME(), 'D', 'en-US') AS US
		, FORMAT(SYSDATETIME(), 'D', 'en-GB') AS GB


-- Supported Culture Codes in der Microsoft-Dokumentation:
/*

	https://docs.microsoft.com/de-de/bingmaps/rest-services/common-parameters-and-types/supported-culture-codes


*/

SELECT	  FORMAT(SYSDATETIME(), 'D', 'de-at') AS AT
USE Northwind
SELECT Freight, CAST(Freight* 1.19 AS decimal(10, 2)) AS Brutto
FROM Orders
