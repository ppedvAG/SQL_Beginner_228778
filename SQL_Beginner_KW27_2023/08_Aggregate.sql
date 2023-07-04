--Aggregatfunktionen: 5 Stück

SELECT MAX(Freight), MIN(Freight), COUNT(Freight), AVG(Freight), SUM(Freight) FROM Orders

--MAX = größter Wert, MIN = kleinster Wert, COUNT = Anzahl Ergebnisse, AVG = Durchschnitt(Mittelwert), SUM = Summe


SELECT COUNT(*), COUNT(ShipRegion) FROM Orders -- Count zählt keine NULL Werte

SELECT SUM(Freight) / COUNT(Freight), AVG(Freight) FROM Orders --AVG = SUM/COUNT


SELECT SUM(PositionsSumme) as GesamtUmsatz FROM v_BestellDetails


SELECT CompanyName, SUM(PositionsSumme) FROM v_BestellDetails --gibt Fehlermeldung, wir müssen GROUP BY verwenden!
SELECT * FROM v_BestellDetails

/***********************************************************/

--GROUP BY: syntaktisch nach dem WHERE 

SELECT CompanyName, SUM(PositionsSumme) as GesamtUmsatz FROM v_BestellDetails
GROUP BY CompanyName
ORDER BY GesamtUmsatz DESC

SELECT v_BestellDetails.Country as Land FROM v_BestellDetails 
WHERE v_BestellDetails.Country = 'Germany'
ORDER BY Land


--Gesamtumsatz jedes Kunden:
SELECT CompanyName, SUM(PositionsSumme) as GesamtUmsatz FROM v_BestellDetails
GROUP BY CompanyName
ORDER BY GesamtUmsatz DESC

--Gesamtumsatz für alle Kunden aus Germany:
SELECT Country, SUM(PositionsSumme) FROM v_BestellDetails
WHERE Country = 'Germany'
GROUP BY Country

--Größte Bestellposition jedes Kunden:
SELECT CompanyName, MAX(PositionsSumme) FROM v_BestellDetails
GROUP BY CompanyName

--Durchschnittlicher Wert der Bestellpositionen nach Städten:
SELECT City, AVG(PositionsSumme) FROM v_BestellDetails
GROUP BY City

--Anzahl Bestellpositionen nach Kunden:
SELECT CompanyName, COUNT(PositionsSumme) FROM v_BestellDetails
GROUP BY CompanyName

--"Rechnungen":
SELECT OrderID, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
GROUP BY OrderID

--"Rechnungen" mit CompanyName:
SELECT OrderID, CompanyName, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
GROUP BY OrderID, CompanyName

--"Rechnungen" mit CompanyName, Country, City: (Funktioniert, weil Country, City, CompanyName, bei jeder OrderID sowieso immer gleich)
SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
GROUP BY OrderID, CompanyName, Country, City

--Sinnfrei: (Weil ProductName zu jeder OrderID immer unterschiedlich ist)
SELECT OrderID, CompanyName, Country, City, ProductName, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
GROUP BY OrderID, CompanyName, Country, City, ProductName


/***********************************************************/

--HAVING: Filtert gruppierte Werte, bzw. Gruppen

SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
WHERE SUM(PositionsSumme) > 1000 --Aggregate funktionieren nicht im WHERE
GROUP BY OrderID, CompanyName, Country, City

--Stattdessen mit HAVING:

SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
GROUP BY OrderID, CompanyName, Country, City
HAVING SUM(PositionsSumme) > 1000 

--So nicht: (!)
SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
GROUP BY OrderID, CompanyName, Country, City
HAVING Country = 'Germany' --Wenn im WHERE möglich, dann auch im WHERE filtern! (siehe Prozessreihenfolge)

--besser:
SELECT OrderID, CompanyName, Country, City, SUM(PositionsSumme) as RechnungsBetrag FROM v_BestellDetails
WHERE Country = 'Germany' 
GROUP BY OrderID, CompanyName, Country, City


/***********************************************************/

--Übungen:

--1. Gesamtumsatz nach Mitarbeitern (LastName):
SELECT LastName, SUM(PositionsSumme) FROM v_BestellDetails
GROUP BY LastName

--ohne View:
SELECT
LastName,
SUM(Quantity * UnitPrice * (1 - Discount))
FROM Employees as e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY LastName

--2. Bestellmenge (Quantity) je Produkt (ProductName) - insgesamt:
SELECT ProductName, SUM(Quantity) FROM v_BestellDetails
GROUP BY ProductName

--3. Gesamtanzahl an Produkten die noch im Lager sind, aber nicht mehr verkauft werden (UnitsInStock, Discontinued):
SELECT SUM(UnitsInStock) FROM Products
WHERE Discontinued = 1 AND UnitsInStock != 0

SELECT ProductName, SUM(UnitsInStock) FROM Products
WHERE Discontinued = 1 AND UnitsInStock != 0
GROUP BY ProductName
--nope! HAVING SUM(UnitsInStock) != 0


--4. Top Produktkategorie (CategoryName) je Verkaufsland (noch nicht lösbar, Tag 3?):

SELECT TOP 1 CategoryName, Country, SUM(PositionsSumme) as Summe FROM v_BestellDetails B
JOIN Categories c ON B.CategoryID = c.CategoryID
WHERE Country = 'Argentina'
GROUP BY CategoryName, Country
--ORDER BY Summe DESC
UNION
SELECT TOP 1 CategoryName, Country, SUM(PositionsSumme) as Summe FROM v_BestellDetails B
JOIN Categories c ON B.CategoryID = c.CategoryID
WHERE Country = 'Austria'
GROUP BY CategoryName, Country
ORDER BY Summe DESC









SELECT TOP 1 CategoryName, Country, SUM(PositionsSUmme) FROM v_BestellDetails
WHERE Country
GROUP BY CategoryName, Country
ORDER BY 3
UNION
SELECT TOP 1 CategoryName, Country, SUM(PositionsSUmme) FROM v_BestellDetails
WHERE Country
GROUP BY CategoryName, Country
ORDER BY 3

