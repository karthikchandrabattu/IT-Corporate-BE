CREATE   PROCEDURE [dbo].[usp_GetUnmatchedTables]
AS
BEGIN
WITH TableList AS
(
SELECT DISTINCT si.TABLE_NAME FROM [WH_DE_MetaData].[Config].[SQLServerSourceInformationSchema] ssi
RIGHT JOIN [DE_LH_Silver].[meta].[SourceInformationSchema] si
ON ssi.TABLE_SCHEMA = si.TABLE_SCHEMA AND ssi.TABLE_NAME = si.TABLE_NAME AND
ssi.COLUMN_NAME = si.COLUMN_NAME AND ssi.DATA_TYPE = si.DATA_TYPE
WHERE ssi.DATA_TYPE IS NULL OR ssi.COLUMN_NAME IS NULL
)
SELECT STRING_AGG(ConfigId, ',') AS ConfigList,  STRING_AGG(SourceTableName, ',') AS TableList FROM [WH_DE_MetaData].[Config].[OneTimeConfigETL]
WHERE SourceTableName IN (SELECT TABLE_NAME FROM TableList)

END