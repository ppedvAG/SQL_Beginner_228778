USE [Northwind]
GO

/****** Object:  View [dbo].[v_BestellDetails]    Script Date: 05.07.2023 16:15:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[v_BestellDetails] AS

SELECT 
Customers.CompanyName, Customers.CustomerID, Customers.City, Customers.Country, Customers.Address,
Orders.OrderID, Orders.OrderDate, Orders.Freight, 
Products.ProductName, 
Employees.LastName, 
Products.CategoryID,
Shippers.CompanyName as Spediteur,
Categories.CategoryName,
[Order Details].UnitPrice, [Order Details].Quantity, [Order Details].Discount,
CAST([Order Details].UnitPrice * Quantity * (1 - Discount) as decimal(10,2)) as PositionsSumme
FROM  Customers INNER JOIN
         Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
         [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
         Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
         Products ON [Order Details].ProductID = Products.ProductID INNER JOIN
		 Shippers ON ShipVia = ShipperID INNER JOIN
		 Categories ON Categories.CategoryID = Products.CategoryID

GO


