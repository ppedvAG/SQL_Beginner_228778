--Views bzw. Sichten erstellen:

CREATE VIEW v_BestellDetails AS

SELECT 
Customers.CompanyName, Customers.CustomerID, Customers.City, Customers.Country, 
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Products.ProductName, 
Employees.LastName, 
[Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount,
[Order Details].UnitPrice * Quantity * (1 - Discount) as PositionsSumme
FROM  Customers INNER JOIN
         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
         Products ON [Order Details].ProductID = Products.ProductID


SELECT * FROM v_BestellDetails

--Hinter jeder View steckt eine Abfrage, die jedesmal ausgef�hrt wird, wenn die View aufgerufen wird!

SELECT DISTINCT Country FROM v_BestellDetails
--Besser:
SELECT DISTINCT Country FROM Customers

--Views n�tzlich f�r Rechteverteilung: Es k�nnen andere Rechte vergeben werden als auf den urspr�nglichen Tabellen

--Code hinter einer View anzeigen mit "Rechtsklick - Skript as - Create IN"

--Bestehende View �ndern mit ALTER VIEW:

ALTER VIEW v_BestellDetails AS

SELECT 
Customers.CompanyName, Customers.CustomerID, Customers.City, Customers.Country, Customers.Address,
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Products.ProductName, 
Employees.LastName, 
[Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount,
[Order Details].UnitPrice * Quantity * (1 - Discount) as PositionsSumme
FROM  Customers INNER JOIN
         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
         Products ON [Order Details].ProductID = Products.ProductID

SELECT * FROM v_BestellDetails

--L�schen mit DROP VIEW

DROP VIEW v_BestellDetails
