
create view "SalesTotalsbyAmount" AS
SELECT "OrderSubtotals".Subtotal AS SaleAmount, Orders.OrderID, Customers.CompanyName, Orders.ShippedDate
FROM 	Customers INNER JOIN 
		(Orders INNER JOIN "OrderSubtotals" ON Orders.OrderID = "OrderSubtotals".OrderID) 
	ON Customers.CustomerID = Orders.CustomerID
WHERE ("OrderSubtotals".Subtotal >2500) AND (Orders.ShippedDate BETWEEN '19970101' And '19971231')
