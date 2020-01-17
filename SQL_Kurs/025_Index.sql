

CREATE NONCLUSTERED INDEX IX_Customers_Country_City ON Customers (Country, City)

DROP INDEX Customers.IX_Customers_Country_City

EXEC sp_helpindex Customers
