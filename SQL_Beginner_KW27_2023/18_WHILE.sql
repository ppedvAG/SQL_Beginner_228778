--WHILE Statement leitet Schleifen/Loops ein


WHILE 1=1 --WHILE Bedingung wird vor jedem Durchlauf geprüft; Wird solange wiederholt bis Bedingung FALSE ist
BEGIN --leitet Loop Statement ein

SELECT 'Stuck in a Loop'

END --schließt Loop Statement


DECLARE @Counter int = 0

WHILE @Counter < 5
BEGIN
SELECT @Counter
SET @Counter += 1
END



--4. Top Produktkategorie (CategoryName) je Verkaufsland (noch nicht lösbar, Tag 3?):


--21 Ergebniszeilen
--Country, CategoryName, UmsatzSumme

--Idee: WHILE Loop der für jedes Land einmal durchgeht, und Ergebnis in eine #Table schreibt

SELECT DISTINCT Country INTO #Länder FROM Customers 
SELECT ROW_NUMBER() OVER(ORDER BY Country) as ID, Country INTO #IdLänder FROM #Länder
SELECT * FROM #IdLänder



SELECT COUNT(*) FROM Categories