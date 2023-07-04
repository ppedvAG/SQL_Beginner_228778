--Joins verbinden zwei oder mehrere Tabellen "logisch" miteinander

--Syntax:

SELECT OrderID, Orders.CustomerID, CompanyName FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID

/*

SELECT *
FROM Tabelle1 JOIN Tabelle2 ON Tabelle1.KeySpalte = Tabelle2.KeySpalte

*/

--INNER JOIN:

SELECT Products.* FROM Products
INNER JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE CategoryName = 'Beverages'

SELECT OrderID, LastName, FirstName FROM Employees as e
INNER JOIN Orders as o ON e.EmployeeID = o.EmployeeID

--Übungen: (Datenbankdiagramm verwenden wenn nicht sicher wie Tabellen zusammenhängen)

--Welches Produkt (Produktnamen) hatte die Bestellung mit der größten Bestellmenge (Quantity)?
--Die Bestellposition mit der größten Bestellmenge (Quantity) gehört zu welchem Produkt?

--Semmelknödel/chateuse

SELECT TOP 1 WITH TIES ProductName, Quantity FROM Products
INNER JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
ORDER BY Quantity DESC


--Welche Employees (Lastname) haben Bestellungen aus Deutschland bearbeitet?
SELECT DISTINCT LastName FROM Orders
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID
INNER JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
WHERE Customers.Country = 'Germany'



--OUTER Joins:

--LEFT/RIGHT

SELECT *
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT *
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID

SELECT *
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL

--FULL OUTER JOIN

SELECT *
FROM Customers FULL OUTER JOIN Orders ON Customers.CustomerID = Orders.CustomerID


--CROSS JOIN: AxB
SELECT * FROM Customers CROSS JOIN Orders


/*
Wenn mehrere Tabellen gejoint werden:

Tabelle A JOIN Tabelle B
--> Tabelle AB
Tabelle AB JOIN Tabelle C
--> Tabelle ABC
Tabelle ABC JOIN Tabelle D
usw...
*/

--SELF JOIN: 
SELECT EmployeeID, LastName, FirstName, ReportsTo FROM Employees

SELECT 
Mitarbeiter.EmployeeID, Mitarbeiter.LastName,
Vorgesetzte.EmployeeID, Vorgesetzte.LastName
FROM Employees as Mitarbeiter
INNER JOIN Employees as Vorgesetzte ON Mitarbeiter.EmployeeID = Vorgesetzte.ReportsTo

--Aufgaben:

--1. Welche Produkte (Productname) hat "Leverling" (Employees) bisher verkauft? 74

SELECT DISTINCT ProductName, LastName FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
JOIN Orders ON Orders.OrderID = [Order Details].OrderID
JOIN Employees ON Employees.EmployeeID = Orders.EmployeeID
WHERE LastName = 'Leverling'

--2. Welche Bestellungen (OrderIDs) wurden mit Spediteur "Speedy Express" versandt? 249
--Orders.ShipVia --> Shippers.ShipperID

SELECT OrderID FROM Orders
JOIN Shippers ON ShipVia = ShipperID
WHERE CompanyName = 'Speedy Express'


--3. "Rechnungen vorbereiten":
--Ausgabe: CompanyName, CustomerID, Country, City, OrderID, OrderDate, Freight, ProductName, UnitPrice, Quantity, Discount

SELECT *, UnitPrice * Quantity * (1 - Discount) as PositionsSumme
FROM [Order Details]

--Mit Abfrage-Editor: 
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