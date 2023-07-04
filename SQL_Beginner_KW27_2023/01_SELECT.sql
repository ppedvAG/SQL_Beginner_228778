/* Führt einen Kommentarblock an
der über mehrere Zeilen
geht bis geschlossen */

--Ist ein einzeiliger Kommentar

SELECT 100 --numerische Ausgaben brauchen keine explizite Markierung

SELECT 'Hallo' --Strings ("Worte") immer in einzelnen Hochkommas

SELECT 100, 'Hallo' --mehrere Spalten mit Kommas trennen

SELECT (5+7)*3/5 --Alle Rechenoperationen funktionieren auch im SELECT (math. Regeln beachten!)

--Vorhandene Tabellen/Datensätze aufrufen:

SELECT * FROM Customers --Wir brauchen immer ein FROM Tabellenname, quasi eine Quelle "wo werden die Spalten gefunden"

USE Northwind --USE Datenbankname versetzt das Skript in die jeweilige Datenbank
SELECT * FROM Northwind.dbo.Customers --alternativ mit ausführlichem Schema Datenbankname.Schemaname.Tabellenname


SELECT Companyname, City, Country FROM Customers
SELECT City, Country, Companyname FROM Customers --Reihenfolge in der Syntax, bestimmt Reihenfolge in der Ausgabe


SelECt			City,
	   CoUnTry


FRoM cUSTOmErs --Formatierung und Groß-/Kleinschreibung spielt keine Rolle in SQL


SELECT * FROM Orders

/*
Systemtabelle INFORMATION_SCHEMA gibt Metadaten aus zu TABLES, COLUMNS usw...:

SELECT * FROM INFORMATION_SCHEMA.TABLES
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
*/

SELECT * FROM [Order Details] --eckige Klammern: Handelt sich um den Namen eines Datenbankobjekts



/**************************************************************************************/


--TOP X: gibt uns nur die obersten X Zeilen aus der Tabelle aus

SELECT TOP 1 * FROM Customers

SELECT TOP 10 * FROM Customers

SELECT TOP 10 * FROM Customers
ORDER BY Country --TOP X immer nach der Sortierung die vorliegt, bzw. die wir angegeben haben

--"BOTTOM X" existiert nicht, Tabelle "umdrehen" mit ORDER BY:
SELECT TOP 10 * FROM Customers
ORDER BY CustomerID DESC

SELECT TOP 10 * FROM Orders
ORDER BY Freight DESC

--TOP X PERCENT 
SELECT TOP 10 PERCENT * FROM Orders

--ORDER BY: Sortiert unsere Ergebnismenge nach unseren Angaben
--steht IMMER am Ende des Statements (syntaktisch)

SELECT * FROM Customers
ORDER BY Country --standardmäßig immer aufsteigend/ascending/ASC

SELECT * FROM Customers
ORDER BY Country DESC --absteigend mit Zusatz DESC (descending)

SELECT Country, City FROM Customers
ORDER BY Country, City DESC --mehrere Spalten möglich; DESC bezieht sich immer nur auf die vorherige Spalte


--DISTINCT: filtert identische Datensätze im Ergebnis:

SELECT DISTINCT Country FROM Customers

SELECT DISTINCT * FROM Customers

SELECT DISTINCT Country, CIty FROM Customers

--Distinct & Top im selben Select:
SELECT DISTINCT TOP 10 Country FROM Customers



--Alias vergeben mit "Spaltenname as NeuerName":

SELECT City as Stadt FROM Customers

SELECT 100 as Zahl

SELECT City as Stadt, Country as Land FROM Customers

--Funktioniert auch für Tabellennamen:
SELECT * FROM Customers as c
