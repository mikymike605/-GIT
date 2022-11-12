-- Backup Database pour initialiser la base au mode ?ORECOVERY

BACKUP DATABASE [test] TO  DISK = N'G:\bases\mssql\backup\test.bak' WITH NOFORMAT, NOINIT,  NAME = N'test-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

---------------------------------------------------------
-- Execute the following statements at the Primary to configure Log Shipping
-- for the database [Primary_DB_Server_Name].[User_DB_Name],
-- The script needs to be run at the Primary in the context of the [msdb] database.
---------------------------------------------------------
-- Adding the Log Shipping configuration

-- ****** Begin: Script to be run at Primary: [Primary_DB_Server_Name] ******

DECLARE @LS_BackupJobId    AS uniqueidentifier
DECLARE @LS_PrimaryId    AS uniqueidentifier
DECLARE @SP_Add_RetCode    As int

EXEC @SP_Add_RetCode = master.dbo.sp_add_log_shipping_primary_database
@database = N'test'
,@backup_directory = N'\\sqltst998\G$\bases\mssql\backup\'
,@backup_share = N'\\sqltst998\G$\bases\mssql\backup\'
,@backup_job_name = N'LSBackup_Test'
,@backup_retention_period = 60
,@backup_compression = 2
,@backup_threshold = 10
,@threshold_alert_enabled = 1
,@history_retention_period = 5760
,@backup_job_id = @LS_BackupJobId OUTPUT
,@primary_id = @LS_PrimaryId OUTPUT
,@overwrite = 1

IF (@@ERROR = 0 AND @SP_Add_RetCode = 0)
BEGIN
--DECLARE @LS_BackupJobId    AS uniqueidentifier
DECLARE @LS_BackUpScheduleUID    As uniqueidentifier
DECLARE @LS_BackUpScheduleID    AS int

EXEC msdb.dbo.sp_add_schedule
@schedule_name =N'LSBackupSchedule_Primary'
,@enabled = 1
,@freq_type = 4
,@freq_interval = 1
,@freq_subday_type = 4
,@freq_subday_interval = 4
,@freq_recurrence_factor = 0
,@active_start_date = 20160728
,@active_end_date = 99991231
,@active_start_time = 0
,@active_end_time = 235900
,@schedule_uid = @LS_BackUpScheduleUID OUTPUT
,@schedule_id = @LS_BackUpScheduleID OUTPUT

EXEC msdb.dbo.sp_attach_schedule
@job_id = @LS_BackupJobId
,@schedule_id = @LS_BackUpScheduleID

EXEC msdb.dbo.sp_update_job
@job_id = @LS_BackupJobId
,@enabled = 1

END

EXEC master.dbo.sp_add_log_shipping_alert_job

EXEC master.dbo.sp_add_log_shipping_primary_secondary
@primary_database = N'Test'
,@secondary_server = N'SQLTST999'
,@secondary_database = N'TEST'
,@overwrite = 1

---------------------------------------------------------
-- ****** End: Script to be run at Primary: [Primary_DB_Server_Name]  ******
---------------------------------------------------------

---------------------------------------------------------
-- Restore Database pour initialiser la base au mode NORECOVERY

RESTORE DATABASE test

   FROM DISK = 'G:\bases\mssql\backup\test_20220520020006.bak'

WITH NORECOVERY


---------------------------------------------------------
-- Execute the following statements at the Secondary to configure Log Shipping
-- for the database [Secondary_Server_Name].[User_DB_Name],
-- the script needs to be run at the Secondary in the context of the [msdb] database.
---------------------------------------------------------
-- Adding the Log Shipping configuration

-- ****** Begin: Script to be run at Secondary: [Secondary_Server_Name] ******

DECLARE @LS_Secondary__CopyJobId    AS uniqueidentifier
DECLARE @LS_Secondary__RestoreJobId    AS uniqueidentifier
DECLARE @LS_Secondary__SecondaryId    AS uniqueidentifier
DECLARE @LS_Add_RetCode    As int

EXEC @LS_Add_RetCode = master.dbo.sp_add_log_shipping_secondary_primary
@primary_server = N'SQLTST998'
,@primary_database = N'test'
,@backup_source_directory = N'G:\bases\mssql\backup'
,@backup_destination_directory = N'G:\bases\mssql\backup'
,@copy_job_name = N'LSCopy_Primary_Test'
,@restore_job_name = N'LSRestore_Primary_Test'
,@file_retention_period = 4320
,@overwrite = 1
,@copy_job_id = @LS_Secondary__CopyJobId OUTPUT
,@restore_job_id = @LS_Secondary__RestoreJobId OUTPUT
,@secondary_id = @LS_Secondary__SecondaryId OUTPUT

IF (@@ERROR = 0 AND @LS_Add_RetCode = 0)
BEGIN

DECLARE @LS_SecondaryCopyJobScheduleUID    As uniqueidentifier
DECLARE @LS_SecondaryCopyJobScheduleID    AS int

EXEC msdb.dbo.sp_add_schedule
@schedule_name =N'DefaultCopyJobSchedule'
,@enabled = 1
,@freq_type = 4
,@freq_interval = 1
,@freq_subday_type = 4
,@freq_subday_interval = 15
,@freq_recurrence_factor = 0
,@active_start_date = 20160728
,@active_end_date = 99991231
,@active_start_time = 0
,@active_end_time = 235900
,@schedule_uid = @LS_SecondaryCopyJobScheduleUID OUTPUT
,@schedule_id = @LS_SecondaryCopyJobScheduleID OUTPUT

EXEC msdb.dbo.sp_attach_schedule
@job_id = @LS_Secondary__CopyJobId
,@schedule_id = @LS_SecondaryCopyJobScheduleID

DECLARE @LS_SecondaryRestoreJobScheduleUID    As uniqueidentifier
DECLARE @LS_SecondaryRestoreJobScheduleID    AS int

EXEC msdb.dbo.sp_add_schedule
@schedule_name =N'DefaultRestoreJobSchedule'
,@enabled = 1
,@freq_type = 4
,@freq_interval = 1
,@freq_subday_type = 4
,@freq_subday_interval = 15
,@freq_recurrence_factor = 0
,@active_start_date = 20160728
,@active_end_date = 99991231
,@active_start_time = 0
,@active_end_time = 235900
,@schedule_uid = @LS_SecondaryRestoreJobScheduleUID OUTPUT
,@schedule_id = @LS_SecondaryRestoreJobScheduleID OUTPUT

EXEC msdb.dbo.sp_attach_schedule
@job_id = @LS_Secondary__RestoreJobId
,@schedule_id = @LS_SecondaryRestoreJobScheduleID

END

DECLARE @LS_Add_RetCode2    As int

IF (@@ERROR = 0 AND @LS_Add_RetCode = 0)
BEGIN

EXEC @LS_Add_RetCode2 = master.dbo.sp_add_log_shipping_secondary_database
@secondary_database = N'test'
,@primary_server = N'SQLTST998'
,@primary_database = N'test'
,@restore_delay = 0
,@restore_mode = 1
,@disconnect_users    = 1
,@restore_threshold = 5
,@threshold_alert_enabled = 1
,@history_retention_period    = 5760
,@overwrite = 1

END

IF (@@error = 0 AND @LS_Add_RetCode = 0)
BEGIN

EXEC msdb.dbo.sp_update_job
@job_id = @LS_Secondary__CopyJobId
,@enabled = 1

EXEC msdb.dbo.sp_update_job
@job_id = @LS_Secondary__RestoreJobId
,@enabled = 1

END
---------------------------------------------------------
-- ****** End: Script to be run at Secondary: [Secondary_Server_Name] ******
---------------------------------------------------------
