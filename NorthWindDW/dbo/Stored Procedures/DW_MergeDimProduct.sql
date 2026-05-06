CREATE PROCEDURE [dbo].[DW_MergeDimProduct]
AS
BEGIN
    UPDATE dp
    SET 
        dp.[ProductName] = sp.[ProductName],
        dp.[CategoryName] = sp.[CategoryName],
        dp.[CompanyName] = sp.[CompanyName],
        dp.[QuantityPerUnit] = sp.[QuantityPerUnit],
        dp.[UnitPrice] = sp.[UnitPrice],
        dp.[UnitsInStock] = sp.[UnitsInStock],
        dp.[UnitsOnOrder] = sp.[UnitsOnOrder],
        dp.[ReorderLevel] = sp.[ReorderLevel],
        dp.[Discontinued] = sp.[Discontinued]
    FROM [dbo].[DimProduct] dp
    INNER JOIN [staging].[Product] sp ON (dp.[ProductSK] = sp.[ProductSK]);
END;