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
