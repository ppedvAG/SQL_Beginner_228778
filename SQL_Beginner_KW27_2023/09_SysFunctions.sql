--Verwenden von Systemfunktionen

/***********************************************************/

--Arbeiten mit String-/Characterfunktionen:

/***********************************************************/

SELECT LEFT('Hallo', 3)
SELECT LEFT(CompanyName, 5), RIGHT(CompanyName, 5), CompanyName FROM Customers
--LEFT/RIGHT geben die "linken" bzw "rechten" X Symbole eines Strings aus

SELECT SUBSTRING(CompanyName, 5, 5) FROM Customers
--Teil eines Strings ab Position x

SELECT LEN(CompanyName) FROM Customers
--"Länge" eines Strings

SELECT STUFF(Phone, 1, 4, 'XXXX') FROM Customers
--Ersetzt Teil eines Strings ab Position x mit anderen Werten

--Letzten 5 Ziffern jeder Phonenumber mit 5 X ersetzen:
SELECT STUFF(Phone, LEN(Phone) - 4, 5, 'XXXXX') FROM Customers

SELECT REPLICATE('X', 5)
--Wiederholt eine Ausgabe x mal

--Ersten 4 Ziffern stehen lassen, Rest ersetzen, pro ersetzte Ziffer 1 X:
SELECT STUFF(Phone, 5, LEN(Phone) -4, REPLICATE('X', LEN(Phone) - 4)) FROM Customers

SELECT CONCAT(FirstName, ' ', LastName) as GanzerName FROM Employees
--CONCAT "verbindet" Strings in einer Ergebnisspalte/Zelle

SELECT FirstName + ' ' + LastName FROM Employees

SELECT SOUNDEX('Sonne')
SELECT DIFFERENCE('Sonne', 'Tonne')

/***********************************************************/

--Datumsfunktionen:

/***********************************************************/

SELECT GETDATE()
--Aktuelle Systemzeit

SELECT DATEADD(DAY, 14, GETDATE())
SELECT DATEADD(MONTH, -2, GETDATE())
--addiert/subtrahiert einen Zeitraum von einem Datum

SELECT DATEDIFF(DAY, '19930224' ,getdate())
--Unterschied in beliebigem Intervall zwischen 2 Daten

SELECT DAY(OrderDate), MONTH(OrderDate), YEAR(OrderDate), OrderDate FROM Orders

SELECT DATEPART(DAY, OrderDate), DATEPART(WEEK, OrderDate), DATEPART(QUARTER, OrderDate) FROM Orders
--zieht nur einen gewünschten Teil aus einem gegebenen Datum

SELECT DATENAME(WEEKDAY, OrderDate), DATENAME(MONTH, OrderDate) FROM Orders
--"Name" von Wochentagen oder Monaten


/***********************************************************/

--Funktionen zum ändern von Datentypen:

/***********************************************************/

SELECT CAST(OrderDate as date) FROM Orders
--CAST(Spalte as Neuerdatentyp)

SELECT CONVERT(date, OrderDate) FROM Orders
--selbe wie CAST

SELECT Fax, ISNULL(Fax, 'n/a') FROM Customers
--Ersetzt gefundene NULL Werte mit neuem Wert


--Übungen:

--1. Welches Produkt wurde in Q3 1997 am meisten verkauft? (Quantity)
--Zusatz: Ist es auch das Produkt das in diesem Zeitraum den meisten Umsatz gemacht hat?
SELECT TOP 1 ProductName, SUM(Quantity) as VerkaufsMenge
FROM v_BestellDetails
WHERE DATEPART(QUARTER, OrderDate) = 3 AND DATEPART(YEAR, OrderDate) = 1997
GROUP BY ProductName
ORDER BY VerkaufsMenge DESC

SELECT TOP 1 ProductName, SUM(PositionsSumme) as Umsatz
FROM v_BestellDetails
WHERE DATEPART(QUARTER, OrderDate) = 3 AND DATEPART(YEAR, OrderDate) = 1997
GROUP BY ProductName
ORDER BY Umsatz DESC

--2. Alle Bestellungen mit Lieferverzögerung ausgeben (OrderID + Tage Verzögerung)
--Lieferverzögerung = RequiredDate & ShippedDate in Orders Tabelle

SELECT
OrderID,
DATEDIFF(DAY, ISNULL(ShippedDate, GETDATE()), RequiredDate) as Lieferverzögerung
--ShippedDate,
--RequiredDate
FROM Orders
WHERE DATEDIFF(DAY, ISNULL(ShippedDate, GETDATE()), RequiredDate) < 0 --Alternativ WHERE ShippedDate > RequiredDate
ORDER BY Lieferverzögerung

SELECT * FROM Orders
WHERE ShippedDate IS NULL

--3. Welcher Spediteur war 1997 im Schnitt am günstigsten (Freight)? (Spediteur = Shippers)

--Falsch, da die View BestellPOSITIONEN abbildet, und nicht die Bestellungen:
SELECT
Spediteur,
AVG(Freight) as AvgFreight
FROM v_BestellDetails
WHERE DATEPART(YEAR, OrderDate) = 1997
GROUP BY Spediteur

--Richtig:
SELECT 
CompanyName,
AVG(Freight) as AvgFreight
FROM Orders
JOIN Shippers ON ShipVia = ShipperID
WHERE DATEPART(YEAR, OrderDate) = 1997
GROUP BY CompanyName

