--1. Größte Lieferkosten (Freight) bei Bestellungen aus Brasilien (Brazil)

SELECT TOP 1 Freight FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Country = 'Brazil'
ORDER BY Freight DESC

--"Für Faule":
SELECT TOP 1 * FROM v_BestellDetails
WHERE Country = 'brazil'
ORDER BY Freight DESC

--STRG+SHIFT+R "refresht" den Objekt Explorer falls Datenbankobjekte nicht im IntelliSense auftauchen

--2. In welchen Produktkategorien (CategoryName) gibt es Produkte, die nicht mehr geführt werden (Discontinued)?

SELECT DISTINCT CategoryName, Discontinued FROM Products
JOIN Categories ON Products.CategoryID = Categories.CategoryID
WHERE Discontinued = 1

--3. Stellvertreterliste: Welche Employees könnten einander vertreten (wohnen in der selben Stadt)?
--(SELF JOIN)

Select arbeiter.LastName, arbeiter.City, vertreter.LastName, vertreter.City from Employees arbeiter
join Employees vertreter on arbeiter.City = vertreter.City
where vertreter.EmployeeID != arbeiter.EmployeeID
ORDER BY 2

SELECT * FROM Employees

--Besser:
Select arbeiter.LastName, arbeiter.City, vertreter.LastName, vertreter.City from Employees arbeiter
join Employees vertreter on arbeiter.City = vertreter.City
where vertreter.EmployeeID != arbeiter.EmployeeID
UNION
Select arbeiter.LastName, arbeiter.City, vertreter.LastName, vertreter.City from Employees arbeiter
LEFT join Employees vertreter on arbeiter.City = vertreter.City AND vertreter.EmployeeID != arbeiter.EmployeeID 