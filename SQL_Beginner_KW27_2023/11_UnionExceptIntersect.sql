--UNION f�hrt "vertikal" zwei oder mehrere Ergebnistabellen zusammen
--Spaltenanzahl muss dabei identisch sein, Datentypen m�ssen kompatibel sein

SELECT * FROM Customers
UNION --UNION hat DISTINCT dabei
SELECT * FROM Customers

SELECT * FROM Customers
UNION ALL --UNION ALL ohne DISTINCT
SELECT * FROM Customers

SELECT * FROM Customers
--ORDER BY City
UNION ALL 
SELECT * FROM Customers
UNION ALL 
SELECT * FROM Customers
ORDER BY 1 --ORDER BY nur nach der letzten Abfrage im UNION m�glich


--INTERSECT & EXCEPT: Vergleichen Ergebnismengen von 2 oder mehr Abfragen

SELECT 100
INTERSECT
SELECT 100

SELECT 100
EXCEPT
SELECT 100

--INTERSECT: Ergebnisse die in beiden Abfragen identisch auftauchen, kommen ins (Gesamt)Ergebnis
SELECT OrderID FROM Orders
INTERSECT
SELECT OrderID FROM Orders
WHERE YEAR(OrderDate) = 1997

--EXCEPT: Ergebnisse die in beiden Abfragen auftauchen, werden "gel�scht", nur Ergebnisse die noch in der "oberen" Abfrage �brig
--bleiben, kommen ins (Gesamt)Ergebnis
SELECT OrderID FROM Orders -- "Alles was hier rauskommt"
EXCEPT --"Au�er"
SELECT OrderID FROM Orders -- "dem was hier rauskommt"
WHERE YEAR(OrderDate) = 1997