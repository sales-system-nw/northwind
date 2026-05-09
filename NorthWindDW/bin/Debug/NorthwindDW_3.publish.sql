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
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_Customer]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_Customer];


GO
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_Employee]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_Employee];


GO
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_OrderDate]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_OrderDate];


GO
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_Product]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_Product];


GO
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_RequiredDate]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_RequiredDate];


GO
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_ShippedDate]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_ShippedDate];


GO
PRINT N'Quitando Clave externa [dbo].[FK_FactOrders_Shipper]...';


GO
ALTER TABLE [dbo].[FactOrders] DROP CONSTRAINT [FK_FactOrders_Shipper];


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Customer]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_Customer] FOREIGN KEY ([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Employee]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_Employee] FOREIGN KEY ([EmployeeSK]) REFERENCES [dbo].[DimEmployee] ([EmployeeSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_OrderDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_OrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Product]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_Product] FOREIGN KEY ([ProductSK]) REFERENCES [dbo].[DimProduct] ([ProductSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_RequiredDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_RequiredDate] FOREIGN KEY ([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_ShippedDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_ShippedDate] FOREIGN KEY ([ShippedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Shipper]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_Shipper] FOREIGN KEY ([ShipperSK]) REFERENCES [dbo].[DimShipper] ([ShipperSK]);


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
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_Customer];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_Employee];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_OrderDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_Product];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_RequiredDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_ShippedDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_Shipper];


GO
PRINT N'Actualización completada.';


GO
