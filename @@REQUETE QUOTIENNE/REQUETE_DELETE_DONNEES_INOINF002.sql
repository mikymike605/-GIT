USE Norskale

SET QUOTED_IDENTIFIER OFF;
GO

select getdate ();

DECLARE @SQL VARCHAR (MAX)

BEGIN TRAN

-- This will return corrupt entries in the dbo.VUEMUser table that do not have a SID format:

SELECT * FROM VUEMUsers WHERE Name LIKE '%\%'

-- Once identified the entries that do not have a SID format, they have to be deleted:

SET @SQL = 'DELETE FROM VUEMUserStatistics WHERE UserId IN (SELECT IdUser FROM VUEMUsers WHERE Name LIKE ''%\%'');
DELETE FROM VUEMUsers WHERE IdUser  IN (SELECT IdUser FROM VUEMUsers WHERE Name LIKE ''%\%'');'

PRINT @SQL

EXEC (@SQL)


SET QUOTED_IDENTIFIER ON;
GO