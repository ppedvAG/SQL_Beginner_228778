--Unterabfragen/Subqueries/nested Queries

--Abfragen können Unterabfragen ausführen; Es wird immer vom "innersten" zum "äußersten" gearbeitet

--So nicht lösbar:
SELECT 
*
FROM Orders
WHERE Freight > AVG(Freight) 

--Lösung über Subquery; "wir berechnen den AVG(Freight) bereits vorher":

SELECT 
*
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) 
--Subquery wird zuerst ausgeführt, das Ergebnis wird in die äußere Abfrage "eingesetzt"

--Regel: Subquerys müssen immer eigenständig ausführbar sein


--Funktionieren an jeder Stelle in einer Abfrage, ob SELECT/FROM/WHERE oder sonst wo

--Im FROM braucht eine Subquery immer ein Alias; Namenlose Tabellen können nicht aufgerufen werden!
SELECT * FROM
(
SELECT * FROM Customers
WHERE Country IN ('Spain', 'France', 'Germany')
) as t --Alias
WHERE CustomerID = 'PARIS'
