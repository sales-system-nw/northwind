
create view SalesbyCategoryView AS
SELECT Categories.CategoryID, Categories.CategoryName, Products.ProductName, 
	Sum("OrderDetailsExtended".ExtendedPrice) AS ProductSales
FROM 	Categories INNER JOIN 
		(Products INNER JOIN 
			(Orders INNER JOIN "OrderDetailsExtended" ON Orders.OrderID = "OrderDetailsExtended".OrderID) 
		ON Products.ProductID = "OrderDetailsExtended".ProductID) 
	ON Categories.CategoryID = Products.CategoryID
WHERE Orders.OrderDate BETWEEN '19970101' And '19971231'
GROUP BY Categories.CategoryID, Categories.CategoryName, Products.ProductName
--ORDER BY Products.ProductName
