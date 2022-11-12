-----------------------------------------------------------------------------------------------------------------------------------------------
-------------Disabling or Enabling SQL Server Agent Jobs
-----------------------------------------------------------------------------------------------------------------------------------------------

SELECT SJ.name,SC.name, SJ.enabled
FROM msdb.dbo.sysjobs SJ
INNER JOIN msdb.dbo.syscategories SC on SJ.category_id = SC.category_id
--WHERE SJ.enabled = 1
 AND SC.[name] = N'Database Maintenance'

-----------------------------------------------------------------------------------------------------------------------------------------------
-------------SCRIPT Disable Jobs By Job Category-------------
-----------------------------------------------------------------------------------------------------------------------------------------------
USE MSDB;
GO

DECLARE @job_id uniqueidentifier
DECLARE @SQLCMD varchar (MAX)

DECLARE job_cursor CURSOR READ_ONLY FOR  
SELECT SJ.job_id
FROM msdb.dbo.sysjobs SJ
INNER JOIN msdb.dbo.syscategories SC on SJ.category_id = SC.category_id
WHERE SJ.enabled = 0  ---------1 Enable 0 Disable
  AND SC.[name] = N'Database Maintenance' -------------Nom de la catégorie dans les propriétés du job
AND SJ.name not like 'Jobs%'

OPEN job_cursor   
FETCH NEXT FROM job_cursor INTO @job_id  

WHILE @@FETCH_STATUS = 0
BEGIN
   EXEC msdb.dbo.sp_update_job @job_id = @job_id, @enabled = 1 ---------1 Enable 0 Disable
   FETCH NEXT FROM job_cursor INTO @job_id  
END

CLOSE job_cursor   
DEALLOCATE job_cursor