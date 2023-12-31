--Stored Procedure/gespeicherte Prozedur/User defined Procedure

--Werden auf der Datenbank gespeichert (Programmierbarkeit); k�nnen von allen Usern (mit Rechten) ausgef�hrt werden
--SPs sind quasi abgespeicherte SQL Anweisungen die mit Parametern (Variablen) arbeiten


CREATE PROCEDURE sp_KundenNachLand @Land varchar(50)
AS
SELECT * FROM Customers
WHERE Country = @Land


--Ausf�hren einer Procedure durch EXEC ProzedurName (Var1, Var2, varN ...)
EXEC sp_KundenNachLand Spain

GO

ALTER PROCEDURE sp_KundenNachLand @Land varchar(50), @Stadt varchar(50)
AS
SELECT * FROM Customers
WHERE Country = @Land AND City = @Stadt

EXEC sp_KundenNachLand Germany, Berlin

--Default Werte vergeben:

ALTER PROCEDURE sp_KundenNachLand @Land varchar(50), @Stadt varchar(50) = 'Berlin'
AS
SELECT * FROM Customers
WHERE Country = @Land AND City = @Stadt

EXEC sp_KundenNachLand Germany, M�nchen


--Prozeduren verwenden immer den selben Abfrageplan --> bessere Performance