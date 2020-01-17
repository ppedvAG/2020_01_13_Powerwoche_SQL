-- temporary tables
-- temporäre Tabellen

-- hält nur so lange, wie Verbindung besteht

-- lokale temporäre Tabellen
-- existiert nur in aktueller Session
-- #tabellenname

-- globale temporäre Tabellen
-- Zugriff auch von anderen Sessions
-- ##tabellenname

USE Northwind

SELECT CustomerID, Freight
INTO #t1
FROM Orders


SELECT *
FROM #t1
