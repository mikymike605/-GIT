
DECLARE @ScriptToExecute VARCHAR(MAX);
SET @ScriptToExecute = '';
SELECT
@ScriptToExecute = @ScriptToExecute +
'USE ['+d.name+']'+char (13)+'GO'+char (13)+'CHECKPOINT;'+char (13)+'DBCC SHRINKFILE ('''+f.name+''');'+char (13)+char (13)+''
FROM sys.master_files f
INNER JOIN sys.databases d ON d.database_id = f.database_id
WHERE f.type = 1 AND d.database_id > 4
--SELECT @ScriptToExecute ScriptToExecute
PRINT (@ScriptToExecute)
--EXEC  (@ScriptToExecute)


SELECT d.name,f.name
FROM sys.master_files f
INNER JOIN sys.databases d ON d.database_id = f.database_id
WHERE f.type = 1 AND d.database_id > 4


