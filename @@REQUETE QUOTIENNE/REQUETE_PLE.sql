
-----https://simplesqlserver.com/2013/08/13/sys-dm_os_perfomance_counters-demystified/

CREATE TABLE OSPerfCounters(
    DateAdded datetime NOT NULL
    , Batch_Requests_Sec int NOT NULL
    , Cache_Hit_Ratio float NOT NULL
    , Free_Pages int  NULL
    , Lazy_Writes_Sec int NOT NULL
    , Memory_Grants_Pending int NOT NULL
    , Deadlocks int NOT NULL
    , Page_Life_Exp int NOT NULL
    , Page_Lookups_Sec int NOT NULL
    , Page_Reads_Sec int NOT NULL
    , Page_Writes_Sec int NOT NULL
    , SQL_Compilations_Sec int NOT NULL
    , SQL_Recompilations_Sec int NOT NULL
    , ServerMemoryTarget_KB int NOT NULL
    , ServerMemoryTotal_KB int NOT NULL
    , Transactions_Sec int NOT NULL
)

--You'll typically only query this by one value, which is added sequentually.  No page splits!!!
CREATE UNIQUE CLUSTERED INDEX IX_OSPerfCounters_DateAdded_U_C ON OSPerfCounters
(
    DateAdded
) WITH (FillFactor = 100)

--Only holds one value at a time, indexes are a waste
CREATE TABLE OSPerfCountersLast(
    DateAdded datetime NOT NULL
    , BatchRequests bigint NOT NULL
    , LazyWrites bigint NOT NULL
    , Deadlocks bigint NOT NULL
    , PageLookups bigint NOT NULL
    , PageReads bigint NOT NULL
    , PageWrites bigint NOT NULL
    , SQLCompilations bigint NOT NULL
    , SQLRecompilations bigint NOT NULL
    , Transactions bigint NOT NULL
)

IF object_id('tempdb..#OSPC') IS NOT NULL BEGIN
    DROP TABLE #OSPC
END

DECLARE @FirstCollectionTime DateTime
    , @SecondCollectionTime DateTime
    , @NumberOfSeconds Int
    , @BatchRequests Float
    , @LazyWrites Float
    , @Deadlocks BigInt
    , @PageLookups Float
    , @PageReads Float
    , @PageWrites Float
    , @SQLCompilations Float
    , @SQLRecompilations Float
    , @Transactions Float

DECLARE @CounterPrefix NVARCHAR(30)
SET @CounterPrefix = CASE WHEN @@SERVICENAME = 'MSSQLSERVER'
                            THEN 'SQLServer:'
                        ELSE 'MSSQL$' + @@SERVICENAME + ':'
                        END

--Grab the current values from dm_os_performance_counters
--Doesn't do anything by instance or database because this is good enough and works unaltered in all envirornments
SELECT counter_name, cntr_value--, cntr_type --I considered dynamically doing each counter type, but decided manual was better in this case
INTO #OSPC 
FROM sys.dm_os_performance_counters 
WHERE object_name like @CounterPrefix + '%'
    AND instance_name IN ('', '_Total')
    AND counter_name IN ( N'Batch Requests/sec'
                        , N'Buffer cache hit ratio'
                        , N'Buffer cache hit ratio base'
                        , N'Free Pages'
                        , N'Lazy Writes/sec'
                        , N'Memory Grants Pending'
                        , N'Number of Deadlocks/sec'
                        , N'Page life expectancy'
                        , N'Page Lookups/Sec'
                        , N'Page Reads/Sec'
                        , N'Page Writes/Sec'
                        , N'SQL Compilations/sec'
                        , N'SQL Re-Compilations/sec'
                        , N'Target Server Memory (KB)'
                        , N'Total Server Memory (KB)'
                        , N'Transactions/sec')

--Just collected the second batch in the query above
SELECT @SecondCollectionTime = GetDate()

--Grab the most recent values, if they are appropriate (no reboot since grabbing them last)
SELECT @FirstCollectionTime = DateAdded
    , @BatchRequests = BatchRequests
    , @LazyWrites = LazyWrites
    , @Deadlocks = Deadlocks
    , @PageLookups = PageLookups
    , @PageReads = PageReads
    , @PageWrites = PageWrites
    , @SQLCompilations = SQLCompilations
    , @SQLRecompilations = SQLRecompilations
    , @Transactions = Transactions
FROM OSPerfCountersLast 
WHERE DateAdded > (SELECT create_date FROM sys.databases WHERE name = 'TempDB')

--If there was a reboot then all these values would have been 0 at the time the server came online (AKA: TempDB's create date)
SELECT @FirstCollectionTime = ISNULL(@FirstCollectionTime, (SELECT create_date FROM sys.databases WHERE name = 'TempDB'))
    , @BatchRequests = ISNULL(@BatchRequests, 0)
    , @LazyWrites = ISNULL(@LazyWrites, 0)
    , @Deadlocks = ISNULL(@Deadlocks, 0)
    , @PageLookups = ISNULL(@PageLookups, 0)
    , @PageReads = ISNULL(@PageReads, 0)
    , @PageWrites = ISNULL(@PageWrites, 0)
    , @SQLCompilations = ISNULL(@SQLCompilations, 0)
    , @SQLRecompilations = ISNULL(@SQLRecompilations, 0)
    , @Transactions = ISNULL(@Transactions, 0)

SELECT @NumberOfSeconds = DATEDIFF(ss, @FirstCollectionTime, @SecondCollectionTime)

--I put these in alphabetical order by counter_name, not column name.  It looks a bit odd, but makes sense to me
--Deadlocks are odd here.  I keep track of the number of deadlocks in the time period, not average number of deadlocks per second.
  --AKA, I keep track of things the way I would refer to them when I talk to someone.  "We had 2 deadlocks in the last 5 minutes", not "We averaged .00002 deadlocks per second there"
INSERT INTO OSPerfCounters (DateAdded, Batch_Requests_Sec, Cache_Hit_Ratio, Free_Pages, Lazy_Writes_Sec, Memory_Grants_Pending
    , Deadlocks, Page_Life_Exp, Page_Lookups_Sec, Page_Reads_Sec, Page_Writes_Sec, SQL_Compilations_Sec, SQL_Recompilations_Sec
    , ServerMemoryTarget_KB, ServerMemoryTotal_KB, Transactions_Sec)
SELECT @SecondCollectionTime
    , Batch_Request_Sec        = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Batch Requests/sec') - @BatchRequests) / @NumberOfSeconds
    , Cache_Hit_Ratio        = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Buffer cache hit ratio')/(SELECT cntr_value FROM #OSPC WHERE counter_name = N'Buffer cache hit ratio base')
    , Free_Pages            = (SELECT cntr_value FROM #OSPC WHERE counter_name =N'Free pages')
    , Lazy_Writes_Sec        = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Lazy Writes/sec') - @LazyWrites) / @NumberOfSeconds
    , Memory_Grants_Pending    = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Memory Grants Pending')
    , Deadlocks                = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Number of Deadlocks/sec') - @Deadlocks) 
    , Page_Life_Exp         = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page life expectancy')
    , Page_Lookups_Sec      = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page lookups/sec') - @PageLookups) / @NumberOfSeconds
    , Page_Reads_Sec        = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page reads/sec') - @PageReads) / @NumberOfSeconds
    , Page_Writes_Sec        = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page writes/sec') - @PageWrites) / @NumberOfSeconds
    , SQL_Compilations_Sec  = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'SQL Compilations/sec') - @SQLCompilations) / @NumberOfSeconds
    , SQL_Recompilations_Sec= ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'SQL Re-Compilations/sec') - @SQLRecompilations) / @NumberOfSeconds
    , ServerMemoryTarget_KB = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Target Server Memory (KB)')
    , ServerMemoryTotal_KB  = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Total Server Memory (KB)')
    , Transactions_Sec        = ((SELECT cntr_value FROM #OSPC WHERE counter_name = N'Transactions/sec') - @Transactions) / @NumberOfSeconds

--TRUNCATE TABLE OSPerfCountersLast

--Note, only saving the last value for ones that are done per second.
INSERT INTO OSPerfCountersLast(DateAdded, BatchRequests, LazyWrites, Deadlocks, PageLookups, PageReads
    , PageWrites, SQLCompilations, SQLRecompilations, Transactions)
SELECT DateAdded            = @SecondCollectionTime
    , BatchRequests            = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Batch Requests/sec')
    , LazyWrites            = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Lazy Writes/sec')
    , Deadlocks             = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Number of Deadlocks/sec')
    , PageLookups            = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page lookups/sec')
    , PageReads                = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page reads/sec')
    , PageWrites            = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Page writes/sec')
    , SQLCompilations        = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'SQL Compilations/sec')
    , SQLRecompilations        = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'SQL Re-Compilations/sec')
    , Transactions             = (SELECT cntr_value FROM #OSPC WHERE counter_name = N'Transactions/sec')

DROP TABLE #OSPC



SELECT 'Today', * FROM (
SELECT TOP 7 *
FROM OSPerfCounters
ORDER BY dateadded DESC
) X

UNION
SELECT 'Yesterday', * FROM (SELECT TOP 7 *
FROM OSPerfCounters
WHERE dateadded <= GETDATE()-1
ORDER BY dateadded DESC
) Y

UNION
SELECT 'Last Week', * FROM (
SELECT TOP 7 *
FROM OSPerfCounters
WHERE dateadded <= GETDATE()-7
ORDER BY dateadded DESC) Z

ORDER BY dateadded DESC