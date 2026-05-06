
create view "CategorySalesfor1997" AS
SELECT "ProductSalesfor1997".CategoryName, Sum("ProductSalesfor1997".ProductSales) AS CategorySales
FROM "ProductSalesfor1997"
GROUP BY "ProductSalesfor1997".CategoryName
