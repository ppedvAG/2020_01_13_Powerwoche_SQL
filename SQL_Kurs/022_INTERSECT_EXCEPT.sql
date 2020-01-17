-- SET Operatoren
-- UNION, UNION ALL
-- INTERSECT
-- EXCEPT


CREATE TABLE #a (id int)
CREATE TABLE #b (id int)


INSERT INTO #a (id)
VALUES (1), (NULL), (2)

INSERT INTO #b 
VALUES (1), (NULL), (3), (1)

-- gibt mir zurück, was in beiden Tabellen vorkommt
SELECT id FROM #a
INTERSECT
SELECT id FROM #b
-- NULL, 1

-- Reihenfolge egal:
SELECT id FROM #b
INTERSECT
SELECT id FROM #a

-- nur das, was in a, aber nicht in b drin ist:
SELECT id FROM #a
EXCEPT
SELECT id FROM #b
-- 2

SELECT id FROM #b
EXCEPT
SELECT id FROM #a
-- 3


SELECT #a.id
FROM #a INNER JOIN #b ON #a.id = #b.id


SELECT #a.id
FROM #a LEFT JOIN #b ON #a.id = #b.id

-- Northwind Bsp.:

SELECT CustomerID
INTO #testNW01
FROM Customers

SELECT CustomerID
INTO #testNW02
FROM Orders

-- alle Customers, die schon etwas bestellt haben:
SELECT CustomerID FROM #testNW01
INTERSECT
SELECT CustomerID FROM #testNW02

-- Unterschied zum INNER JOIN: INTERSECT gibt keine doppelten Werte aus, wir bekommen nur 89 (Anzahl der Kunden), nicht 830 (Anzahl der Bestellungen wie beim INNER JOIN mit doppelten Werten der Kunden, die mehrere Bestellungen aufgegeben haben)

-- die, die nix bestellt haben:
SELECT CustomerID FROM #testNW01
EXCEPT
SELECT CustomerID FROM #testNW02


-- Achtung Reihenfolge: hier kein Ergebnis; Kunden, die in der Orders-Tabelle stehen, stehen auch in der Customer-Tabelle
SELECT CustomerID FROM #testNW02
EXCEPT
SELECT CustomerID FROM #testNW01



-- INNER JOIN veranschaulichen
-- DROP TABLE #c
-- DROP TABLE #d
CREATE TABLE #c (id int, test varchar)
CREATE TABLE #d (id int, test varchar) 

INSERT INTO #c VALUES  (1, 'a'), (NULL, NULL), (2, 'x'), (1, 'b')
INSERT INTO #d VALUES (1, 'c'), (NULL, NULL), (3, 'x'), (1, 'd'), (1, 'e')

SELECT * FROM #c
SELECT * FROM #d


SELECT c.id, c.test
FROM #c c INNER JOIN #d d ON c.id = d.id


SELECT c.id, d.test
FROM #c c INNER JOIN #d d ON c.id = d.id



SELECT c.id, c.test, d.id, d.test
FROM #c c INNER JOIN #d d ON c.id = d.id



SELECT * FROM #c
INTERSECT
SELECT * FROM #d