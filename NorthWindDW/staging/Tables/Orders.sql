CREATE TABLE [staging].[Orders] (
    [OrderID]         INT             NOT NULL,
    [ProductID]       INT             NOT NULL,
    [OrderDateKey]    INT             NULL,
    [RequiredDateKey] INT             NULL,
    [ShippedDateKey]  INT             NULL,
    [CustomerSK]      INT             NULL,
    [ProductSK]       INT             NULL,
    [EmployeeSK]      INT             NULL,
    [ShipperSK]       INT             NULL,
    [Quantity]        INT             NULL,
    [UnitPrice]       MONEY           NULL,
    [Discount]        DECIMAL (10, 2) NULL,
    [OrderDate]       DATE            NULL,
    [RequiredDate]    DATE            NULL,
    [ShippedDate]     DATE            NULL
);

