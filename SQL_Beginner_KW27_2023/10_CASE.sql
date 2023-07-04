--CASE Statement = "Fallunterscheidung"; 
--Prüft Bedingungen und gibt je nach dem einen anderen Wert in der Case Spalte aus

SELECT  
*,
CASE
	WHEN Discontinued = 0 THEN 'Wird verkauft.'
	WHEN Discontinued = 1 THEN 'Abgesetzt.'
END as CaseStatement
FROM Products

--Optional mit ELSE: Output wenn keine der WHEN Bedingungen erfüllt wurde:
SELECT  
*,
CASE
	WHEN Discontinued = 0 THEN 'Wird verkauft.'
	ELSE 'Abgesetzt.'
END as CaseStatement
FROM Products

--Falls kein Else, und keine WHEN Bedingung erfüllt wurde, wird NULL ausgegeben:
SELECT  
*,
CASE
	WHEN Discontinued = 0 THEN 'Wird verkauft.'
END as CaseStatement
FROM Products


/* Übung:
ABC Analyse der Produkte über gesamten Zeitraum der Firmengeschichte nach Umsatz
Kat.A > 50000
Kat.B Zwischen 10000 & 50000
Kat.C < 10000

Ergebnistabelle in etwa so:
ProductName Umsatz Kategorie
1			60000  A
2			 5000  C
3
4
*/

SELECT 
ProductName,
CAST(SUM([Order Details].UnitPrice * Quantity * (1 - Discount)) as decimal(10,2)) as UmsatzSumme,
CASE
	WHEN SUM([Order Details].UnitPrice * Quantity * (1 - Discount)) > 50000 THEN 'A'
	WHEN SUM([Order Details].UnitPrice * Quantity * (1 - Discount)) > 10000 THEN 'B'
	ELSE 'C'
END as Kategorie
FROM Products
JOIN [Order Details] ON Products.ProductID = [Order Details].ProductID
GROUP BY ProductName
Order BY Kategorie, UmsatzSumme DESC

