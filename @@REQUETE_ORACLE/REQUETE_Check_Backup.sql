SET PAGESIZE 100
SET LINESIZE 200

select to_char(start_time, 'dd-mon-yyyy@hh24:mi:ss') "Date",to_char(end_time, 'dd-mon-yyyy@hh24:mi:ss')"ENDTIME ", status, operation from v$rman_backup_subjob_details where start_time > sysdate -35 order by start_time;

#select * from v$rman_status where start_time > sysdate -5 order by start_time;





select * from V$BACKUP_FILES;