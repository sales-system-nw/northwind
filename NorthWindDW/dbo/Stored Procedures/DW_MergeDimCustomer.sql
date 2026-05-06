CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN
    -- Actualiza los datos descriptivos en el DW desde el Staging
    UPDATE dc
    SET dc.[CompanyName] = sc.[CompanyName],
        dc.[ContactName] = sc.[ContactName],
        dc.[ContactTitle] = sc.[ContactTitle],
        dc.[Address] = sc.[Address],
        dc.[City] = sc.[City],
        dc.[Region] = sc.[Region],
        dc.[PostalCode] = sc.[PostalCode],
        dc.[Country] = sc.[Country],
        dc.[Phone] = sc.[Phone],
        dc.[Fax] = sc.[Fax],
        dc.[CustomerDesc] = sc.[CustomerDesc]
    FROM [dbo].[DimCustomer] dc
    INNER JOIN [staging].[Customer] sc ON (dc.[CustomerSK] = sc.[CustomerSK]);
END;