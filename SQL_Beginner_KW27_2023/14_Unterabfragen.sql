--Unterabfragen/Subqueries/nested Queries

--Abfragen k�nnen Unterabfragen ausf�hren; Es wird immer vom "innersten" zum "�u�ersten" gearbeitet

--So nicht l�sbar:
SELECT 
*
FROM Orders
WHERE Freight > AVG(Freight) 

--L�sung �ber Subquery; "wir berechnen den AVG(Freight) bereits vorher":

SELECT 
*
FROM Orders
WHERE Freight > (SELECT AVG(Freight) FROM Orders) 
--Subquery wird zuerst ausgef�hrt, das Ergebnis wird in die �u�ere Abfrage "eingesetzt"

--Regel: Subquerys m�ssen immer eigenst�ndig ausf�hrbar sein


--Funktionieren an jeder Stelle in einer Abfrage, ob SELECT/FROM/WHERE oder sonst wo

--Im FROM braucht eine Subquery immer ein Alias; Namenlose Tabellen k�nnen nicht aufgerufen werden!
SELECT * FROM
(
SELECT * FROM Customers
WHERE Country IN ('Spain', 'France', 'Germany')
) as t --Alias
WHERE CustomerID = 'PARIS'
