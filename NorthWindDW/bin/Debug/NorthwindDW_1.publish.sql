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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Esquema [staging]...';


GO
CREATE SCHEMA [staging]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Tabla [staging].[Shipper]...';


GO
CREATE TABLE [staging].[Shipper] (
    [ShipperSK]   INT           NULL,
    [CompanyName] NVARCHAR (40) NULL,
    [Phone]       NVARCHAR (24) NULL
);


GO
PRINT N'Creando Tabla [staging].[Product]...';


GO
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


GO
PRINT N'Creando Tabla [staging].[Orders]...';


GO
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


GO
PRINT N'Creando Tabla [staging].[Employee]...';


GO
CREATE TABLE [staging].[Employee] (
    [EmployeeSK]           INT            NOT NULL,
    [LastName]             NVARCHAR (20)  NULL,
    [FirstName]            NVARCHAR (10)  NULL,
    [Title]                NVARCHAR (30)  NULL,
    [TitleOfCourtesy]      NVARCHAR (25)  NULL,
    [BirthDate]            DATETIME       NULL,
    [HireDate]             DATETIME       NULL,
    [Address]              NVARCHAR (60)  NULL,
    [City]                 NVARCHAR (15)  NULL,
    [Region]               NVARCHAR (15)  NULL,
    [PostalCode]           NVARCHAR (10)  NULL,
    [Country]              NVARCHAR (15)  NULL,
    [HomePhone]            NVARCHAR (24)  NULL,
    [Extension]            NVARCHAR (4)   NULL,
    [Photo]                IMAGE          NULL,
    [Notes]                NVARCHAR (MAX) NULL,
    [ReportsTo]            INT            NULL,
    [PhotoPath]            NVARCHAR (255) NULL,
    [TerritoryDescription] NVARCHAR (50)  NULL,
    [RegionDescription]    NVARCHAR (50)  NULL
);


GO
PRINT N'Creando Tabla [staging].[Customer]...';


GO
CREATE TABLE [staging].[Customer] (
    [CustomerSK]   INT            NOT NULL,
    [CompanyName]  NVARCHAR (40)  NULL,
    [ContactName]  NVARCHAR (30)  NULL,
    [ContactTitle] NVARCHAR (30)  NULL,
    [Address]      NVARCHAR (60)  NULL,
    [City]         NVARCHAR (15)  NULL,
    [Region]       NVARCHAR (15)  NULL,
    [PostalCode]   NVARCHAR (10)  NULL,
    [Country]      NVARCHAR (15)  NULL,
    [Phone]        NVARCHAR (24)  NULL,
    [Fax]          NVARCHAR (24)  NULL,
    [CustomerDesc] NVARCHAR (MAX) NULL
);


GO
PRINT N'Creando Tabla [dbo].[DimCustomer]...';


GO
CREATE TABLE [dbo].[DimCustomer] (
    [CustomerSK]   INT            IDENTITY (1, 1) NOT NULL,
    [CustomerID]   NCHAR (5)      NOT NULL,
    [CompanyName]  NVARCHAR (40)  NOT NULL,
    [ContactName]  NVARCHAR (30)  NULL,
    [ContactTitle] NVARCHAR (30)  NULL,
    [Address]      NVARCHAR (60)  NULL,
    [City]         NVARCHAR (15)  NULL,
    [Region]       NVARCHAR (15)  NULL,
    [PostalCode]   NVARCHAR (10)  NULL,
    [Country]      NVARCHAR (15)  NULL,
    [Phone]        NVARCHAR (24)  NULL,
    [Fax]          NVARCHAR (24)  NULL,
    [CustomerDesc] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_DimCustomer] PRIMARY KEY CLUSTERED ([CustomerSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimDate]...';


GO
CREATE TABLE [dbo].[DimDate] (
    [DateKey]   INT           NOT NULL,
    [FullDate]  DATE          NOT NULL,
    [Year]      INT           NOT NULL,
    [Quarter]   INT           NOT NULL,
    [Month]     INT           NOT NULL,
    [MonthName] NVARCHAR (15) NOT NULL,
    [Day]       INT           NOT NULL,
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimEmployee]...';


GO
CREATE TABLE [dbo].[DimEmployee] (
    [EmployeeSK]           INT            IDENTITY (1, 1) NOT NULL,
    [EmployeeID]           INT            NOT NULL,
    [LastName]             NVARCHAR (20)  NOT NULL,
    [FirstName]            NVARCHAR (10)  NOT NULL,
    [Title]                NVARCHAR (30)  NULL,
    [TitleOfCourtesy]      NVARCHAR (25)  NULL,
    [BirthDate]            DATETIME       NULL,
    [HireDate]             DATETIME       NULL,
    [Address]              NVARCHAR (60)  NULL,
    [City]                 NVARCHAR (15)  NULL,
    [Region]               NVARCHAR (15)  NULL,
    [PostalCode]           NVARCHAR (10)  NULL,
    [Country]              NVARCHAR (15)  NULL,
    [HomePhone]            NVARCHAR (24)  NULL,
    [Extension]            NVARCHAR (4)   NULL,
    [Photo]                IMAGE          NULL,
    [Notes]                NVARCHAR (MAX) NULL,
    [ReportsTo]            INT            NULL,
    [PhotoPath]            NVARCHAR (255) NULL,
    [TerritoryDescription] NVARCHAR (50)  NULL,
    [RegionDescription]    NVARCHAR (50)  NULL,
    CONSTRAINT [PK_DimEmployee] PRIMARY KEY CLUSTERED ([EmployeeSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimProduct]...';


GO
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


GO
PRINT N'Creando Tabla [dbo].[DimShipper]...';


GO
CREATE TABLE [dbo].[DimShipper] (
    [ShipperSK]   INT           IDENTITY (1, 1) NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    PRIMARY KEY CLUSTERED ([ShipperSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactOrders]...';


GO
CREATE TABLE [dbo].[FactOrders] (
    [OrderID]         INT             NOT NULL,
    [ProductID]       INT             NOT NULL,
    [OrderDateKey]    INT             NOT NULL,
    [RequiredDateKey] INT             NOT NULL,
    [ShippedDateKey]  INT             NOT NULL,
    [CustomerSK]      INT             NULL,
    [ProductSK]       INT             NULL,
    [EmployeeSK]      INT             NULL,
    [ShipperSK]       INT             NULL,
    [Quantity]        INT             NOT NULL,
    [UnitPrice]       MONEY           NOT NULL,
    [Discount]        DECIMAL (10, 2) NOT NULL,
    [OrderDate]       DATE            NOT NULL,
    [RequiredDate]    DATE            NOT NULL,
    [ShippedDate]     DATE            NULL,
    CONSTRAINT [PK_FactOrders] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ProductID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([PackageID] ASC)
);


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[PackageConfig]...';


GO
ALTER TABLE [dbo].[PackageConfig]
    ADD DEFAULT 0 FOR [LastRowVersion];


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Customer]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_Customer] FOREIGN KEY ([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Employee]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_Employee] FOREIGN KEY ([EmployeeSK]) REFERENCES [dbo].[DimEmployee] ([EmployeeSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_OrderDate]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_OrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Product]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_Product] FOREIGN KEY ([ProductSK]) REFERENCES [dbo].[DimProduct] ([ProductSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_RequiredDate]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_RequiredDate] FOREIGN KEY ([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_ShippedDate]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_ShippedDate] FOREIGN KEY ([ShippedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_Shipper]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_Shipper] FOREIGN KEY ([ShipperSK]) REFERENCES [dbo].[DimShipper] ([ShipperSK]);


GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimCustomer]...';


GO
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
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimEmployee]...';


GO
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
        de.[Photo] = se.[Photo],
        de.[Notes] = se.[Notes],
        de.[ReportsTo] = se.[ReportsTo],
        de.[PhotoPath] = se.[PhotoPath],
        de.[TerritoryDescription] = se.[TerritoryDescription],
        de.[RegionDescription] = se.[RegionDescription]
    FROM [dbo].[DimEmployee] de
    INNER JOIN [staging].[Employee] se ON (de.[EmployeeSK] = se.[EmployeeSK]);
END;
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimProduct]...';


GO
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
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimShipper]...';


GO
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
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeFactOrders]...';


GO
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
GO
PRINT N'Creando Procedimiento [dbo].[FillDimDate]...';


GO

CREATE PROCEDURE [dbo].[FillDimDate]
(
    @StartDate DATE = '1996-01-01',
    @EndDate   DATE = '2030-12-31'
)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (SELECT 1 FROM dbo.DimDate WHERE DateKey = 0)
    BEGIN
        INSERT INTO dbo.DimDate (DateKey, FullDate, [Year], [Quarter], [Month], [MonthName], [Day])
        VALUES (0, '1900-01-01', 1900, 0, 0, 'Desconocido', 0);
    END

    WHILE @StartDate <= @EndDate
    BEGIN
        INSERT INTO dbo.DimDate (
            DateKey, 
            FullDate, 
            [Year], 
            [Quarter], 
            [Month], 
            [MonthName], 
            [Day]
        )
        SELECT 
            CONVERT(INT, CONVERT(VARCHAR(8), @StartDate, 112)) AS DateKey,
            @StartDate AS FullDate,
            DATEPART(YEAR, @StartDate) AS [Year],
            DATEPART(QUARTER, @StartDate) AS [Quarter],
            DATEPART(MONTH, @StartDate) AS [Month],
            DATENAME(MONTH, @StartDate) AS [MonthName],
            DATEPART(DAY, @StartDate) AS [Day]
        WHERE NOT EXISTS (
            SELECT 1 FROM dbo.DimDate 
            WHERE DateKey = CONVERT(INT, CONVERT(VARCHAR(8), @StartDate, 112))
        );

        SET @StartDate = DATEADD(DAY, 1, @StartDate);
    END

END;
GO
PRINT N'Creando Procedimiento [dbo].[GetLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
(
    @tableName VARCHAR(50)
)
AS
BEGIN
    SELECT LastRowVersion
    FROM [dbo].[PackageConfig]
    WHERE TableName = @tableName;
END;
GO
PRINT N'Creando Procedimiento [dbo].[UpdateLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
(
    @tableName VARCHAR(50),
    @lastRowVersion BIGINT
)
AS
BEGIN
    UPDATE [dbo].[PackageConfig]
    SET LastRowVersion = @lastRowVersion
    WHERE TableName = @tableName;
END;
GO
EXEC sp_MSforeachtable 'ALTER TABLE ? NOCHECK CONSTRAINT ALL';
GO

INSERT INTO dbo.PackageConfig
(PackageID, TableName, LastRowVersion)
VALUES(1, N'Customers', 56011);
GO

INSERT INTO dbo.PackageConfig
(PackageID, TableName, LastRowVersion)
VALUES(2, N'Products', 56014);
GO

INSERT INTO dbo.PackageConfig
(PackageID, TableName, LastRowVersion)
VALUES(3, N'Employees', 56011);
GO

INSERT INTO dbo.PackageConfig
(PackageID, TableName, LastRowVersion)
VALUES(4, N'Orders', 78000);
GO

INSERT INTO dbo.PackageConfig
(PackageID, TableName, LastRowVersion)
VALUES(5, N'Shippers', 56021);
GO

EXEC sp_MSforeachtable 'ALTER TABLE ? CHECK CONSTRAINT ALL';
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
