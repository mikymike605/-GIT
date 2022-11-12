
--A subjective list of top-10 useful queries for SQL Server troubleshooting
--https://nextian.com/2017/03/24/troubleshooting-sql-server-databases/--

------------------------------------------------------------------------------------------------------------------------------------------------------
--List of long lasting 
--locks Locks lasting longer than 0.5 seconds:
------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT  'locks Locks lasting longer than 0.5 seconds:',
    spid,  
    blocked,  
    program_name,  
    hostname,  
    lastwaittype 
FROM
    master.dbo.SysProcesses  
WHERE  
    blocked <> 0 AND waittime > 500 -- milliseconds

------------------------------------------------------------------------------------------------------------------------------------------------------
--Count of long lasting locks
--Count of locks lasting more than 0.5 seconds --(see also https://msdn.microsoft.com/en-us/library/ms179881.aspx):
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'Count of locks lasting more than 0.5 seconds ',
    COUNT(spid)
FROM 
    master.dbo.SysProcesses
WHERE 
    blocked <> 0 AND waittime > 500;
	
------------------------------------------------------------------------------------------------------------------------------------------------------	
--Total count of server connections Connections to all databases:
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'Total count of server connections Connections to all databases',
    COUNT(dbid) as 'Total server connections'
FROM
    sys.sysprocesses
WHERE 
    dbid > 0 AND 
    ecid = 0;
	
------------------------------------------------------------------------------------------------------------------------------------------------------
--Number of connections per database (all users)
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'Number of connections per database (all users)',
    COUNT(*) AS 'Number of connections', 
    DB_NAME(dbid) AS 'Database' 
FROM
    sys.sysprocesses 
WHERE 
    dbid > 4 AND 
    ecid = 0
GROUP BY DB_NAME(dbid);
------------------------------------------------------------------------------------------------------------------------------------------------------
--User/database connections
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'User/database connections',
    COUNT(*) AS 'Number of user/database connections',
    DB_NAME(S.dbid) AS 'Database',
    USER_NAME(S.uid) AS 'User' 
FROM
    sys.sysprocesses S 
GROUP BY S.dbid, S.uid;

------------------------------------------------------------------------------------------------------------------------------------------------------
--Idle sessions
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'Idle sessions',
    C.connection_id AS 'Connection', 
    S.session_id AS 'Session', 
    S.login_time AS 'Login time',
    S.last_request_end_time AS 'Last request completed',
    DATEDIFF( SECOND, S.last_request_end_time, GETDATE() ) AS 'Seconds ago',  
    S.status AS 'Session status',
    S.host_name AS 'Host', 
    S.login_name AS 'Login'
FROM
    sys.dm_exec_connections C
LEFT JOIN
    sys.dm_exec_sessions S ON C.session_id = S.session_id
WHERE
    C.most_recent_sql_handle = 0x0
	and host_name like '%PROSP%';

------------------------------------------------------------------------------------------------------------------------------------------------------
--Users’ idle sessions
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT 'Users’ idle sessions',
    COUNT(S.session_id) AS 'Idle sessions',
    S.login_name AS 'User'
FROM
    sys.dm_exec_connections C
LEFT JOIN
    sys.dm_exec_sessions S ON C.session_id = S.session_id
WHERE
    C.most_recent_sql_handle = 0x0
GROUP BY 
    S.login_name

------------------------------------------------------------------------------------------------------------------------------------------------------
--Longest running queries (in the last 3 minutes)
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT TOP 50
    qs.last_elapsed_time / 1000000.0 AS 'Last elapsed time (s)',
    qs.total_elapsed_time / qs.execution_count / 1000000.0 AS 'Average execution time (s)',
    qs.total_elapsed_time / 1000000.0 AS 'Accumulated execution time (s)',
    qs.execution_count AS 'Execution count',
    SUBSTRING (qt.text,qs.statement_start_offset/2, 
         (CASE WHEN qs.statement_end_offset = -1 
            THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
          ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) AS 'Query',
    o.name AS 'Object name',
    DB_NAME(qt.dbid) AS 'Database'
FROM
    sys.dm_exec_query_stats qs
CROSS APPLY
    sys.dm_exec_sql_text(qs.sql_handle) as qt
LEFT OUTER JOIN 
    sys.objects o ON qt.objectid = o.object_id
WHERE
    qt.dbid > 0 AND
    qs.last_execution_time > dateadd(mi,-3,getdate())  -- modify time interval here
ORDER BY 1 DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------
--Queries over 2 seconds in last 10 minutes
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT
    qs.last_elapsed_time / 1000000.0 AS 'Last elapsed time (s)',
    SUBSTRING (qt.text,qs.statement_start_offset/2, 
         (CASE WHEN qs.statement_end_offset = -1 
            THEN LEN(CONVERT(NVARCHAR(MAX), qt.text)) * 2 
          ELSE qs.statement_end_offset END - qs.statement_start_offset)/2) AS 'Query',
    o.name AS 'Object name',
    DB_NAME(qt.dbid) AS 'Database'
FROM
    sys.dm_exec_query_stats qs
CROSS APPLY
    sys.dm_exec_sql_text(qs.sql_handle) as qt
LEFT OUTER JOIN
    sys.objects o ON qt.objectid = o.object_id
WHERE
    qt.dbid > 0 AND
    (qs.last_elapsed_time / 1000000.0) >= 2 AND
    qs.last_execution_time > dateadd(mi,-10,getdate())  -- modify time interval here
ORDER BY 1 DESC;

------------------------------------------------------------------------------------------------------------------------------------------------------
--Deadlocks
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT L.request_session_id AS SPID, 
    DB_NAME(L.resource_database_id) AS DatabaseName,
    O.Name AS LockedObjectName, 
    P.object_id AS LockedObjectId, 
    L.resource_type AS LockedResource, 
    L.request_mode AS LockType,
    ST.text AS SqlStatementText,        
    ES.login_name AS LoginName,
    ES.host_name AS HostName,
    TST.is_user_transaction as IsUserTransaction,
    AT.name as TransactionName,
    CN.auth_scheme as AuthenticationMethod
FROM sys.dm_tran_locks L
    JOIN sys.partitions P ON P.hobt_id = L.resource_associated_entity_id
    JOIN sys.objects O ON O.object_id = P.object_id
    JOIN sys.dm_exec_sessions ES ON ES.session_id = L.request_session_id
    JOIN sys.dm_tran_session_transactions TST ON ES.session_id = TST.session_id
    JOIN sys.dm_tran_active_transactions AT ON TST.transaction_id = AT.transaction_id
    JOIN sys.dm_exec_connections CN ON CN.session_id = ES.session_id
    CROSS APPLY sys.dm_exec_sql_text(CN.most_recent_sql_handle) AS ST
ORDER BY L.request_session_id;

------------------------------------------------------------------------------------------------------------------------------------------------------
--Database sizes
------------------------------------------------------------------------------------------------------------------------------------------------------
SELECT DB_NAME(db.database_id) AS 'Database',
       CAST((CAST(RowSizes.RowSize AS FLOAT) * 8) / 1024 AS DECIMAL(10, 2)) AS 'Data size (MB)',
       CAST((CAST(LogSizes.LogSize AS FLOAT) * 8) / 1024 AS DECIMAL(10, 2)) AS 'Log size (MB)',
       CAST((CAST(RowSizes.RowSize AS FLOAT) * 8) / 1024 / 1024 + (CAST(LogSizes.LogSize AS FLOAT) * 8) / 1024 / 1024 AS DECIMAL(10, 2)) AS 'Total size (GB)'
    FROM sys.databases db
    LEFT JOIN
    (
        SELECT database_id,
               SUM(size) RowSize
        FROM sys.master_files
        WHERE type = 0
        GROUP BY database_id,
                 type
    ) RowSizes
        ON RowSizes.database_id = db.database_id
    LEFT JOIN
    (
        SELECT database_id,
               SUM(size) LogSize
        FROM sys.master_files
        WHERE type = 1
        GROUP BY database_id,
                 type
    ) LogSizes
        ON LogSizes.database_id = db.database_id
    LEFT JOIN
    (
        SELECT database_id,
               SUM(size) StreamSize
        FROM sys.master_files
        WHERE type = 2
        GROUP BY database_id,
                 type
    ) StreamSizes
        ON StreamSizes.database_id = db.database_id
    LEFT JOIN
    (
        SELECT database_id,
               SUM(size) TextIndexSize
        FROM sys.master_files
        WHERE type = 4
        GROUP BY database_id,
                 type
    ) TextIndexSizes
        ON TextIndexSizes.database_id = db.database_id
ORDER BY 'Total size (GB)' DESC;