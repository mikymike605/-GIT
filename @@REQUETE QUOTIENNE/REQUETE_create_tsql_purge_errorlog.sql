IF EXISTS (SELECT * FROM tempdb.sys.all_objects WHERE NAME LIKE '%#tmp%') 
DROP TABLE #tmp 
--DROP TABLE #tmp3

DECLARE @SQL varchar (max)

CREATE TABLE #tmp 
(
Archive int,
Date datetime,
LogFileSize_Bytes int
)
----SET @SQL='exec xp_enumerrorlogs'
--CREATE TABLE #tmp2 
--(
--Archive2 int,
--Date2 datetime,
--LogFileSize_Bytes2 int,
--command varchar (max)
--)
Insert into #tmp
exec xp_enumerrorlogs

--EXEC (@SQL)


--insert into #tmp2 

select 
Archive,Date, LogFileSize_Bytes/1024/1024 as LogFileSize_MBytes, 'EXEC sp_cycle_errorlog' command
--into #tmp3
from #tmp 
--where LogFileSize_Bytes/1024 >40

SET @SQL = 'EXEC sp_cycle_errorlog'
print  (@SQL)
 --EXEC (@SQL)
 /*
 USE [master]
GO
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'ErrorLogSizeInKb', REG_DWORD, 2000
GO
*/
-- EXEC sp_cycle_errorlog  




