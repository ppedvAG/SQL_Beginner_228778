--Ungenaue Suche/Filter mit LIKE statt =

SELECT ContactName FROM Customers
WHERE ContactTitle = 'Manager'

SELECT ContactName FROM Customers
WHERE ContactTitle LIKE 'Manager'

--Wildcards im LIKE verwenden:

SELECT ContactName, ContactTitle FROM Customers
WHERE ContactTitle LIKE '%Manager%'

--'%' = beliebige Anzahl an Zeichen, egal welche

SELECT * FROM Customers
WHERE CompanyName LIKE 'A%'

SELECT * FROM Customers
WHERE PostalCode LIKE '8%' AND Country = 'Germany'


--'_' = EIN Zeichen, egal welches

SELECT * FROM Customers
WHERE PostalCode LIKE '_0%'

SELECT * FROM Customers
WHERE PostalCode LIKE '__0%'

--'[xyz]' = alles in den Klammern ist an dieser Position gültig (x OR y OR z)

SELECT * FROM Customers
WHERE PostalCode LIKE '[0123]%'

--'[^xyz]' = alles in den Klammern ist an dieser Position NICHT gültig 

SELECT * FROM Customers
WHERE PostalCode LIKE '[^0123]%'

--'[0-5]' = alles in den Klammern ist an dieser Position gültig (von bis)

SELECT * FROM Customers
WHERE PostalCode LIKE '[0-5]%'

SELECT * FROM Customers
WHERE CompanyName LIKE '[a-m]%'


--Hochkomma in einem String suchen: doppelt angeben
SELECT * FROM Customers
WHERE CompanyName LIKE '%''%'