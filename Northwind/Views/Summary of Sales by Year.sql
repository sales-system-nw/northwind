
create view "SummaryofSalesbyYear" AS
SELECT Orders.ShippedDate, Orders.OrderID, "OrderSubtotals".Subtotal
FROM Orders INNER JOIN "OrderSubtotals" ON Orders.OrderID = "OrderSubtotals".OrderID
WHERE Orders.ShippedDate IS NOT NULL
--ORDER BY Orders.ShippedDate
