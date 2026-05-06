CREATE PROCEDURE [dbo].[DW_MergeFactOrders]
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE fs
    SET 
        fs.[OrderDateKey]    = stg.[OrderDateKey],
        fs.[RequiredDateKey] = stg.[RequiredDateKey],
        fs.[ShippedDateKey]  = stg.[ShippedDateKey],
        fs.[CustomerSK]      = stg.[CustomerSK],
        fs.[ProductSK]       = stg.[ProductSK],
        fs.[EmployeeSK]      = stg.[EmployeeSK],
        fs.[ShipperSK]       = stg.[ShipperSK],
        fs.[Quantity]        = stg.[Quantity],
        fs.[UnitPrice]       = stg.[UnitPrice],
        fs.[Discount]        = stg.[Discount],
        fs.[OrderDate]       = stg.[OrderDate],
        fs.[RequiredDate]    = stg.[RequiredDate],
        fs.[ShippedDate]     = stg.[ShippedDate]

    FROM [dbo].[FactOrders] fs
    INNER JOIN [staging].[Orders] stg 
        ON fs.[OrderID] = stg.[OrderID] 
        AND fs.[ProductID] = stg.[ProductID];
END;