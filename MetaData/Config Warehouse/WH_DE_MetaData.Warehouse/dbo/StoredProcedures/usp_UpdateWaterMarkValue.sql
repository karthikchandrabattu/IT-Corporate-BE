CREATE   PROCEDURE usp_UpdateWaterMarkValue
@InLoadTimestamp VARCHAR(255),
@TableName VARCHAR(255)
AS
BEGIN

UPDATE [WH_DE_MetaData].[Config].[OneTimeConfigETL] SET WaterMarkValue = @InLoadTimestamp
WHERE SourceTableName = @TableName

END