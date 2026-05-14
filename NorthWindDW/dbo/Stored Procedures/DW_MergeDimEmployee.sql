CREATE PROCEDURE [dbo].[DW_MergeDimEmployee]
AS
BEGIN
    UPDATE de
    SET 
        de.[LastName] = se.[LastName],
        de.[FirstName] = se.[FirstName],
        de.[Title] = se.[Title],
        de.[TitleOfCourtesy] = se.[TitleOfCourtesy],
        de.[BirthDate] = se.[BirthDate],
        de.[HireDate] = se.[HireDate],
        de.[Address] = se.[Address],
        de.[City] = se.[City],
        de.[Region] = se.[Region],
        de.[PostalCode] = se.[PostalCode],
        de.[Country] = se.[Country],
        de.[HomePhone] = se.[HomePhone],
        de.[Extension] = se.[Extension],
        de.[Notes] = se.[Notes],
        de.[ReportsTo] = se.[ReportsTo],
        de.[PhotoPath] = se.[PhotoPath]
    FROM [dbo].[DimEmployee] de
    INNER JOIN [staging].[Employee] se ON (de.[EmployeeSK] = se.[EmployeeSK]);
END;