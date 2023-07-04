--WHERE filtert unsere Ergebnismenge nach gewissen Kriterien
--WHERE steht IMMER nach dem FROM

SELECT * FROM Customers
WHERE Country = 'France'

SELECT * FROM Customers
WHERE Country = ' France'

SELECT * FROM Customers
WHERE Country = 'FrANce'

-- Bei WHERE Spaltenname = 'Wert': nur EXAKTE Treffer

--WHERE funktioniert mit =, >, <, >=, <=, != (ungleich)

SELECT * FROM Orders
WHERE Freight > 100

SELECT * FROM Orders
WHERE Freight < 100

SELECT * FROM Customers
WHERE Country != 'France'


--Soviele Filter miteinander verknüpfen wie wir wollen mit AND oder OR

SELECT * FROM Customers
WHERE Country = 'Germany' OR Country = 'Spain'

SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin'

--AND ist "stärker bindend" bzw. AND = "Punkt" und OR = "Strich" wie Mathematik
SELECT * FROM Customers
WHERE Country = 'Germany' AND City = 'Berlin' OR City = 'Paris'

SELECT * FROM Customers
WHERE (Country = 'Germany' AND City = 'Berlin') OR City = 'Paris'

SELECT * FROM Customers
WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'Paris')
--Klammern setzen möglich, bzw. auch teilweise nötig!


--Wenn sich ein Wert zwischen zwei Werten befinden soll:
SELECT * FROM Orders
WHERE Freight > 100 AND Freight < 500

--Alternativ mit BETWEEN:
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500 --BETWEEN mit Randwerten eingeschlossen!


--Wenn viele ORs sich auf die selbe Spalte beziehen, IN verwenden:
SELECT * FROM Customers
WHERE Country IN ('Germany', 'France', 'Spain', 'Brazil')


--Aufgaben:

--1. Alle Contactnames die als Title "Owner" haben (Tabelle Customers)
SELECT ContactName FROM Customers
WHERE ContactTitle = 'Owner'

--2. Alle Order Details die ProductID 43 bestellt haben
SELECT * FROM [Order Details]
WHERE ProductID = 43

--3. Alle Kunden aus Paris, Berlin, Madrid und Brazilien
SELECT * FROM Customers
WHERE City IN ('Paris', 'Berlin', 'Madrid') OR Country = 'Brazil'

--4. Alle Produkte der Category "Beverages"
SELECT * FROM Products
WHERE CategoryID = 1

SELECT * FROM Categories

--"Bonus/Problem": Alle Ansprechpartner deren Titel "Manager" beinhaltet
--Tabelle Customers ContactName/Title
SELECT ContactName FROM Customers
WHERE ContactTitle IN ('Accounting Manager', 'Sales Manager') --umständlich; besser: siehe LIKE


--"Bonus/Problem2": Alle Kunden die eine Fax Nummer haben

--Filtern nach NULL Werten:
SELECT * FROM Customers
WHERE Fax IS NOT NULL

SELECT * FROM Customers
WHERE Fax IS NULL
