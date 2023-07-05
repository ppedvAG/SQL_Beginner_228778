--4. Top Produktkategorie (CategoryName) je Verkaufsland (noch nicht lösbar, Tag 3?):


--21 Ergebniszeilen
--Country, CategoryName, UmsatzSumme

--Idee: WHILE Loop der für jedes Land einmal durchgeht, und Ergebnis in eine #Table schreibt
USE Northwind
GO

DROP TABLE IF EXISTS #Länder
DROP TABLE IF EXISTS #IdLänder
DROP TABLE IF EXISTS #Ergebnis
GO

SELECT DISTINCT Country INTO #Länder FROM Customers WHERE Country IS NOT NULL
SELECT ROW_NUMBER() OVER(ORDER BY Country) as ID, Country INTO #IdLänder FROM #Länder
GO

DECLARE @Counter int = 1 
WHILE @Counter <= (SELECT COUNT(*) FROM #IdLänder)
BEGIN
--SELECT OBJECT_ID('tempdb..#Ergebnis')
IF OBJECT_ID('tempdb..#Ergebnis') IS NULL
BEGIN

SELECT TOP 1 Country, CategoryName, SUM(PositionsSumme) as Summe 
INTO #Ergebnis
FROM v_BestellDetails
WHERE Country = (SELECT Country FROM #IdLänder WHERE ID = @Counter)
GROUP BY Country, CategoryName
ORDER BY Summe DESC
END
ELSE
BEGIN
INSERT INTO #Ergebnis 
SELECT TOP 1 Country, CategoryName, SUM(PositionsSumme) as Summe 
FROM v_BestellDetails
WHERE Country = (SELECT Country FROM #IdLänder WHERE ID = @Counter)
GROUP BY Country, CategoryName
ORDER BY Summe DESC
END
SET @Counter += 1
END

SELECT * FROM #Ergebnis