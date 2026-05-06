CREATE TABLE [dbo].[DimProduct] (
    [ProductSK]       INT           IDENTITY (1, 1) NOT NULL,
    [ProductID]       INT           NOT NULL,
    [ProductName]     NVARCHAR (40) NOT NULL,
    [CategoryName]    NVARCHAR (15) NOT NULL,
    [CompanyName]     NVARCHAR (40) NOT NULL,
    [QuantityPerUnit] NVARCHAR (20) NULL,
    [UnitPrice]       MONEY         NOT NULL,
    [UnitsInStock]    SMALLINT      NOT NULL,
    [UnitsOnOrder]    SMALLINT      NOT NULL,
    [ReorderLevel]    SMALLINT      NOT NULL,
    [Discontinued]    BIT           NOT NULL,
    CONSTRAINT [PK_DimProduct] PRIMARY KEY CLUSTERED ([ProductSK] ASC)
);

