------------------------------
----------VS-SQL004-----------
------------------------------
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

-- SELECT * from #TMP
-- where YEAR = 2019
-- order by 2

SELECT '--DELETE FROM os1_db..Event WHERE YEAR (create_date) = '+CAST ([YEAR] AS VARCHAR)+' AND MONTH (create_date) = '+CAST ([MONTH] AS VARCHAR)+' ; ' + CHAR(13) + '' FROM #TMP  order by 1 

set @sql= '--DELETE FROM os1_db..Event WHERE YEAR (create_date) = '''+cast (YEAR (@date) as varchar)+''' AND MONTH (create_date) = '''+cast (MONTH (@date) as varchar)+''' ; ''' + CHAR(13) + ''''  

print @sql