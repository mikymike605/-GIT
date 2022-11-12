exec master..sp_adddistributor @distributor = 'PROSQL01'
Go



exec master..sp_adddistributiondb @database = 'Distributor', @data_file_size = 5, @log_file_size = 2, @min_distretention = 0, @max_distretention = 72, @history_retention = 48, @security_mode = 1
Go



declare @working_folder varchar(255)
declare @data_path varchar (255)
declare @LenVer int
declare @Version int
declare @SqlDataRoot varchar(255)
declare @instance_InternalName varchar (255)
select @LenVer=PATINDEX('%.',CONVERT(char(2), SERVERPROPERTY('ProductVersion')))
if @LenVer=0
select @Version=CONVERT(int, CONVERT(char(2), SERVERPROPERTY('ProductVersion')))
Else
select @Version=CONVERT(int, LEFT((CONVERT(char(2), SERVERPROPERTY('ProductVersion'))),@LenVer-1))
if @Version=8
begin
exec master.dbo.xp_regread 'HKEY_LOCAL_MACHINE', 'SOFTWARE\Microsoft\MSSQLServer\Setup', 'SQLDataRoot', @param = @data_path OUTPUT
end
else
begin
exec master.dbo.xp_regread 'HKEY_LOCAL_MACHINE', 'SOFTWARE\Microsoft\Microsoft SQL Server\Instance Names\SQL', 'MSSQLServer', @param = @instance_InternalName OUTPUT
select @SqlDataRoot= 'SOFTWARE\Microsoft\Microsoft SQL Server\' + @instance_InternalName + '\Setup'
exec master.dbo.xp_regread 'HKEY_LOCAL_MACHINE', @SqlDataRoot, 'SQLDataRoot', @param = @data_path OUTPUT
end
set @working_folder = @data_path + '\REPLDATA'
exec master..sp_adddistpublisher @publisher = 'PROSQL01', @distribution_db = 'Distributor', @security_mode = 1, @working_directory = @working_folder
Go



exec master..sp_addsubscriber @subscriber = 'DataDistribution', @type = 0, @login = 'sa', @security_mode = 0, @frequency_type = 64, @frequency_interval = 1, @frequency_relative_interval = 2, @frequency_recurrence_factor = 0, @frequency_subday = 8, @frequency_subday_interval = 1, @active_start_date = 0, @active_end_date = 99991231, @active_start_time_of_day = 0, @active_end_time_of_day = 235900, @status_batch_size = 100, @commit_batch_size = 100, @description = ''
exec master..sp_changesubscriber_schedule @subscriber = 'DataDistribution', @agent_type = '1'
GO