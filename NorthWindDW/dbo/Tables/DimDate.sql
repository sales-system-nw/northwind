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

