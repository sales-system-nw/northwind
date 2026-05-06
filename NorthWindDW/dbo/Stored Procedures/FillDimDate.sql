
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