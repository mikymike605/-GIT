-- Get the current name of the SQL Server instance for later comparison.
SELECT @@servername

-- Remove server from the list of known remote and linked servers on the local instance of SQL Server.

EXEC master.dbo.sp_dropserver 'PROSQL02'

-- Define the name of the local instance of SQL Server.

EXEC master.dbo.sp_addserver 'PROSQL01', 'local'

-- Get the new name of the SQL Server instance for comparison.

SELECT @@servername