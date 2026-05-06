CREATE TABLE [staging].[Product] (
    [ProductSK]       INT           NULL,
    [ProductName]     NVARCHAR (40) NULL,
    [CategoryName]    NVARCHAR (15) NULL,
    [CompanyName]     NVARCHAR (40) NULL,
    [QuantityPerUnit] NVARCHAR (20) NULL,
    [UnitPrice]       MONEY         NULL,
    [UnitsInStock]    SMALLINT      NULL,
    [UnitsOnOrder]    SMALLINT      NULL,
    [ReorderLevel]    SMALLINT      NULL,
    [Discontinued]    BIT           NULL
);

