
create procedure "SalesbyYear" 
	@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Orders.ShippedDate, Orders.OrderID, "OrderSubtotals".Subtotal, DATENAME(yy,ShippedDate) AS Year
FROM Orders INNER JOIN "OrderSubtotals" ON Orders.OrderID = "OrderSubtotals".OrderID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date
