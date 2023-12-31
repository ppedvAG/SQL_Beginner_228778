--Stammdaten generieren/ver�ndern usw.


--"Kopie" erstellen �ber SELECT INTO

SELECT * INTO BackupCustomers FROM Customers

SELECT * FROM BackupCustomers


--Neue Datens�tze einf�gen in bestehende Tabelle mit INSERT INTO

INSERT INTO Customers (CustomerID, CompanyName, Country)
VALUES ('PPEDV', 'ppedv AG', 'Germany')

INSERT INTO Customers
VALUES ('PPEDV', 'Germany')

SELECT * FROM Customers
WHERE CustomerID = 'ppedv'

INSERT INTO Customers (CustomerID, CompanyName)
VALUES
('EDEKA', 'Edeka'),
('LIDL ', 'Lidl')
--Wenn mehr als 1 Value Paar in einem Insert, dann alles in dem selben Batch!

--alternativ INSERT INTO Tabelle SELECT usw...:
INSERT INTO BackupCustomers
SELECT * FROM Customers
WHERE CustomerID = 'ppedv'

INSERT INTO BackupCustomers
SELECT Country, CustomerID FROM Customers
WHERE CustomerID = 'ppedv'



SELECT * FROM Customers
WHERE CustomerID = 'ppedv'

--Vorhandene Datens�tze �ndern mit UPDATE

UPDATE Customers
SET City = 'Burghausen'
WHERE CustomerID = 'ppedv' --Vorsicht! WHERE Filter nicht vergessen, sonst ALLE Zeilen betroffen
--Am besten nach Primarschl�sselspalte filtern, da einzigartig

--Tipp: Erst normales SELECT schreiben, und WHERE FIlter pr�fen --> wenn richtig, dann ab�ndern in UPDATE

SELECT * FROM 
UPDATE Customers
SET Address = 'Marktler Str. 15b'
WHERE CustomerID = 'ppedv'

--"L�schen" von Werten in einem Datensatz mit UPDATE SET = NULL
UPDATE Customers 
SET Address = NULL
WHERE CustomerID = 'ppedv'

--UPDATE mit CASE m�glich:
UPDATE Customers
SET ContactName = 
	CASE 
	WHEN Country = 'Germany' THEN 'Peter'
	WHEN Country = 'France' THEN 'Jaques'
	WHEN Country = 'Spain' THEN 'Miguel'
	ELSE ContactName
END


--L�schen von Datens�tzen mit DELETE:

DELETE FROM Customers
WHERE CustomerID = 'ppedv'

--Genau wie bei UPDATE, WHERE Filter nicht vergessen! Sonst alle Datens�tze weg

--Wenn PK-FK Beziehungen "ins Leere laufen w�rden", kann ein Datensatz nicht so einfach gel�scht werden:
DELETE FROM Customers
WHERE CustomerID = 'ALFKI'

DELETE FROM Orders
WHERE CustomerID = 'ALFKI'


--L�schen von Datenbankobjekten mit DROP
DROP TABLE Customers
DROP VIEW v_BestellDetails
DROP DATABASE Northwind


--Neue Datenbankobjekten erstellen mit CREATE

CREATE TABLE Fuhrpark
(
AutoID int NOT NULL, --NULL Einstellungen: Wenn NOT NULL, muss es angegeben werden; Ansonsten darf die Spalte NULL Werte haben
Modell varchar(50),
EmployeeID int
)

SELECT * FROM Fuhrpark

INSERT INTO Fuhrpark
VALUES (1, 'Audi A4', 1)

--�ndern von Datenbankobjekten mit ALTER

ALTER TABLE Fuhrpark
ADD PS int --Erstellt neue Spalte

--Prim�rschl�ssel nachtr�glich anlegen:
ALTER TABLE Fuhrpark
ADD PRIMARY KEY (AutoID)

ALTER TABLE Fuhrpark
ADD CONSTRAINT PK_AutoID PRIMARY KEY (AutoID)

--Fremdschl�ssel nachtr�glich anlegen:
ALTER TABLE Fuhrpark
ADD FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)

ALTER TABLE Fuhrpark
ADD CONSTRAINT FK_Employees_Fuhrpark_EmployeeID FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID)


--Alternative Table Erstellung:
CREATE TABLE Fuhrpark2
(
AutoID int identity(1, 1) PRIMARY KEY,
Modell varchar(50),
EmployeeID int FOREIGN KEY REFERENCES Employees (EmployeeID)
)

--CHECK Constraint/Einschr�nkung erstellen:

ALTER TABLE Fuhrpark
ADD CONSTRAINT CK_EmployeeID CHECK (EmployeeID > 0)

INSERT INTO Fuhrpark (AutoID, EmployeeID)
VALUES (2, -1)

ALTER TABLE Fuhrpark2
ADD PS int

INSERT INTO Fuhrpark2 (PS)
VALUES (-100)

SELECT * FROM Fuhrpark2