CREATE PROCEDURE [dbo].[GetDateMaxMin]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
       minOrderDate = cast(min(OrderDate)as date) ,
       maxOrderDate = cast( (
       SELECT MAX(v) 
       FROM (VALUES (MAX(OrderDate)), (MAX(RequiredDate)), (MAX(ShippedDate))) AS t(v))as date)
    FROM [dbo].[Orders] s
 END;
