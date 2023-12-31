--4. Top Produktkategorie (CategoryName) je Verkaufsland (noch nicht l�sbar, Tag 3?):


--21 Ergebniszeilen
--Country, CategoryName, UmsatzSumme

--Idee: WHILE Loop der f�r jedes Land einmal durchgeht, und Ergebnis in eine #Table schreibt
USE Northwind
GO

DROP TABLE IF EXISTS #L�nder
DROP TABLE IF EXISTS #IdL�nder
DROP TABLE IF EXISTS #Ergebnis
GO

SELECT DISTINCT Country INTO #L�nder FROM Customers WHERE Country IS NOT NULL
SELECT ROW_NUMBER() OVER(ORDER BY Country) as ID, Country INTO #IdL�nder FROM #L�nder
GO

DECLARE @Counter int = 1 
WHILE @Counter <= (SELECT COUNT(*) FROM #IdL�nder)
BEGIN
--SELECT OBJECT_ID('tempdb..#Ergebnis')
IF OBJECT_ID('tempdb..#Ergebnis') IS NULL
BEGIN

SELECT TOP 1 Country, CategoryName, SUM(PositionsSumme) as Summe 
INTO #Ergebnis
FROM v_BestellDetails
WHERE Country = (SELECT Country FROM #IdL�nder WHERE ID = @Counter)
GROUP BY Country, CategoryName
ORDER BY Summe DESC
END
ELSE
BEGIN
INSERT INTO #Ergebnis 
SELECT TOP 1 Country, CategoryName, SUM(PositionsSumme) as Summe 
FROM v_BestellDetails
WHERE Country = (SELECT Country FROM #IdL�nder WHERE ID = @Counter)
GROUP BY Country, CategoryName
ORDER BY Summe DESC
END
SET @Counter += 1
END

SELECT * FROM #Ergebnis