--WHILE Statement leitet Schleifen/Loops ein


WHILE 1=1 --WHILE Bedingung wird vor jedem Durchlauf gepr�ft; Wird solange wiederholt bis Bedingung FALSE ist
BEGIN --leitet Loop Statement ein

SELECT 'Stuck in a Loop'

END --schlie�t Loop Statement


DECLARE @Counter int = 0

WHILE @Counter < 5
BEGIN
SELECT @Counter
SET @Counter += 1
END



--4. Top Produktkategorie (CategoryName) je Verkaufsland (noch nicht l�sbar, Tag 3?):


--21 Ergebniszeilen
--Country, CategoryName, UmsatzSumme

--Idee: WHILE Loop der f�r jedes Land einmal durchgeht, und Ergebnis in eine #Table schreibt

SELECT DISTINCT Country INTO #L�nder FROM Customers 
SELECT ROW_NUMBER() OVER(ORDER BY Country) as ID, Country INTO #IdL�nder FROM #L�nder
SELECT * FROM #IdL�nder



SELECT COUNT(*) FROM Categories