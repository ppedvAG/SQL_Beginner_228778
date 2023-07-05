--Aufgaben:

--1. Meistverkaufte Produkt in Spain + wieviel davon (ProductName + Quantity)

SELECT TOP 1
ProductName,
SUM(Quantity) as Summe
FROM v_BestellDetails
WHERE Country = 'Spain'
GROUP BY ProductName
ORDER BY Summe DESC

--2. Wieviel Umsatz hat jeder Mitarbeiter in seinem Heimatland gemacht? (Heimatland = Country aus Employees)

select e.LastName, 
SUM(UnitPrice*Quantity*(1-Discount)) as Summe, 
e.Country, 
o.ShipCountry 
from [Order Details] od
join Orders o on o.OrderID = od.OrderID
join Employees e on e.EmployeeID = o.EmployeeID AND e.Country = o.ShipCountry
--where e.Country = o.ShipCountry
group by e.LastName, e.Country, o.ShipCountry


--3. Haben U40 Mitarbeiter mehr oder weniger Umsatz gemacht, als Ü40 Mitarbeiter? (Alter = BirthDate & OrderDate)

SELECT
CASE
	WHEN DATEDIFF(YEAR, BirthDate, OrderDate) >= 40 THEN 'Ü40'
	ELSE 'U40'
END as Altersgruppe,
CAST(SUM(UnitPrice*Quantity*(1-Discount)) as decimal(10,2)) as Umsatz
FROM Employees
JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID
JOIN [Order Details] ON [Order Details].OrderID = Orders.OrderID
GROUP BY 
CASE
	WHEN DATEDIFF(YEAR, BirthDate, OrderDate) >= 40 THEN 'Ü40'
	ELSE 'U40'
END 

--alternativ:

select CAST(sum(od.UnitPrice*od.Quantity*(1-od.Discount)) as decimal(10,2)), 'U40' from [Order Details] od
join Orders o on o.OrderID = od.OrderID
join Employees e on e.EmployeeID = o.EmployeeID
where DATEDIFF(YEAR, BirthDate, OrderDate) > 40
UNION ALL
select CAST(sum(od.UnitPrice*od.Quantity*(1-od.Discount)) as decimal(10,2)), 'Ü40' from [Order Details] od
join Orders o on o.OrderID = od.OrderID
join Employees e on e.EmployeeID = o.EmployeeID
where DATEDIFF(YEAR, BirthDate, OrderDate) >= 40

--4. Wie haben sich die durchschnittlichen Lieferkosten von Spediteur "Federal Shipping" über die 3 Geschäftsjahre
--	 entwickelt? (Lieferkosten = Freight)

SELECT
DATEPART(YEAR, OrderDate) as Geschäftsjahr,
CompanyName,
AVG(Freight) as DurchFreight
FROM Orders
JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
--WHERE CompanyName = 'Federal Shipping'
GROUP BY DATEPART(YEAR, OrderDate), CompanyName
ORDER BY DurchFreight