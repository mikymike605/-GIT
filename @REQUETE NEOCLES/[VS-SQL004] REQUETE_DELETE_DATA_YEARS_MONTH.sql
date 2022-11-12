/*--https://www.mssqltips.com/sqlservertip/6240/script-to-delete-sql-server-data-in-batches/-- 
--TST-SQL Code for Stored Procedure Creation */

IF EXISTS (
   SELECT type_desc, type
    FROM sys.procedures WITH(NOLOCK)
    WHERE NAME = 'Batch_Delete'
            AND type = 'P'
)
DROP PROCEDURE Batch_Delete
GO
 
CREATE PROCEDURE Batch_Delete
@startDate          DATE,
@endDate            DATE,
@dbName             VARCHAR(64) = NULL,
@schemaName         VARCHAR(64) = NULL,
@tableName          VARCHAR(64) = NULL,
@dateFieldName      VARCHAR(64) = NULL,
@saveToHistoryTable BIT = 1,
@batch              INT = 1000
AS
  SET NOCOUNT ON
 
  DECLARE @tableExists BIT = 0
  DECLARE @fieldExists BIT = 0
  DECLARE @sqlCommand NVARCHAR(2048)
 
  IF(@startDate > @endDate OR @startDate = @endDate)
  BEGIN
   RAISERROR('startDate can''t be higher or equal than endDate!!!', 16, -1)
   RETURN
  END
 
  IF(@dbName IS NULL OR RTRIM(@dbname) = '')
  BEGIN
   RAISERROR('You must specify the source database where the table is hosted!!!', 16, -1)
   RETURN
  END
 
  IF(@schemaName IS NULL OR RTRIM(@schemaName) = '')
  BEGIN
   RAISERROR('You must specify the schema of the table!!!', 16, -1)
   RETURN
  END
 
  IF(@tableName IS NULL OR RTRIM(@tableName) = '')
  BEGIN
   RAISERROR('You must specify the name of the table!!!', 16, -1)
   RETURN
  END
 
  IF(@dateFieldName IS NULL OR RTRIM(@dateFieldName) = '')
  BEGIN
   RAISERROR('You must specify the name of the column that contains the dates for the lookups!!!', 16, -1)
   RETURN
  END
 
  DECLARE @e AS TABLE([objectID] BIGINT)
  SET @sqlCommand = '
  DECLARE @objectID BIGINT = 0
  SELECT @objectID = OBJECT_ID ('+CHAR(39)+'['+@dbname+'].['+@schemaName+'].['+@tableName+']'+CHAR(39)+',''U'')
  SELECT ISNULL(@objectID,-1)
  '
 
  INSERT INTO @e
  EXEC sp_executesql @sqlCommand
  SET @tableExists = (SELECT CASE [objectID] WHEN -1 THEN 0 ELSE 1 END FROM @e)
  DELETE FROM @e
 
  IF(@tableExists <> 1)
  BEGIN
   RAISERROR('The specified table can''t be located, please check and try again!!!', 16, -1)
   RETURN
  END
 
  DECLARE @f AS TABLE([size] SMALLINT)
  SET @sqlCommand = '
  DECLARE @colSize SMALLINT = 0
  SELECT @colSize = COL_LENGTH ('+CHAR(39)+'['+@dbname+'].['+@schemaName+'].['+@tableName+']'+CHAR(39)+','+CHAR(39)+@dateFieldName+CHAR(39)+')
  SELECT ISNULL(@colSize,-1)
  '
  INSERT INTO @f
  EXEC sp_executesql @sqlCommand
  SET @fieldExists = (SELECT CASE [size] WHEN -1 THEN 0 ELSE 1 END FROM @f)
  DELETE FROM @f
 
  IF(@fieldExists = 0)
  BEGIN
   RAISERROR('The specified field can''t be located, please check and try again!!!', 16, -1)
   RETURN
  END
 
  IF(@saveToHistoryTable = 0)
  PRINT 'Be aware that you have invoked the execution of this SP with historical data transfer turned off!!!'
 
  -- Per Day logic
  DECLARE @currentDate DATE
  DECLARE @startTime   DATETIME
  DECLARE @endTime     DATETIME
  DECLARE @rows        INT
  DECLARE @totalRows   INT
  DECLARE @deletedRows INT
 
  SET @currentDate = @startDate
 
  SET @sqlCommand = '
  USE '+'['+@dbname+']
  '
  EXEC(@sqlCommand)
 
  IF OBJECT_ID ('Delete_Metrics','U') IS NULL
  BEGIN
    CREATE TABLE Delete_Metrics(
      StartDate      DATE NOT NULL,
      EndDate        DATE NOT NULL,
      Records        INT NOT NULL,
      CompletionTime INT NOT NULL
   )
    CREATE NONCLUSTERED INDEX IX_StartDate ON Delete_Metrics(StartDate)
    CREATE NONCLUSTERED INDEX IX_EndDate ON Delete_Metrics(EndDate)
  END
 
  IF(@saveToHistoryTable = 1)
  BEGIN
   DECLARE @h AS TABLE([rows] INT)
    SET @sqlCommand = '
    SET NOCOUNT ON
 
    IF OBJECT_ID ('+CHAR(39)+'['+@dbname+'].['+@schemaName+'].['+@tableName+'_historic]'+CHAR(39)+',''U'') IS NULL
    BEGIN
        SELECT TOP 0 * INTO ['+@dbname+'].['+@schemaName+'].['+@tableName+'_historic] FROM ['+@dbname+'].['+@schemaName+'].['+@tableName+']  
    END
 
    INSERT INTO ['+@dbname+'].['+@schemaName+'].['+@tableName+'_historic]
    SELECT * FROM ['+@dbname+'].['+@schemaName+'].['+@tableName+'] WHERE ['+@dateFieldName+'] >= '+CHAR(39)+CONVERT(VARCHAR(20),@startDate)+CHAR(39)+' AND ['+@dateFieldName+'] < '+CHAR(39)+CONVERT(VARCHAR(20),@endDate)+CHAR(39)+'
   
   SELECT @@ROWCOUNT
   '
   INSERT INTO @h
    EXEC sp_executesql @sqlCommand
    SET @totalRows = (SELECT [rows] FROM @h)
    DELETE FROM @h
 
   IF(@totalRows > 0)
   RAISERROR ('#Finished transferring records to historic table#', 0, 1) WITH NOWAIT
  END
 
  WHILE(@currentDate < @endDate)
  BEGIN
   BEGIN TRANSACTION
      BEGIN TRY
            DECLARE @t AS TABLE([rows] INT)
            SET @sqlCommand = '
            DECLARE @tempTotalRows INT = 0
            SELECT @tempTotalRows = COUNT(*) FROM ['+@dbName+'].['+@schemaName+'].['+@tableName+'] WHERE ['+@dateFieldName+'] >= '+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+' AND ['+@dateFieldName+'] < DATEADD(DAY,1,'+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+')
            SELECT @tempTotalRows
            '
            INSERT INTO @t
            EXEC sp_executesql @sqlCommand
            SET @totalRows = (SELECT [rows] FROM @t)
            DELETE FROM @t
 
         SET @deletedRows = 0
         SET @startTime = GETDATE()
         DECLARE @d AS TABLE([rows] INT)
 
         WHILE @deletedRows < @totalRows 
         BEGIN
             SET @sqlCommand = '            
            DELETE TOP ('+CONVERT(VARCHAR(16),@batch)+')
            FROM ['+@dbName+'].['+@schemaName+'].['+@tableName+'] WHERE ['+@dateFieldName+'] >= '+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+' AND ['+@dateFieldName+'] < DATEADD(DAY,1,'+CHAR(39)+CONVERT(VARCHAR(20),@currentDate)+CHAR(39)+')
 
            SELECT @@ROWCOUNT
                '
 
                INSERT INTO @d
            EXEC sp_executesql @sqlCommand
            SET @deletedRows += (SELECT [rows] FROM @d)
            DELETE FROM @d
         
            SELECT l.total_size AS TotalSize,f.free_space AS FreeSpace
            FROM(
               SELECT CONVERT(DECIMAL(10,2),(total_log_size_in_bytes - used_log_space_in_bytes)/1024.0/1024.0) AS [free_space]  
               FROM sys.dm_db_log_space_usage
            )AS f,
            (
               SELECT CONVERT(DECIMAL(10,2),size*8.0/1024.0) AS [total_size]
               FROM sys.database_files
               WHERE type_desc = 'LOG'
            )AS l
 
         END
 
         IF(@deletedRows > 0)
         BEGIN
            DECLARE @stringDate VARCHAR(10) = CONVERT(VARCHAR(10),@currentDate)
            RAISERROR('Finished deleting records for date: %s',0,1,@stringDate) WITH NOWAIT
            INSERT INTO Delete_Metrics VALUES(@currentDate, DATEADD(DAY,1,@currentDate),@deletedRows,DATEDIFF(SECOND,@startTime,GETDATE()))
         END
 
         SET @currentDate = DATEADD(DAY,1,@currentDate)
 
         COMMIT TRANSACTION
      END TRY
      BEGIN CATCH
         ROLLBACK TRANSACTION
         SELECT ERROR_MESSAGE() AS ErrorMessage;
      END CATCH
  END



  /*-- Running the Delete Stored Procedure
  DECLARE @startDate date =  DATEADD(M, -15, CONVERT(DATE, CONVERT(VARCHAR(6), GETDATE(),112) + '01'))
 DECLARE @endDate date =  DATEADD(M, -7, CONVERT(DATE, CONVERT(VARCHAR(6), GETDATE(),112) + '01'))

print @startDate  
print @endDate

--SET IDENTITY_INSERT AdminMonitor.dbo.MONITOR_historic ON

EXECUTE [dbo].[Batch_Delete]  
   @startDate          = @startDate 
   ,@endDate            =  @endDate
   ,@dbName             = 'os1_db'
   ,@schemaName         = 'dbo'
   ,@tableName          = 'Event'
   ,@dateFieldName      = 'create_date'
   ,@saveToHistoryTable = 0
   ,@batch              = 1000
    
--SET IDENTITY_INSERT AdminMonitor.dbo.MONITOR_historic OFF

 */

 /*--INDENTIFIER LA COLONNE IDENTITY_INSERT----SUPPRIMER LA STRUCTURE DE LA COLONNE-------
SELECT * FROM sys.columns 
WHERE object_id=OBJECT_ID ('MONITOR_historic')
-- is_identity = 1

*/

 /*--Check Progress of Delete Processing 
  SELECT 
   StartDate,
   EndDate,
   Records,
   [Total Records] = SUM(Records) OVER (ORDER BY StartDate),
   CompletionTime,
   [Total Time] = SUM(CompletionTime) OVER (ORDER BY StartDate),
    CONVERT(DECIMAL(10,2),
   ((SELECT (CONVERT(DECIMAL(10,2),COUNT(*))/ SUM(Records) OVER (ORDER BY StartDate)  )
   FROM [os1_db].[dbo].[Event_historic]) ) * 100) AS 'Progress'
FROM Delete_Metrics
where StartDate>='20221201'
*/



/*
  SELECT 
 YEAR (StartDate) as Year, MONTH(StartDate) as Month, CONVERT(NUMERIC(10,2),SUM ([CompletionTime])/60 ) AS [ETA Min],SUM(Records) as Total Records
FROM [os1_db]..Delete_Metrics
where  YEAR (StartDate)='2021'
and MONTH(StartDate) >'7'
group by  YEAR (StartDate) ,MONTH(StartDate) 
order by 1,2


  SELECT 
 YEAR (StartDate) as Year,  CONVERT(NUMERIC(10,2),SUM ([CompletionTime])/60 ) AS [ETA Min]
FROM [os1_db]..Delete_Metrics
group by  YEAR (StartDate) 
order by 1

*/


/* ---------------ANALYSE DES PURGES A EFFECTUER SUR LES 6 DERNIERS MOIS---------------
DECLARE @sql VARCHAR(4096)
DECLARE @date VARCHAR(14)
	
SET @date = DATEADD(M, -6, CONVERT(DATE, CONVERT(VARCHAR(6), GETDATE(),112) + '01')) 
	

IF EXISTS (SELECT * FROM TEMPDB.SYS.ALL_OBJECTS WHERE NAME LIKE '%#TMP%') 
DROP TABLE #TMP 

SELECT YEAR (create_date)AS YEAR,
 MONTH(create_date)AS MONTH ,
 COUNT (*) AS NBR_LIGNES 
 INTO #TMP 
 FROM os1_db..Event 
 WHERE create_date < DATEADD(M, -6, CONVERT(DATE, CONVERT(VARCHAR(6), GETDATE(),112) + '01')) 
GROUP BY YEAR (create_date), MONTH(create_date)
ORDER BY YEAR (create_date)DESC , MONTH(create_date)DESC 

 SELECT * from #TMP
 --where YEAR = 2019
 order by 1,2
 
 */

 /* 
 ---------------ANALYSE DES PURGES PAR MOIS---------------
   SELECT 
   year (cast (StartDate as date)) Year
   ,month (cast (StartDate as date)) Month
   --year(cast (EndDate as date)),month (cast (EndDate as date)),
  ,SUM (Records) Nbr_Lignes
   --,[Total Records] = SUM(Records) OVER (ORDER BY StartDate),
   ,sum (CompletionTime)/60 as Temps_Traitement
   --,[Total Time] = SUM(CompletionTime) OVER (ORDER BY StartDate)
   -- CONVERT(DECIMAL(10,2),
   --((SELECT (CONVERT(DECIMAL(10,2),COUNT(*))/ SUM(Records) OVER (ORDER BY StartDate)  )
   --FROM [os1_db].[dbo].[Event_historic]) ) * 100) AS 'Progress'
FROM Delete_Metrics
where StartDate >'20210130'
group by    year (cast (StartDate as date)),month (cast (StartDate as date))--,CompletionTime

*/