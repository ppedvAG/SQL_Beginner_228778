--Wir k�nnen Variablen definieren und �berall im Skript verwenden

DECLARE @VariablenName int = 1, @Var2 int, @Var3 int --DECLARE muss immer mit ausgef�hrt werden!

--SELECT @VariablenName

--�ndern von Variablen Werten im laufenden Skript mit SET
SET @Var2 = 1

--SELECT @Var2

SET @Var3 = (SELECT EmployeeID FROM Employees WHERE LastName = 'King')
SELECT @Var3
SET @Var3 = @Var3 + 1 
SET @Var3 += 1
SELECT @Var3

