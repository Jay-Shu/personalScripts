/*

  Upstream:
  Perceptive DataTransfer

  This is demonstrate DB Maintenance on a simpler scale, normally it is recommended to use
  Ola Hallangren

  begin-procedure get-reorg-indexes
begin-select
OBJECT_ID(name) '$TABLENAME',
avg_fragmentation_in_percent, 
       fragment_count, 
       avg_fragment_size_in_pages
       exit-select
FROM   sys.Dm_db_index_physical_stats(Db_id('dbName'), Object_id('tableName'), 
       NULL, 
              NULL, NULL) AS a 
       INNER JOIN sys.indexes b 
               ON a.object_id = b.object_id 
                  AND a.index_id = b.index_id
				WHERE avg_fragmentation_in_percent < 30
end-select
end-procedure get-reorg-indexees


begin-procedure get-rebuild-indexes
begin-select
OBJECT_ID(name) '$TABLENAME',
avg_fragmentation_in_percent, 
       fragment_count, 
       avg_fragment_size_in_pages
       exit-select
FROM   sys.Dm_db_index_physical_stats(Db_id('dbName'), Object_id('tableName'), 
       NULL, 
              NULL, NULL) AS a 
       INNER JOIN sys.indexes b 
               ON a.object_id = b.object_id 
                  AND a.index_id = b.index_id
				WHERE avg_fragmentation_in_percent > 30
end-select
end-procedure get-rebuild-indexes
*/


CREATE PROCEDURE inuser.rebuild_my_tables
@tablename NVARCHAR(64)
-- Get a list of tables and views in the current database
AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @sql NVARCHAR(MAX),
@val UNIQUEIDENTIFIER = NEWID(),
@sqlstats NVARCHAR(MAX)= N'UPDATE STATISTICS ' + @tablename + N' WITH FULLSCAN'

-- Supplying the @val variable as a placeholder since we are not inputting any additional parameters.

/*

  Upstream the Tables would be populated. Otherwise, use

*/

SET @sql = N'ALTER INDEX ALL REBUILD ON inuser.' + @tablename + N' WITH (ONLINE=ON)'

-- sp_executesql replaces the previous EXEC(@SQL)
EXEC sp_executesql @sql, N'@val NVARCHAR(MAX) OUTPUT',@val OUTPUT;
EXEC sp_executesql @sqlstats, N'@val NVARCHAR(MAX) OUTPUT',@sqlstats OUTPUT

END TRY
BEGIN CATCH
SELECT 
  ERROR_NUMBER() AS ErrorNumber
  ,ERROR_SEVERITY() AS ErrorSeverity
  ,ERROR_STATE() AS ErrorState
  ,ERROR_PROCEDURE() AS ErrorProcedure
  ,ERROR_LINE() AS ErrorLine
  ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

GO

CREATE PROCEDURE inuser.reorg_my_tables
@tablename NVARCHAR(64)
-- Get a list of tables and views in the current database
AS
SET NOCOUNT ON
BEGIN TRY
DECLARE @sql NVARCHAR(MAX),
@val UNIQUEIDENTIFIER = NEWID(),
@sqlstats NVARCHAR(MAX)= N'UPDATE STATISTICS ' + @tablename + N' WITH FULLSCAN'

-- Supplying the @val variable as a placeholder since we are not inputting any additional parameters.

/*

  Upstream the Tables would be populated. Otherwise, use

*/

SET @sql = N'ALTER INDEX ALL REORGANIZE ON inuser.' + @tablename + N' WITH (ONLINE=ON)'

-- sp_executesql replaces the previous EXEC(@SQL)
EXEC sp_executesql @sql, N'@val NVARCHAR(MAX) OUTPUT',@val OUTPUT;
EXEC sp_executesql @sqlstats, N'@val NVARCHAR(MAX) OUTPUT',@sqlstats OUTPUT

END TRY
BEGIN CATCH
SELECT 
  ERROR_NUMBER() AS ErrorNumber
  ,ERROR_SEVERITY() AS ErrorSeverity
  ,ERROR_STATE() AS ErrorState
  ,ERROR_PROCEDURE() AS ErrorProcedure
  ,ERROR_LINE() AS ErrorLine
  ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH;

GO