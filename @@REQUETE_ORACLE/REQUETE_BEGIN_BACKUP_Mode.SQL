set feedback off pagesize 0 heading off verify off linesize 200 trimspool on

define dir ='G:\oracle\'
define fil='G:\oracle\open_backup_commands.sql'
define spo ='G:\oracle\open_backup_ouput.lst'
define archive_backup_dir='F:\oracle\Archive_BACKUP\'

prompt **** Spooling to &fil *****

set serveroutput on
spool &fil
prompt set feedback on pagesize 0 heading on verify on
prompt spool &spo
prompt prompt Creating directory
select 'host mkdir &dir'||to_char(sysdate,'YYYYMMDD') from dual;

prompt prompt Switching logfile

alter system switch logfile;

prompt prompt database in backup mode
prompt alter database begin backup;;
prompt prompt Datafiles copy has been started
select 'host copy '|| name ||' &dir'||to_char(sysdate,'YYYYMMDD') from  v$controlfile order by name;
select 'host copy '|| name ||' &dir'||to_char(sysdate,'YYYYMMDD') from v$datafile order by name;
select 'host copy '|| member ||' &dir'||to_char(sysdate,'YYYYMMDD') from v$logfile order by member;
select 'host copy '|| name ||' &dir'||to_char(sysdate,'YYYYMMDD') from v$tempfile order by name;
prompt prompt Datafiles copy has been completed
prompt alter database end backup;;
prompt prompt Database backup mode ended
prompt prompt Controlfile backup

--select 'alter database backup controlfile to trace as ''&dir'||to_char(sysdate,'YYYYMMDD')||'\Ctl_Backup.ctl'';' from dual;
select  'host copy '||decode((select value from v$parameter where name='spfile'),null,
(select value from v$parameter where name='pfile'),(select value from v$parameter 
where name='spfile'))||' &dir'||to_char(sysdate,'YYYYMMDD') from dual;


prompt prompt alter system archive log current 
prompt alter system archive log current ;;


prompt prompt Database backup completed successfully
prompt spool off;;
spool off;
@&fil
exit