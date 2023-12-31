--Tempor�re Tabellen/Temp Tables/#Tables

--Sind Tabellen die nur eine gewisse Zeit lang "existieren" (in der TempDB)
--Sind definiert �ber #-Zeichen = #NameDerTabelle (=lokale TempTable)

--SELECT ... INTO schreibt die Ergebnisse einer Abfrage in eine andere Tabelle
SELECT * INTO #TempTable FROM Customers

SELECT * FROM #TempTable
SELECT CompanyName, Country FROM #TempTable

--Sind nur innerhalb der aktuellen Session aufrufbar; Wenn Session geschlossen wird, wird die #Table gel�scht

SELECT 
Country,
SUM(PositionsSumme) as Summe
INTO #Summe FROM v_BestellDetails
GROUP BY Country

SELECT MAX(Summe), AVG(Summe) FROM #Summe

--N�tzlich f�r Aggregate von Aggregaten; Zum "Zwischenspeichern" von Ergebnissen f�r �berschaubarere Abfragen

--Globale TempTables mit ## (auch in anderen Sessions abrufbar)
SELECT * INTO ##GlobaleTemp FROM Orders

--manuelles l�schen von TempTables �ber DROP TABLE:
DROP TABLE ##GlobaleTemp


--Wenn in Skripten mit #Tables gearbeitet wird, empfiehlt sich diese zu l�schen am Anfang des Skripts
DROP TABLE IF EXISTS #t1
DROP TABLE IF EXISTS #t2
--Funkitioniert mit SQL Server 2019
SELECT @@VERSION --gibt Version aus

--(Pr� 2019 �ber Object_ID l�schen)

--#Tables sind u.U. nicht aktuell wenn sie schon "�lter" sind ("Screenshot" der Ergebnisse)
--Dadurch aber sehr performant, da Ergebnisse nur 1 Mal generiert werden, und nicht bei jedem Durchlauf erneut (siehe Loops)

--Einer vorhandenen #Table weitere Datens�tze hinzuf�gen �ber INSERT INTO:

INSERT INTO #TempTable
SELECT * FROM Customers

INSERT INTO #TempTable
SELECT * FROM Customers
GO 100 --GO = Batchanweisung; Mit GO x wird der "Batch" x mal durchgef�hrt

INSERT INTO #TempTable
SELECT * FROM #TempTable
GO 5

SELECT * FROM #TempTable