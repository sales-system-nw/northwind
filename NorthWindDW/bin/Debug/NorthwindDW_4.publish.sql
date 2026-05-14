/*
Script de implementación para NorthwindDW

Este código lo generó una herramienta.
Los cambios en este archivo pueden provocar un comportamiento incorrecto y se perderán si
el código se vuelve a generar.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "NorthwindDW"
:setvar DefaultFilePrefix "NorthwindDW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detecte el modo SQLCMD y deshabilite la ejecución de scripts si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
ESTABLECER NOEXEC DESACTIVADO; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
/*
Se está quitando la columna [dbo].[DimEmployee].[Photo]; puede que se pierdan datos.

Se está quitando la columna [dbo].[DimEmployee].[RegionDescription]; puede que se pierdan datos.

Se está quitando la columna [dbo].[DimEmployee].[TerritoryDescription]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [dbo].[DimEmployee])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
/*
Se está quitando la columna [staging].[Employee].[Photo]; puede que se pierdan datos.

Se está quitando la columna [staging].[Employee].[RegionDescription]; puede que se pierdan datos.

Se está quitando la columna [staging].[Employee].[TerritoryDescription]; puede que se pierdan datos.
*/

IF EXISTS (select top 1 1 from [staging].[Employee])
    RAISERROR (N'Se detectaron filas. La actualización del esquema va a terminar debido a una posible pérdida de datos.', 16, 127) WITH NOWAIT

GO
PRINT N'Modificando Tabla [dbo].[DimEmployee]...';


GO
ALTER TABLE [dbo].[DimEmployee] DROP COLUMN [Photo], COLUMN [RegionDescription], COLUMN [TerritoryDescription];


GO
PRINT N'Modificando Tabla [staging].[Employee]...';


GO
ALTER TABLE [staging].[Employee] DROP COLUMN [Photo], COLUMN [RegionDescription], COLUMN [TerritoryDescription];


GO
PRINT N'Modificando Procedimiento [dbo].[DW_MergeDimEmployee]...';


GO
ALTER PROCEDURE [dbo].[DW_MergeDimEmployee]
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
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Customers')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Customers', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Products')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Products', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Employees')
 BEGIN
  INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Employees', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Shippers')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Shippers', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Orders')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Orders', 0)
 END
GO

GO
PRINT N'Actualización completada.';


GO
