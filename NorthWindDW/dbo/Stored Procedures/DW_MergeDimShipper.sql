CREATE PROCEDURE [dbo].[DW_MergeDimShipper]
AS
BEGIN
    SET NOCOUNT ON;
    UPDATE ds
    SET ds.[CompanyName] = ss.[CompanyName],
        ds.[Phone] = ss.[Phone]
    FROM [dbo].[DimShipper] ds
    INNER JOIN [staging].[Shipper] ss ON (ds.[ShipperSK] = ss.[ShipperSK]);
    
END;