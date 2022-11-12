USE [msdb]
GO

/****** Object:  Job [Actualisateur d'analyse de réplication pour Distributor.]    Script Date: 07/06/2022 15:29:40 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Alert Response]    Script Date: 07/06/2022 15:29:40 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Alert Response' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Alert Response'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Actualisateur d''analyse de réplication pour Distributor.', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Actualisateur d''analyse de réplication pour Distributor.', 
		@category_name=N'REPL-Alert Response', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Exécution de l'Agent.]    Script Date: 07/06/2022 15:29:41 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Exécution de l''Agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=2147483647, 
		@retry_interval=1, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.sp_replmonitorrefreshjob  ', 
		@server=N'PROSQL01', 
		@database_name=N'Distributor', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Planification de l''agent de réplication.', 
		@enabled=1, 
		@freq_type=64, 
		@freq_interval=0, 
		@freq_subday_type=0, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171208, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
		--@schedule_uid=N'c8ebba79-45e7-41df-b1f7-5e92a1d891b6'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD dwh_proudreed - Credit Control Coface CSV]    Script Date: 07/06/2022 15:29:41 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:41 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD dwh_proudreed - Credit Control Coface CSV', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68.Règel 3 pour Coface       : 1/ Génération de fichier Out.csv dans \\profic01\users\gdupuis.PROUDREED\Out.csv - 2/ Envoie le fichier Out par FTP - 3/ Archiver le fichier dans \\profic01\users\gdupuis.PROUDREED\_Archives_Coface_Out\', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Lancement Global]    Script Date: 07/06/2022 15:29:41 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Lancement Global', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*****************************************************************************************************************************************************
REGLE -3-
Si un siren présent dans la Base interne mais avec une des 2 références ou un encours différents de celui du portefeuille Ellipro
l’action doit être la  mise à jour de l’une des références et de l’encours dans le portefeuille
               Référence et/ou encours dans l’une des listes   => Action 4
Action 4:
	Modification de l’encours et/ou de la référence dans l’une des deux listes
	a.	Liste VALIDE  
		action= MODIFICATION_DONNEES_LISTE_PERSO
		numeroListeDestination=498477
        NB :dans la partie [data], il faut renseigné la référence et l’encours comme ils doivent apparaitre dans le portefeuille.
******************************************************************************************************************************************************/

--création des deux tabes temporaires : PortefeuilleEllipro et PortefeuilleGagiProd
use dwh_proudreed
drop table PortefeuilleEllipro
create table PortefeuilleEllipro ( rcs varchar(9), reference_commande varchar(9), id_liste varchar(10), libelle_liste varchar(10), ma_reference varchar(10), mon_encours integer )
insert into PortefeuilleEllipro select LEFT(RTRIM(LTRIM(c.rcs)),9), LEFT(LTRIM(RTRIM(c.reference_commande_surveillance)),9), LEFT(c.id_liste,10), LEFT(LTRIM(RTRIM(c.libelle_liste)),10), LEFT(LTRIM(RTRIM(c.ma_reference)),10), sum(c.mon_encours)
from COFACEFTPIN_D_CSV c
group by c.rcs, c.reference_commande_surveillance, c.id_liste, c.libelle_liste, c.ma_reference
order by c.rcs, c.reference_commande_surveillance, sum(c.mon_encours)

use dwh_proudreed
drop table PortefeuilleGagiProd
create table PortefeuilleGagiProd ( SIREN varchar(5), Identifiant varchar(9), Ellinumber varchar(1), RéférenceCommande varchar(9), MaRéférence varchar(10), MonEncours integer )
insert into PortefeuilleGagiProd 
SELECT 
''SIREN'' AS TypeIdentifiant, 
RIGHT(''000000000'' + LTRIM(RTRIM(L.RCS)), 9) AS Identifiant, 
'''' AS Ellinumber, 
LEFT(RTRIM(I.GROUPE),9) AS RéférenceCommande, 
LEFT(RTRIM(I.GROUPE),10) AS MaRéférence, 
SUM(isnull(B.LOYERACT,0)) AS MonEncours
FROM 
gagi_prod..IMMEUBLE I, gagi_prod..PROPRIET P, gagi_prod..BAIL B, gagi_prod..LOCAT L
WHERE     
I.IMMEUBLE   = P.IMMEUBLE 
AND   P.PROPRIETE  = B.PROPRIETE
AND   B.IDLOCAT    = L.IDLOCAT
AND  (B.DRESILIAT IS NULL OR B.DRESILIAT > GetDate())
AND   L.RCS IS NOT NULL
AND  (L.RCS <> '''')
GROUP BY RIGHT(''000000000'' + LTRIM(RTRIM(L.RCS)), 9), I.GROUPE
ORDER BY RIGHT(''000000000'' + LTRIM(RTRIM(L.RCS)), 9), I.GROUPE, SUM(isnull(B.LOYERACT,0))DESC

--création d''une table temporaire : NewPortefeuilleGagiProd qui contient les données concernées depuis premiance sans doublons dans les SIREN et avec le fOnd de loyer Actuel maximal
drop table NewPortefeuilleGagiProd
create table NewPortefeuilleGagiProd ( SIREN varchar(5), Identifiant varchar(9), Ellinumber varchar(1), RéférenceCommande varchar(9), MaRéférence varchar(9), MonEncours integer )

--création d''une table temporaire : TmpId qui sert à éliminer les doublons de la table NewPortefeuilleGagiProd
drop table TmpId
create table TmpId ( Identifiant varchar(9))

declare @Id varchar(100)
declare @SumMonEncours int 
declare CURS_Id CURSOR FOR SELECT g.Identifiant FROM dbo.PortefeuilleGagiProd g;
				OPEN CURS_Id
				FETCH CURS_Id INTO @Id
				WHILE @@FETCH_STATUS = 0
					BEGIN
						--PRINT ''Id= ''+@ID;
						if( @Id Not in ( select Identifiant from TmpId))
							insert into NewPortefeuilleGagiProd 
								select top 1 g.SIREN, g.Identifiant, g.Ellinumber, g.RéférenceCommande, g.MaRéférence, g.MonEncours
								from dbo.PortefeuilleGagiProd g 
								where g.Identifiant = @Id
								group by  g.SIREN, g.Identifiant, g.Ellinumber, g.RéférenceCommande, g.MaRéférence, g.MonEncours
								order by g.MonEncours desc

							set @SumMonEncours =(
								select SUM( isnull(g.MonEncours,0))
								from dbo.PortefeuilleGagiProd g 
								where g.Identifiant = @Id
								group by g.Identifiant)
								--PRINT ''SumMonEncours= ''+ cast(isnull(@SumMonEncours,0)as varchar)

							update NewPortefeuilleGagiProd  set MonEncours = @SumMonEncours where Identifiant = @Id

							insert into TmpId values ( @ID);

						FETCH NEXT FROM CURS_Id INTO @Id
					END
				CLOSE CURS_Id
			DEALLOCATE CURS_Id

--Calcul de Requette pour Régle 3 et inserer la réponse dans une table temporaire CofaceEcart
	--Concatener siren, référence et encours et faire la différence entre les deux tables
	--RCS existent dans base interne et dans ellipro avec une différence de référence ou d''encours

drop table CofaceEcart
create table CofaceEcart ( SIREN varchar(5), Identifiant varchar(9), Ellinumber varchar(1), RéférenceCommande varchar(9), MaRéférence varchar(9), MonEncours integer, RefNG varchar(30), Marefe varchar(9), Monenc integer, RefE varchar(30) )
insert into CofaceEcart 
select
''SIREN'' as SIREN, 
ng.Identifiant as Identifiant,
ng.Ellinumber as Ellinumber, 
ng.RéférenceCommande as RéférenceCommande, 
ng.MaRéférence as MaRéférence, 
ng.MonEncours as MonEncours,
ng.Identifiant+ng.RéférenceCommande+ng.MaRéférence+cast(isnull(ng.MonEncours,0)as varchar) as RefNG,
e.ma_reference as Marefe,
e.mon_encours as Monenc,
e.rcs+e.reference_commande+e.ma_reference+cast(isnull(e.mon_encours,0)as varchar) as RefE
from NewPortefeuilleGagiProd ng, PortefeuilleEllipro e
where ng.Identifiant= e.rcs
and
ng.Identifiant in (select e.rcs from PortefeuilleEllipro e)
and ng.Identifiant+ng.RéférenceCommande+ng.MaRéférence+cast(isnull(ng.MonEncours,0)as varchar) <> e.rcs+e.reference_commande+e.ma_reference+cast(isnull(e.mon_encours,0)as varchar)

--vérifier les options pour les commandes xp_cmdshell
EXEC sp_configure ''show advanced options'', 1
GO
RECONFIGURE
GO
EXEC sp_configure ''xp_cmdshell'', 1
GO
RECONFIGURE

USE master
EXEC xp_cmdshell ''net use B: \\profic01\users\gdupuis.PROUDREED amo2008 /user:PROUDREED\gdupuis /persistent:no'' 

/*
--Génération du fichier Out.csv avec la commande bcp
SET @cmd =
''bcp " ''+
''SELECT TOP 1 ''''[demande]'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''referenceClient = NN346765'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''prefixeClient = GEOCOM'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''contratClient = 22846'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''application= WOM'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''versionApplication= 1'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''action =MODIFICATION_REF_SURV'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''supportRetour = FTP'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''formatRetour = RIEN'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''compteRendu = O'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''separateurData = ;'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''codification = Ellipro'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''[data]'''' ''+
''UNION ALL ''+
''select ''''SIREN'''' + '''';'''' + ce.Identifiant + '''';'''' + ce.Ellinumber + '''';'''' + ce.RéférenceCommande + '''';'''' + ce.MaRéférence + '''';'''' + CAST(ce.MonEncours AS CHAR) FROM dwh_proudreed..CofaceEcart ce where ce.RefNG <> ce.RefE" ''+
''queryout "B:\Out.csv" -w -T -S prosqL01''
EXEC xp_cmdshell @cmd
*/

--Génération du fichier Out2.csv (Action 4.a) avec la commande bcp
DECLARE @cmd2 VARCHAR(5000)
SET @cmd2 =
''bcp " ''+
''SELECT TOP 1 ''''[demande]'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''referenceClient = NN346765'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''prefixeClient = GEOCOM'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''contratClient = 22846'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''application= WOM'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''versionApplication= 1'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''action =MODIFICATION_DONNEES_LISTE_PERSO'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''numeroListeDestination=498477'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''supportRetour = FTP'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''formatRetour = RIEN'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''compteRendu = O'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''separateurData = ;'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''codification = Ellipro'''' FROM dwh_proudreed..CofaceEcart ''+
''UNION ALL ''+
''SELECT TOP 1 ''''[data]'''' ''+
''UNION ALL ''+
''select RTRIM(''''SIREN'''' + '''';'''' + ce.Identifiant + '''';'''' + ce.Ellinumber + '''';'''' + ce.Ellinumber + '''';'''' + ce.MaRéférence + '''';'''' + CAST(ce.MonEncours AS CHAR)) FROM dwh_proudreed..CofaceEcart ce where ce.RefNG <> ce.RefE" ''+
''queryout "B:\Out2.csv" -w -T -S prosqL01''
EXEC xp_cmdshell @cmd2

Use master
DECLARE @FTPServer varchar(128)
DECLARE @FTPUser varchar(128)
DECLARE @FTPPwd varchar(128)
DECLARE @SourcePath varchar(128)
DECLARE @SourceFile varchar(128)
DECLARE @DestPath varchar(128)
DECLARE @FTPMode varchar(10)
DECLARE @workfile varchar(128)
DECLARE @nowstr varchar(25)
DECLARE @Date varchar(25)
DECLARE @ArchiveDest varchar (128)
DECLARE @NewName varchar (128)
/*
SET @FTPServer = ''xchange.dsi-info.net''
SET @FTPUser = ''Fproudreed''
SET @FTPPwd = ''N6bw29CZ''
SET @SourcePath = ''B:\'' -- Source path. Blank for root directory.
SET @SourceFile = ''Out.csv''
SET @DestPath = ''Act'' -- Destination path in fTP.
SET @FTPMode = ''binary'' -- ascii, binary or blank for default.
SET @Date = replace(left(CONVERT(nvarchar(30), GETDATE(), 126),10),''-'','''')
SET @NewName = @Date +''_Out.csv''
print @NewName
SET @ArchiveDest = ''B:\_Archives_Coface_Out\''
DECLARE @tempdir varchar(128)
SET @tempdir = ''B:\_Archives_Coface_Out''
IF RIGHT(@tempdir, 1) <> ''\'' SET @tempdir = @tempdir + ''\''
 
-- Generate @workfile.
SET @nowstr = replace(replace(convert(varchar(30), GETDATE(), 121), '' '', ''_''), '':'', ''-'')
SET @workfile = ''FTP_SPID'' + convert(varchar(128), @@spid) + ''_'' + @nowstr + ''.txt''
 
-- Deal with special chars for echo commands.
select @FTPServer = replace(replace(replace(@FTPServer, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
select @FTPUser = replace(replace(replace(@FTPUser, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
select @FTPPwd = replace(replace(replace(@FTPPwd, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
select @SourcePath = replace(replace(replace(@SourcePath, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
IF RIGHT(@DestPath, 1) = ''\'' SET @DestPath = LEFT(@DestPath, LEN(@DestPath)-1)
 
-- Build the FTP script file.
select @cmd = ''echo '' + ''open '' + @FTPServer + '' > '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd
select @cmd = ''echo '' + @FTPUser + ''>> '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd
select @cmd = ''echo '' + @FTPPwd + ''>> '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd
select @cmd = ''echo '' + ''prompt '' + '' >> '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd
IF LEN(@FTPMode) > 0
BEGIN
    select @cmd = ''echo '' + @FTPMode + '' >> '' + @tempdir + @workfile
    EXEC master..xp_cmdshell @cmd
END
select @cmd = ''echo '' + ''lcd '' + @SourcePath + '' >> '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd
IF LEN(@SourcePath) > 0
BEGIN
    select @cmd = ''echo '' + ''cd '' + @DestPath + '' >> '' + @tempdir + @workfile
    EXEC master..xp_cmdshell @cmd
END
select @cmd = ''echo '' + ''put '' + @SourcePath + @SourceFile + '' >> '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd

select @cmd = ''echo '' + ''quit'' + '' >> '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd
 
-- Execute the FTP command via script file.
select @cmd = ''ftp -s:'' + @tempdir + @workfile
create table #a (id int identity(1,1), s varchar(1000))
insert #a
EXEC master..xp_cmdshell @cmd
select id, ouputtmp = s from #a

-- Clean up.
drop table #a
select @cmd = ''del '' + @tempdir + @workfile
EXEC master..xp_cmdshell @cmd

--Copy to archive
select @cmd = ''xcopy '' + @SourcePath + @SourceFile + '' '' + @ArchiveDest
EXEC master..xp_cmdshell @cmd

-- Rename the file to archive
select @cmd = ''rename ''+ @ArchiveDest + @SourceFile+ '' '' + @NewName
EXEC master..xp_cmdshell @cmd

--Clean up the current directory .
select @cmd = ''del '' + @SourcePath + @SourceFile
EXEC master..xp_cmdshell @cmd
*/

--envoie Out2.csv
SET @FTPServer = ''xchange.dsi-info.net''
SET @FTPUser = ''Fproudreed''
SET @FTPPwd = ''N6bw29CZ''
SET @SourcePath = ''B:\'' -- Source path. Blank for root directory.
SET @SourceFile = ''Out2.csv''
SET @DestPath = ''Act'' -- Destination path in fTP.
SET @FTPMode = ''binary'' -- ascii, binary or blank for default.
SET @Date = replace(left(CONVERT(nvarchar(30), GETDATE(), 126),10),''-'','''')
SET @NewName = @Date +''_Out2.csv''
print @NewName
SET @ArchiveDest = ''B:\_Archives_Coface_Out\''
DECLARE @tempdir2 varchar(128)
SET @tempdir2 = ''B:\_Archives_Coface_Out''
IF RIGHT(@tempdir2, 1) <> ''\'' SET @tempdir2 = @tempdir2 + ''\''
 
-- Generate @workfile.
SET @nowstr = replace(replace(convert(varchar(30), GETDATE(), 121), '' '', ''_''), '':'', ''-'')
SET @workfile = ''FTP_SPID'' + convert(varchar(128), @@spid) + ''_'' + @nowstr + ''.txt''
 
-- Deal with special chars for echo commands.
select @FTPServer = replace(replace(replace(@FTPServer, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
select @FTPUser = replace(replace(replace(@FTPUser, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
select @FTPPwd = replace(replace(replace(@FTPPwd, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
select @SourcePath = replace(replace(replace(@SourcePath, ''|'', ''^|''),''<'',''^<''),''>'',''^>'')
IF RIGHT(@DestPath, 1) = ''\'' SET @DestPath = LEFT(@DestPath, LEN(@DestPath)-1)
 
-- Build the FTP script file.
select @cmd2 = ''echo '' + ''open '' + @FTPServer + '' > '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2
select @cmd2 = ''echo '' + @FTPUser + ''>> '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2
select @cmd2 = ''echo '' + @FTPPwd + ''>> '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2
select @cmd2 = ''echo '' + ''prompt '' + '' >> '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2
IF LEN(@FTPMode) > 0
BEGIN
    select @cmd2 = ''echo '' + @FTPMode + '' >> '' + @tempdir2 + @workfile
    EXEC master..xp_cmdshell @cmd2
END
select @cmd2 = ''echo '' + ''lcd '' + @SourcePath + '' >> '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2
IF LEN(@SourcePath) > 0
BEGIN
    select @cmd2 = ''echo '' + ''cd '' + @DestPath + '' >> '' + @tempdir2 + @workfile
    EXEC master..xp_cmdshell @cmd2
END
select @cmd2 = ''echo '' + ''put '' + @SourcePath + @SourceFile + '' >> '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2

select @cmd2 = ''echo '' + ''quit'' + '' >> '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2
 
-- Execute the FTP command via script file.
select @cmd2 = ''ftp -s:'' + @tempdir2 + @workfile
create table #a2 (id int identity(1,1), s varchar(1000))
insert #a2
EXEC master..xp_cmdshell @cmd2
select id, ouputtmp = s from #a2

-- Clean up.
drop table #a2
select @cmd2 = ''del '' + @tempdir2 + @workfile
EXEC master..xp_cmdshell @cmd2

--Copy to archive
select @cmd2 = ''xcopy '' + @SourcePath + @SourceFile + '' '' + @ArchiveDest
EXEC master..xp_cmdshell @cmd2

-- Rename the file to archive
select @cmd2 = ''rename ''+ @ArchiveDest + @SourceFile+ '' '' + @NewName
EXEC master..xp_cmdshell @cmd2

--Clean up the current directory .
select @cmd2 = ''del '' + @SourcePath + @SourceFile
EXEC master..xp_cmdshell @cmd2

EXEC xp_cmdshell ''net use /d /y B:''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Day', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20150721, 
		@active_end_date=99991231, 
		@active_start_time=90000, 
		@active_end_time=235959
		--@schedule_uid=N'5af6f435-b7c6-4e24-b23a-710266742997'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - Credit Control MAJ suivi des dossiers]    Script Date: 07/06/2022 15:29:41 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 07/06/2022 15:29:41 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - Credit Control MAJ suivi des dossiers', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Mise à jour dans la base d''interface des données liées au suivi des dossiers Credit Control sur les baux. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Lancement]    Script Date: 07/06/2022 15:29:41 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Lancement', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Alimentation d''origine
INSERT INTO interface..CC_SUIVIDOSSIER
SELECT
GETDATE(), 
DATEPART(YEAR,GETDATE()), 
DATEPART(QUARTER,GETDATE()), 
DATEPART(MONTH,GETDATE()), 
DATEPART(WEEK,GETDATE()), 
BAIL.BAIL,
CASE WHEN DRESILIAT IS NULL THEN ''N''
	WHEN DRESILIAT > GetDate() THEN ''N'' 
	ELSE ''O'' END,
BAIL.DRESILIAT,
NULL,
NULL
FROM gagi_prod..BAIL
 

UPDATE interface..CC_SUIVIDOSSIER
SET 
ENCOURS=
(SELECT SUM(ISNULL(FACTG.TTC,0)-ISNULL(FACTG.REGLE,0)) FROM gagi_prod..FACTG
 WHERE interface..CC_SUIVIDOSSIER.LEASE=FACTG.BAIL AND FACTG.DEXIGIBLE <= GETDATE()
 AND FACTG.FACTURE IS NOT NULL GROUP BY FACTG.BAIL),
STATUS=(SELECT 
SYSUSEAFFECT.TAFFVALUE
FROM 
gagi_prod..SYSUSEFIELD, gagi_prod..SYSUSEFIELDVALUE, gagi_prod..SYSUSEAFFECT
WHERE 
SYSUSEFIELD.TFICHE=''BAIL'' AND
SYSUSEFIELD.NFIELDID=1 AND

SYSUSEFIELD.TFICHE=SYSUSEFIELDVALUE.TFICHE AND
SYSUSEFIELD.NFIELDID=SYSUSEFIELDVALUE.NFIELDID AND

SYSUSEAFFECT.TFICHE=SYSUSEFIELDVALUE.TFICHE AND
SYSUSEAFFECT.NFIELDID=SYSUSEFIELDVALUE.NFIELDID AND
SYSUSEAFFECT.TAFFVALUE=SYSUSEFIELDVALUE.TLIBELLE AND

SYSUSEAFFECT.TAFFCODE=interface..CC_SUIVIDOSSIER.LEASE)

WHERE CONVERT(varchar(10), GETDATE(), 103)=CONVERT(varchar(10), interface..CC_SUIVIDOSSIER.EXTRACT, 103)

', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Hebdo', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100907, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959
		--@schedule_uid=N'be507391-e0ae-4d5c-81c3-8016bc6cfdd0'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - Credit Control MAJ suivi des dossiers Mensuel]    Script Date: 07/06/2022 15:29:41 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 07/06/2022 15:29:41 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - Credit Control MAJ suivi des dossiers Mensuel', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Mise à jour dans la base d''interface des données liées au suivi des dossiers Credit Control sur les baux. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Lancement]    Script Date: 07/06/2022 15:29:41 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Lancement', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Alimentation d''origine
-- Etape 1 : on insert dans l''infocentre l''ensemble des baux.
INSERT INTO interface..CC_SUIVIDOSSIER_MONTH
SELECT
GETDATE(), 
DATEPART(YEAR,GETDATE()), 
DATEPART(QUARTER,GETDATE()), 
DATEPART(MONTH,GETDATE()), 
DATEPART(WEEK,GETDATE()), 
BAIL.BAIL,
CASE WHEN DRESILIAT IS NULL THEN ''N''
	WHEN DRESILIAT > GetDate() THEN ''N'' 
	ELSE ''O'' END,
BAIL.DRESILIAT,
NULL,
NULL
FROM gagi_prod..BAIL
 
-- Etape 2 : Mise à jour de l''encours pour les dossiers.
UPDATE interface..CC_SUIVIDOSSIER_MONTH
SET 
ENCOURS=
(SELECT SUM(ISNULL(FACTG.TTC,0)-ISNULL(FACTG.REGLE,0)) FROM gagi_prod..FACTG
 WHERE interface..CC_SUIVIDOSSIER_MONTH.LEASE=FACTG.BAIL AND FACTG.DEXIGIBLE <= GETDATE()
 AND FACTG.FACTURE IS NOT NULL GROUP BY FACTG.BAIL),

STATUS=(SELECT 
SYSUSEAFFECT.TAFFVALUE
FROM 
gagi_prod..SYSUSEFIELD, gagi_prod..SYSUSEFIELDVALUE, gagi_prod..SYSUSEAFFECT
WHERE 
SYSUSEFIELD.TFICHE=''BAIL'' AND
SYSUSEFIELD.NFIELDID=1 AND

SYSUSEFIELD.TFICHE=SYSUSEFIELDVALUE.TFICHE AND
SYSUSEFIELD.NFIELDID=SYSUSEFIELDVALUE.NFIELDID AND

SYSUSEAFFECT.TFICHE=SYSUSEFIELDVALUE.TFICHE AND
SYSUSEAFFECT.NFIELDID=SYSUSEFIELDVALUE.NFIELDID AND
SYSUSEAFFECT.TAFFVALUE=SYSUSEFIELDVALUE.TLIBELLE AND

SYSUSEAFFECT.TAFFCODE=interface..CC_SUIVIDOSSIER_MONTH.LEASE)

WHERE CONVERT(varchar(10), GETDATE(), 103)=CONVERT(varchar(10), 
interface..CC_SUIVIDOSSIER_MONTH.EXTRACT, 103)', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Hebdo', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20100907, 
		@active_end_date=99991231, 
		@active_start_time=50000, 
		@active_end_time=235959
		--@schedule_uid=N'5fe4029c-554f-4e22-bc9b-81f92e90e3eb'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD Interface - Credit Control Surface par Nature Mensuel]    Script Date: 07/06/2022 15:29:41 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:41 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD Interface - Credit Control Surface par Nature Mensuel', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01.30.89.30.43', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Mise à jour des données]    Script Date: 07/06/2022 15:29:41 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Mise à jour des données', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE @dte_extract datetime;
SET @dte_extract = GetDate();

SELECT * INTO #TMP_PROP_NATURE_SURFACE FROM
(SELECT 
 @dte_extract as [Date],
 PTE.PROPRIETE as [Code_Propriété],
 PTE.LIBELLE as [Lib_Propriété],
 PNAT.CNATURE as [Lot_Nature],
 CASE LAF.CAFFECT 
	WHEN ''V'' THEN SUM(ISNULL(LAF.NSURFACEAFF,0))
	ELSE 0 END as [Surface_Vacante],
 CASE LAF.CAFFECT 
	WHEN ''L'' THEN SUM(ISNULL(LAF.NSURFACEAFF,0))
	ELSE 0 END as [Surface_Louée],
 SUM(ISNULL(LAF.NSURFACEAFF,0)) [Surface_Totale]
	FROM gagi_prod..LAFFECT LAF
		INNER JOIN gagi_prod..LOT ON LAF.IDPROPRIETE=LOT.PROPRIETE AND LAF.IDLOT=LOT.LOT
		INNER JOIN gagi_prod..PROPRIET PTE ON LAF.IDPROPRIETE=PTE.PROPRIETE
		INNER JOIN gagi_prod..PNATURE PNAT ON LOT.SURFACE=PNAT.NATURE
	WHERE 
		LAF.CAFFECT IN (''L'', ''V'') AND LAF.DDEBUT <= @dte_extract AND (LAF.DFIN >= @dte_extract OR LAF.DFIN IS NULL)
	GROUP BY PTE.PROPRIETE, PTE.LIBELLE, PNAT.CNATURE, LAF.CAFFECT
	) as [TMP_Surface]

INSERT INTO PROP_NATURE_SURFACE 
SELECT Date, Code_Propriété, Lib_Propriété, Lot_Nature, SUM(Surface_Vacante) as [Surface_Vacante], SUM(Surface_Louée) as [Surface_Louée], SUM(Surface_Totale) as [Surface_Totale] 
	FROM #TMP_PROP_NATURE_SURFACE 
	GROUP BY Date, Code_Propriété, Lib_Propriété, Lot_Nature;

DROP TABLE #TMP_PROP_NATURE_SURFACE', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Mensuel', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20151201, 
		@active_end_date=99991231, 
		@active_start_time=100, 
		@active_end_time=235959
		--@schedule_uid=N'b455071c-9656-4f96-819b-af543c53f76e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - MAJ EtatLoc]    Script Date: 07/06/2022 15:29:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 07/06/2022 15:29:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - MAJ EtatLoc', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Alimentation de la table PRE_ETATLOC pour DataDistribution. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step_EtatLoc]    Script Date: 07/06/2022 15:29:42 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step_EtatLoc', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'set ANSI_NULLS ON
set QUOTED_IDENTIFIER ON
go

SET DATEFORMAT DMY 
declare @datein_dt datetime
declare @datein_c char(10)
declare @EXERCICE char(4)
declare @MOIS char(2)
declare @QUARTER char(1)

-- calcul du premier jour du mois courant
	select @datein_c=''01/''+right(''00''+RTRIM(cast(month(getdate()) as char (2))),2) +''/''+cast(year(getdate()) as char (4)) 
	--select @datein_c=''01/11/2010''
	-- on retrouve le dernier jour du mois précédent
	select @datein_dt=cast(@datein_c as datetime) - 1
	select @EXERCICE=cast(YEAR(@datein_dt) as char(4))
	select @MOIS=cast(MONTH(@datein_dt) as char(2))
	select @QUARTER=cast(DATEPART(QUARTER,@datein_dt) as char(1))

INSERT INTO interface..PRE_ETATLOC 
SELECT @EXERCICE as EXERCICE, @MOIS as MOIS, @QUARTER as [QUARTER], ''LOUE'' as compute_lot_state,   
			LOCAT.NOM,   
         BAIL.BAIL,   
         REPLACE(LOT.LOT,''E-'',''E_''),   
         ISNULL(LAFFECT.NSURFACEAFF,0),   
         BAIL.DEFFET,   
         (SELECT MIN(RESIL.DRESIL) FROM gagi_prod..RESIL WHERE RESIL.BAIL=BAIL.BAIL AND RESIL.DRESIL>=DATEADD(month,BAIL.DPREAVIS,@datein_dt)) AS compute_next_break,   
         BAIL.INDICEREF,   
         NULL,--INDICE_a.VALEUR,   
         TOTECHFIN.IACTUEL as bail_indiceact,   
			(SELECT MAX(INDICE.VALEUR)	
				FROM gagi_prod..ECHFIN, gagi_prod..INDICE 
				WHERE 
				( BAIL.IDPTYPINDICE = INDICE.IDPTYPINDICE OR BAIL.IDPTYPINDICE IS NULL ) 
				AND (ECHFIN.IACTUEL = INDICE.CODEIND OR ECHFIN.IACTUEL IS NULL)
				AND ECHFIN.PROPRIETE = PROPRIET.PROPRIETE AND ECHFIN.BAIL = BAIL.BAIL 
				AND ECHFIN.EVENEMENT IN ( ''019'',''020'',''022'',''023'',''024'',''025'',''026'',''027'',''028'',''029'',''030'',''031'',''032'',''034'',''035'' ) 
				AND (ECHFIN.DDEBUT <= @datein_dt AND ECHFIN.DFIN >= @datein_dt )) as INDICE_b_VALEUR,            
         TOTECHFIN.MANNUEL as compute_echfin_mannual,   
         PNATURE.UNITE,   
         PDUREE.CDUREE,   
         (SELECT MIN(ECHFIN.DANNIV) FROM gagi_prod..ECHFIN WHERE ECHFIN.BAIL = BAIL.BAIL AND ECHFIN.EVENEMENT IN ( ''020'' ) AND ECHFIN.DANNIV>=@datein_dt ) as compute_drevision,   
         PROPRIET.LIBELLE,   
         PROPRIET.POA_ADD1,   
         PROPRIET.POA_ADD2,   
         PROPRIET.POA_ADD3,   
         PROPRIET.POA_CP,   
         PROPRIET.POA_VILLE,
			PNATURE.CNATURE,
			PROPRIET.PROPRIETE  ,
			ISNULL(LAFFECT.NSURFACEAFF*ISNULL(PROPNATU.PRIX,0),0) AS compute_rental_value,
			PROPINFO.APRIXNET,
			NULL, --PNATURE_PROPRIET.CNATURE,
			LOT.SURFACE,
			PROPRIET.NATLOCAUX,
			PROPRIO.NOM,
			ISNULL(PROPNATU.PRIX,0) as compute_rental_price,
			BAIL.DRESILIAT,
			LOCAT.RCS,
(SELECT COUNT(DISTINCT LAFFECT.IDLOT) FROM gagi_prod..LAFFECT, gagi_prod..LOT 
WHERE 
LOT.SURFACE <> 20 AND
LAFFECT.IDLOT=LOT.LOT AND
LAFFECT.IDPROPRIETE=LOT.PROPRIETE 
AND LAFFECT.IDPROPRIETE=PROPRIET.PROPRIETE AND LAFFECT.IDBAIL=BAIL.BAIL 
AND ( ( LAFFECT.CAFFECT = ''L'' ) AND ( LAFFECT.DDEBUT <= @datein_dt ) 
AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt ) ) ) as compute_nb_lots,

			BAIL.DFINBAIL,
			BAIL.DPREAVIS,
			BAIL.PARKINGINT,
			BAIL.PARKINGEXT,
			LOT.ESCALIER,
			(SELECT GTETLIEU.GTDATE FROM gagi_prod..GTETLIEU WHERE GTETLIEU.BAIL = BAIL.BAIL AND GTETLIEU.TETAT=''E'' ) as compute_edl,
			(SELECT SUM(CASE ISNULL(ECHFIN.MANNUEL,0) WHEN 0 THEN ECHFIN.MACTUEL ELSE ECHFIN.MANNUEL END) FROM gagi_prod..ECHFIN WHERE ECHFIN.PROPRIETE = PROPRIET.PROPRIETE AND ECHFIN.BAIL = BAIL.BAIL AND EXISTS(SELECT * FROM gagi_prod..EVENT WHERE EVENT.EVENEMENT=ECHFIN.EVENEMENT AND EVENT.CTYPE=''DG'') AND ECHFIN.DECHFIN=(SELECT MAX(ECHFIN2.DECHFIN) FROM gagi_prod..ECHFIN ECHFIN2 WHERE ECHFIN.PROPRIETE = ECHFIN2.PROPRIETE AND ECHFIN.BAIL = ECHFIN2.BAIL AND EXISTS(SELECT * FROM gagi_prod..EVENT WHERE EVENT.EVENEMENT=ECHFIN2.EVENEMENT AND EVENT.CTYPE=''DG'') AND ECHFIN2.DECHFIN<=@datein_dt) ) as compute_dg_annual,
			BAIL.CAUTBREV,
			PNATURE.UNITE,
			(SELECT SUM(ECHFIN.MANNUEL) FROM gagi_prod..ECHFIN WHERE ECHFIN.PROPRIETE = PROPRIET.PROPRIETE AND ECHFIN.BAIL = BAIL.BAIL AND ECHFIN.EVENEMENT IN ( ''021'') AND ( ECHFIN.DDEBUT <= @datein_dt AND ECHFIN.DFIN >= @datein_dt ) ) as compute_rentfree,
			(SELECT MAX(ECHFIN.DFIN) FROM gagi_prod..ECHFIN WHERE ECHFIN.PROPRIETE = PROPRIET.PROPRIETE AND ECHFIN.BAIL = BAIL.BAIL AND ECHFIN.EVENEMENT IN ( ''021'') AND ECHFIN.DFIN >= @datein_dt) as compute_rentfree_dfin,
			PROPINFO.APRIXFRAIS,
			PROPINFO.APRIXHON,
			PROPINFO.APRIXDROIT
    FROM gagi_prod..BAIL,   
         gagi_prod..LOCAT,   
         gagi_prod..LAFFECT,   
         gagi_prod..LOT,   
         gagi_prod..PNATURE,   
			gagi_prod..PROPNATU ,
         --gagi_prod..INDICE INDICE_a,   
         gagi_prod..PDUREE,   
         gagi_prod..PROPRIET,
         gagi_prod..PROPINFO,
			--gagi_prod..PNATURE PNATURE_PROPRIET,
			gagi_prod..INDIVIS,
			gagi_prod..PROPRIO,
			(SELECT ECHFIN.PROPRIETE, ECHFIN.BAIL, MAX(ECHFIN.IACTUEL) AS IACTUEL, SUM(ECHFIN.MANNUEL) AS MANNUEL FROM gagi_prod..ECHFIN WHERE ECHFIN.EVENEMENT IN ( ''019'',''020'',''022'',''023'',''024'',''025'',''026'',''027'',''028'',''029'',''030'',''031'',''032'',''034'',''035'' ,''036'',''037'',''070'',''071'',''072'',''073'',''074'',''077'',''078'') AND ( ECHFIN.DDEBUT <= @datein_dt AND ECHFIN.DFIN >= @datein_dt ) GROUP BY ECHFIN.PROPRIETE, ECHFIN.BAIL) TOTECHFIN
   WHERE --BAIL.BAIL=''00003926'' AND
			--( BAIL.INDICEREF = INDICE_a.CODEIND OR BAIL.INDICEREF IS NULL) and  
			( PROPRIET.PROPRIETE = PROPINFO.IDPROPRIETE OR PROPRIET.PROPRIETE IS NULL) AND
			--( BAIL.IDPTYPINDICE = INDICE_a.IDPTYPINDICE OR BAIL.IDPTYPINDICE IS NULL) AND
         ( BAIL.IDLOCAT = LOCAT.IDLOCAT ) and  
         ( LAFFECT.IDPROPRIETE = LOT.PROPRIETE ) and  
         ( LAFFECT.IDLOT = LOT.LOT ) and  
         ( LOT.SURFACE = PNATURE.NATURE ) and  
         ( BAIL.BAIL = LAFFECT.IDBAIL ) and  
         ( BAIL.DUREELIB = PDUREE.DUREE ) and  
         ( BAIL.PROPRIETE = PROPRIET.PROPRIETE ) and
			((TOTECHFIN.PROPRIETE = PROPRIET.PROPRIETE OR TOTECHFIN.PROPRIETE IS NULL) AND (TOTECHFIN.BAIL = BAIL.BAIL OR TOTECHFIN.BAIL IS NULL) ) AND 
         ( ( LAFFECT.CAFFECT = ''L'' ) AND  
         ( LAFFECT.DDEBUT <= @datein_dt ) AND  
         (LAFFECT.DFIN is Null OR  
         LAFFECT.DFIN >= @datein_dt) ) AND /*(PNATURE_PROPRIET.NATURE = PROPRIET.NATLOCAUX OR PROPRIET.NATLOCAUX IS NULL)AND*/
			LOT.SURFACE <> 20 AND
			INDIVIS.PROPRIETE=PROPRIET.PROPRIETE AND PROPRIO.PROPRIO=INDIVIS.PROPRIO and (PROPNATU.NATURE=LOT.SURFACE OR PROPNATU.NATURE IS NULL) AND (PROPNATU.PROPRIETE=PROPRIET.PROPRIETE OR PROPNATU.PROPRIETE IS NULL) AND
			PROPRIET.PROPRIETE LIKE ''%'' AND
			EXISTS( SELECT * FROM gagi_prod..INDIVIS WHERE INDIVIS.PROPRIETE=PROPRIET.PROPRIETE AND INDIVIS.PROPRIO LIKE ''%'') AND
			(	( EXISTS( SELECT * FROM gagi_prod..LAFFECT, gagi_prod..LOT WHERE LOT.PROPRIETE=PROPRIET.PROPRIETE AND LOT.PROPRIETE=LAFFECT.IDPROPRIETE AND LOT.LOT=LAFFECT.IDLOT AND ( LAFFECT.DDEBUT <= @datein_dt ) AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt ) AND LOT.SURFACE IN (4,5) AND LAFFECT.CAFFECT=''L'' AND LAFFECT.IDBAIL=BAIL.BAIL) AND
						EXISTS( SELECT * FROM gagi_prod..LAFFECT, gagi_prod..LOT WHERE LOT.PROPRIETE=PROPRIET.PROPRIETE AND LOT.PROPRIETE=LAFFECT.IDPROPRIETE AND LOT.LOT=LAFFECT.IDLOT AND ( LAFFECT.DDEBUT <= @datein_dt ) AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt )  AND LAFFECT.CAFFECT=''L'' AND LAFFECT.IDBAIL=BAIL.BAIL) ) OR
				( EXISTS( SELECT * FROM gagi_prod..LAFFECT, gagi_prod..LOT WHERE LOT.PROPRIETE=PROPRIET.PROPRIETE AND LOT.PROPRIETE=LAFFECT.IDPROPRIETE AND LOT.LOT=LAFFECT.IDLOT AND ( LAFFECT.DDEBUT <= @datein_dt ) AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt ) AND LOT.SURFACE IN (4,5) AND LAFFECT.CAFFECT=''L'' AND LAFFECT.IDBAIL=BAIL.BAIL) AND
						NOT EXISTS( SELECT * FROM gagi_prod..LAFFECT, gagi_prod..LOT WHERE LOT.PROPRIETE=PROPRIET.PROPRIETE AND LOT.PROPRIETE=LAFFECT.IDPROPRIETE AND LOT.LOT=LAFFECT.IDLOT AND ( LAFFECT.DDEBUT <= @datein_dt ) AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt )  AND LAFFECT.CAFFECT=''L'' AND LAFFECT.IDBAIL=BAIL.BAIL) ) OR
				( NOT EXISTS( SELECT * FROM gagi_prod..LAFFECT, gagi_prod..LOT WHERE LOT.PROPRIETE=PROPRIET.PROPRIETE AND LOT.PROPRIETE=LAFFECT.IDPROPRIETE AND LOT.LOT=LAFFECT.IDLOT AND ( LAFFECT.DDEBUT <= @datein_dt ) AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt ) AND LOT.SURFACE IN (4,5) AND LAFFECT.CAFFECT=''L'' AND LAFFECT.IDBAIL=BAIL.BAIL) AND
						EXISTS( SELECT * FROM gagi_prod..LAFFECT, gagi_prod..LOT WHERE LOT.PROPRIETE=PROPRIET.PROPRIETE AND LOT.PROPRIETE=LAFFECT.IDPROPRIETE AND LOT.LOT=LAFFECT.IDLOT AND ( LAFFECT.DDEBUT <= @datein_dt ) AND ( LAFFECT.DFIN is Null OR LAFFECT.DFIN >= @datein_dt )  AND LAFFECT.CAFFECT=''L'' AND LAFFECT.IDBAIL=BAIL.BAIL) ) )
UNION
SELECT @EXERCICE as EXERCICE, @MOIS as MOIS, @QUARTER as [QUARTER], ''VACA'' as compute_lot_state,   
			LEFT(''VACANT''+ISNULL((SELECT TOP 1 '' (Ex '' + RTRIM(LOCAT.NOM) + '')'' FROM gagi_prod..LOCAT, gagi_prod..BAIL, gagi_prod..LAFFECT WHERE LAFFECT.IDBAIL=BAIL.BAIL AND LAFFECT.CAFFECT=''L'' AND LAFFECT.DFIN<@datein_dt AND BAIL.IDLOCAT=LOCAT.IDLOCAT AND LAFFECT.IDPROPRIETE=PROPRIET.PROPRIETE AND LAFFECT.IDLOT=LOT.LOT AND LAFFECT.DDEBUT=(SELECT MAX(L2.DDEBUT) FROM gagi_prod..LAFFECT L2 WHERE LAFFECT.IDPROPRIETE=L2.IDPROPRIETE AND LAFFECT.IDLOT=L2.IDLOT AND L2.CAFFECT=''L'' AND L2.DFIN<@datein_dt)),''''),30) as LOCAT_NOM,
         ''VACANT'' as BAIL_BAIL ,   
         LOT.LOT,   
	ISNULL(LAFFECT.NSURFACEAFF,0),
         PROPRIET.ADATE as BAIL_DEFFET,   
         0 as compute_next_break,   
         '''' as BAIL_INDICEREF ,   
         0 as INDICE_a_VALEUR,   
         '''' as BAIL_INDICEACT ,   
         0 as INDICE_b_VALEUR,   
         0 as compute_echfin_mannual,   
         PNATURE.UNITE  ,
			'''' as PDUREE_CDUREE,
         PROPRIET.ADATE as compute_drevision,    
         PROPRIET.LIBELLE,   
         PROPRIET.POA_ADD1,   
         PROPRIET.POA_ADD2,   
         PROPRIET.POA_ADD3,   
         PROPRIET.POA_CP,   
         PROPRIET.POA_VILLE,
			PNATURE.CNATURE,
			PROPRIET.PROPRIETE  ,
			ISNULL(LAFFECT.NSURFACEAFF*ISNULL(PROPNATU.PRIX,0),0) AS compute_rental_value,
			PROPINFO.APRIXNET,
			NULL, --PNATURE_PROPRIET.CNATURE,
			LOT.SURFACE,
			PROPRIET.NATLOCAUX,
			PROPRIO.NOM,
			ISNULL(PROPNATU.PRIX,0) as compute_rental_price,
         PROPRIET.ADATE as BAIL_DRESILIAT,
			'''' as LOCAT_RCS,
			0 as compute_nb_lots,
			PROPRIET.ADATE as BAIL_DFINBAIL,
			0 as BAIL_DPREAVIS,
			0 as BAIL_PARKINGINT,
			0 as BAIL_PARKINGEXT,
			LOT.ESCALIER,
			PROPRIET.ADATE as compute_edl,
			0 as compute_dg_annual,
			'''' as BAIL_CAUTBREV,
			PNATURE.UNITE,
			0 as compute_rentfree,
			PROPRIET.ADATE as compute_rentfree_dfin,
			PROPINFO.APRIXFRAIS,
			PROPINFO.APRIXHON,
			PROPINFO.APRIXDROIT
    FROM gagi_prod..LAFFECT,   
         gagi_prod..LOT,   
         gagi_prod..PROPRIET,   
         gagi_prod..PROPINFO,
         gagi_prod..PNATURE,
			gagi_prod..PROPNATU ,
			--gagi_prod..PNATURE PNATURE_PROPRIET,
			gagi_prod..INDIVIS, gagi_prod..PROPRIO
   WHERE ( PROPRIET.PROPRIETE = LAFFECT.IDPROPRIETE ) and  
         ( LOT.LOT = LAFFECT.IDLOT ) and  
			( PROPRIET.PROPRIETE= PROPINFO.IDPROPRIETE OR PROPRIET.PROPRIETE IS NULL ) AND
         ( LOT.PROPRIETE = PROPRIET.PROPRIETE ) and  
         ( LOT.SURFACE = PNATURE.NATURE) and  
			( LAFFECT.CAFFECT = ''V'' ) and  
         ( LAFFECT.DDEBUT <= @datein_dt  ) and   
         ( LAFFECT.DFIN >= @datein_dt OR LAFFECT.DFIN is NULL) AND
			PNATURE.UNITE<>2 and (PROPNATU.NATURE=LOT.SURFACE OR PROPNATU.NATURE IS NULL) AND (PROPNATU.PROPRIETE=PROPRIET.PROPRIETE OR PROPRIET.PROPRIETE IS NULL) AND
			LOT.SURFACE <> 20 AND
			/*(PNATURE_PROPRIET.NATURE=PROPRIET.NATLOCAUX OR PROPRIET.NATLOCAUX  IS NULL) AND*/
			INDIVIS.PROPRIETE=PROPRIET.PROPRIETE AND PROPRIO.PROPRIO=INDIVIS.PROPRIO AND
			PROPRIET.PROPRIETE LIKE ''%'' 
			--AND EXISTS( SELECT * FROM gagi_prod..INDIVIS WHERE INDIVIS.PROPRIETE=PROPRIET.PROPRIETE AND INDIVIS.PROPRIO LIKE ''%'');', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Schedule_EtatLoc', 
		@enabled=1, 
		@freq_type=16, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20080529, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959
		--@schedule_uid=N'14a19f24-6d69-482f-b14a-92d313f796cf'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - MAJ REFACTIF]    Script Date: 07/06/2022 15:29:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - MAJ REFACTIF', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [MAJ_REFACTIF]    Script Date: 07/06/2022 15:29:42 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'MAJ_REFACTIF', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'UPDATE interface.dbo.REFACTIFS
SET ID_SOCIETE=(SELECT CGESTION FROM gagi_prod..PROPRIET WHERE PROPRIET.PROPRIETE=ID_PROPRIETE)
UPDATE interface.dbo.REFACTIFS
SET ID_SOCCOURT=(SELECT SOCCOURT FROM gagi_prod..SOCIETE WHERE SOCIETE.SOCCODE=ID_SOCIETE)
UPDATE interface.dbo.REFACTIFS
SET ID_FOND=(SELECT IMMEUBLE.GROUPE FROM gagi_prod..IMMEUBLE,gagi_prod..PROPRIET 
WHERE PROPRIET.PROPRIETE=ID_PROPRIETE AND PROPRIET.IMMEUBLE=IMMEUBLE.IMMEUBLE)
', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'10Min', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140410, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
		--@schedule_uid=N'ebd2ecba-f686-43f2-9a12-53b9145bbc06'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - MAJ Surface]    Script Date: 07/06/2022 15:29:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 07/06/2022 15:29:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - MAJ Surface', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Alimentation de la table ACTIFS (Gestion des surfaces) pour DataDistribution. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Gestion des surfaces pour COGNOS]    Script Date: 07/06/2022 15:29:42 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Gestion des surfaces pour COGNOS', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Surface utile
UPDATE interface..ACTIFS SET SURFACE_U=
(SELECT SUM(NSURFACEAFF) FROM gagi_prod..LAFFECT, gagi_prod..LOT
WHERE 
DDEBUT<=GetDate() AND (DFIN>=GetDate() OR DFIN IS NULL) 
AND CAFFECT NOT IN (''I'',''E'') 
AND LAFFECT.IDLOT = LOT.LOT AND LOT.PROPRIETE = LAFFECT.IDPROPRIETE
AND (
	(LOT.SURFACE NOT IN (SELECT PNATURE.NATURE FROM
	gagi_prod..PNATURE WHERE UNITE=2)) AND
	LOT.SURFACE<>4
	)
AND LAFFECT.IDPROPRIETE=interface..ACTIFS.ID_PROPRIETE 
GROUP BY LAFFECT.IDPROPRIETE)


UPDATE interface..ACTIFS SET SURFACE_UU=
(SELECT SUM(NSURFACEAFF) FROM gagi_prod..LAFFECT, gagi_prod..LOT
WHERE 
DDEBUT<=GetDate() AND (DFIN>=GetDate() OR DFIN IS NULL) 
AND CAFFECT NOT IN (''I'',''E'') 
AND LAFFECT.IDLOT = LOT.LOT AND LOT.PROPRIETE = LAFFECT.IDPROPRIETE
AND (
	(LOT.SURFACE IN (SELECT PNATURE.NATURE FROM
	gagi_prod..PNATURE WHERE UNITE=2)) AND
	LOT.SURFACE<>4
	)
AND LAFFECT.IDPROPRIETE=interface..ACTIFS.ID_PROPRIETE 
GROUP BY LAFFECT.IDPROPRIETE)


UPDATE interface..ACTIFS SET SURFACE_UT=
(SELECT SUM(NSURFACEAFF) FROM gagi_prod..LAFFECT, gagi_prod..LOT
WHERE 
DDEBUT<=GetDate() AND (DFIN>=GetDate() OR DFIN IS NULL) 
AND CAFFECT NOT IN (''I'',''E'') 
AND LAFFECT.IDLOT = LOT.LOT AND LOT.PROPRIETE = LAFFECT.IDPROPRIETE
AND LOT.SURFACE=4
AND LAFFECT.IDPROPRIETE=interface..ACTIFS.ID_PROPRIETE 
GROUP BY LAFFECT.IDPROPRIETE)

-- Surface utile
UPDATE interface..ACTIFS SET SURFACE_L=
(SELECT SUM(NSURFACEAFF) FROM gagi_prod..LAFFECT, gagi_prod..LOT
WHERE 
DDEBUT<=GetDate() AND (DFIN>=GetDate() OR DFIN IS NULL) 
AND CAFFECT = ''L'' 
AND LAFFECT.IDLOT = LOT.LOT AND LOT.PROPRIETE = LAFFECT.IDPROPRIETE
AND (
	(LOT.SURFACE NOT IN (SELECT PNATURE.NATURE FROM
	gagi_prod..PNATURE WHERE UNITE=2)) AND
	LOT.SURFACE<>4
	)
AND LAFFECT.IDPROPRIETE=interface..ACTIFS.ID_PROPRIETE 
GROUP BY LAFFECT.IDPROPRIETE)


UPDATE interface..ACTIFS SET SURFACE_LU=
(SELECT SUM(NSURFACEAFF) FROM gagi_prod..LAFFECT, gagi_prod..LOT
WHERE 
DDEBUT<=GetDate() AND (DFIN>=GetDate() OR DFIN IS NULL) 
AND CAFFECT =''L'' 
AND LAFFECT.IDLOT = LOT.LOT AND LOT.PROPRIETE = LAFFECT.IDPROPRIETE
AND (
	(LOT.SURFACE IN (SELECT PNATURE.NATURE FROM
	gagi_prod..PNATURE WHERE UNITE=2)) AND
	LOT.SURFACE<>4
	)
AND LAFFECT.IDPROPRIETE=interface..ACTIFS.ID_PROPRIETE 
GROUP BY LAFFECT.IDPROPRIETE)


UPDATE interface..ACTIFS SET SURFACE_LT=
(SELECT SUM(NSURFACEAFF) FROM gagi_prod..LAFFECT, gagi_prod..LOT
WHERE 
DDEBUT<=GetDate() AND (DFIN>=GetDate() OR DFIN IS NULL) 
AND CAFFECT =''L'' 
AND LAFFECT.IDLOT = LOT.LOT AND LOT.PROPRIETE = LAFFECT.IDPROPRIETE
AND LOT.SURFACE=4
AND LAFFECT.IDPROPRIETE=interface..ACTIFS.ID_PROPRIETE 
GROUP BY LAFFECT.IDPROPRIETE)

UPDATE interface..ACTIFS SET TX_OCC=
ISNULL(
	(ISNULL(SURFACE_L,1))/
	ISNULL(SURFACE_U+1,1)
,0)



', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'DayToDay_Job', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20081021, 
		@active_end_date=99991231, 
		@active_start_time=43000, 
		@active_end_time=235959
		--@schedule_uid=N'5c524300-18fe-4200-8262-71911d22c7de'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - RegularisationCharges]    Script Date: 07/06/2022 15:29:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 07/06/2022 15:29:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - RegularisationCharges', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Alimentation de la table REGULCHARGE pour le service Comptabilité. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Lancement du traitement]    Script Date: 07/06/2022 15:29:42 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Lancement du traitement', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/* Etape 1 - Récupération de l''ensemble des données comptable */
-- Toutes sociétés sur 2005, 2006 & 2007 : 58 secondes
-- Aucun gain en variablisiant l''exercice
use interface
truncate table REGULCHARGE
insert into REGULCHARGE
	SELECT REFSOCIETE.ID_SOCIETE + '' '' + REFSOCIETE.LIBELLE, EXERCICE, 0, DATEPART(month,DTECRIT) as MOIS,
	ANALYT as PROPRIETE, '''', ''C'',
	ISNULL((SELECT SUM(DEBITS)-SUM(CREDITS) FROM BA_GLOBAL B WHERE NUM_COMPT IN (''614100'',''615100'',''616100'',''622621'',''622624'',''622611'') AND A.ANALYT=B.ANALYT AND A.EXERCICE=B.EXERCICE AND A.ID_SOCIETE=B.ID_SOCIETE AND MONTH(A.DTECRIT)=MONTH(B.DTECRIT)),0)as CHA_RECUP,
	ISNULL((SELECT SUM(DEBITS)-SUM(CREDITS) FROM BA_GLOBAL C WHERE NUM_COMPT IN (''614200'',''615200'',''616200'',''622622'') AND A.ANALYT=C.ANALYT AND A.EXERCICE=C.EXERCICE AND A.ID_SOCIETE=C.ID_SOCIETE AND MONTH(A.DTECRIT)=MONTH(C.DTECRIT)),0)as CHA_NRECUP,
	ISNULL((SELECT SUM(DEBITS)-SUM(CREDITS) FROM BA_GLOBAL D WHERE NUM_COMPT IN (''614300'',''615300'',''616300'',''622623'',''622625'') AND A.ANALYT=D.ANALYT AND A.EXERCICE=D.EXERCICE AND A.ID_SOCIETE=D.ID_SOCIETE AND MONTH(A.DTECRIT)=MONTH(D.DTECRIT)),0)as CHA_VACANT,
	0,
	0,
	0,
	0,
	ISNULL((SELECT SUM(CREDITS)-SUM(DEBITS) FROM BA_GLOBAL E WHERE NUM_COMPT IN (''708100'',''708200'') AND A.ANALYT=E.ANALYT AND A.EXERCICE=E.EXERCICE AND A.ID_SOCIETE=E.ID_SOCIETE AND MONTH(A.DTECRIT)=MONTH(E.DTECRIT)),0)as PDTTX, -- ,''708214'',''708215'',''708221''
	ISNULL((SELECT SUM(CREDITS)-SUM(DEBITS) FROM BA_GLOBAL F WHERE NUM_COMPT IN (''708210'',''708910'') AND A.ANALYT=F.ANALYT AND A.EXERCICE=F.EXERCICE AND A.ID_SOCIETE=F.ID_SOCIETE AND MONTH(A.DTECRIT)=MONTH(F.DTECRIT)),0)as PDTNTX, -- ,''708216''
	0,
	0,
	0,
	0
	FROM REFSOCIETE, BA_GLOBAL A
	WHERE 
	A.ID_SOCIETE=REFSOCIETE.ID_SOCCOURT AND
	LEN(ANALYT)>0 
	-- AND DTECRIT>=''01/01/2008'' AND DTECRIT<=''30/06/2008'' --EXERCICE>2004
	--	AND ID_SOCIETE=''03'' AND ANALYT=''770003''
	GROUP BY REFSOCIETE.ID_SOCIETE, A.ID_SOCIETE, REFSOCIETE.LIBELLE, EXERCICE, ANALYT,month(DTECRIT) --, DTECRIT
	ORDER BY A.ID_SOCIETE, ANALYT, EXERCICE--, DTECRIT

/* Etape 2 - Récupération des données charges issues de la gestion */
/* On incrémente l''année de la dépense pour être en cohérence avec la comptabilité */
use gagi_prod
insert into interface..REGULCHARGE
	SELECT SOCIETE.SOCCODE + '' '' + SOCIETE.SOCNOM, YEAR(DEPENSED.DDEBUT)+1 as EXERCICE, DATEPART(quarter,DEPENSED.DDEBUT) as QUARTER,
	1 as MOIS, DEPENSED.PROPRIETE, '''',''D'',
	0,0,0,0,SUM(DEPENSED.HT) AS RGD,0,0,0,0,0,0,0,0 
	FROM DEPENSED, DEPENSEG, INDIVIS, SOCIETE 
	WHERE 
	INDIVIS.PROPRIO=SOCIETE.SOCCODE AND
	INDIVIS.PROPRIETE=DEPENSED.PROPRIETE AND
 --DEPENSEG.PROPRIETE=''780007'' AND
	DEPENSED.SCPI=DEPENSEG.SCPI AND
	DEPENSED.REFERENCE=DEPENSEG.REFERENCE AND
	DEPENSEG.STATUT=''C'' AND 
	DEPENSED.CCHARGE IN (SELECT CCHARGE FROM PCCHARGE WHERE CTYPE IS NULL OR CTYPE=''1'' OR CTYPE=''TA'')
	AND DEPENSED.TYPEREFACT IS NULL
	AND DEPENSED.DREGULCOMPTA IS NOT NULL
	GROUP BY SOCIETE.SOCCODE, SOCIETE.SOCNOM, DEPENSED.PROPRIETE, DEPENSED.DDEBUT

/* Etape 2 bis - Récupération des données charges NR issues de la gestion */
/* On incrémente l''année de la dépense pour être en cohérence avec la comptabilité */
use gagi_prod
insert into interface..REGULCHARGE
SELECT SOCIETE.SOCCODE + '' '' + SOCIETE.SOCNOM, YEAR(DEPENSED.DDEBUT)+1 as EXERCICE, DATEPART(quarter,DEPENSED.DDEBUT) as QUARTER,
	1 as MOIS, DEPENSED.PROPRIETE, '''',''D'',
	0,0,0,0,0,SUM(DEPENSED.HT) AS RGD_NR,0,0,0,0,0,0,0 
	FROM DEPENSED, DEPENSEG, INDIVIS, SOCIETE 
	WHERE 
	INDIVIS.PROPRIO=SOCIETE.SOCCODE AND
	INDIVIS.PROPRIETE=DEPENSED.PROPRIETE AND
	--DEPENSED.PROPRIETE=''130008'' AND
	DEPENSED.SCPI=DEPENSEG.SCPI AND
	DEPENSED.REFERENCE=DEPENSEG.REFERENCE AND
	DEPENSEG.STATUT=''C'' AND 
	(DEPENSED.CCHARGE IN (SELECT CCHARGE FROM PCCHARGE WHERE CTYPE=''2'') 
		AND DEPENSED.PDEPENSE<>''HONOSY'')
	AND DEPENSED.TYPEREFACT IS NULL
	AND DEPENSED.DREGULCOMPTA IS NOT NULL
	GROUP BY SOCIETE.SOCCODE, SOCIETE.SOCNOM, DEPENSED.PROPRIETE, DEPENSED.DDEBUT

/* Etape 3 - Récupération des données produits issues de la gestion */
use gagi_prod
insert into interface..REGULCHARGE
	SELECT SOCIETE.SOCCODE + '' '' + SOCIETE.SOCNOM, YEAR(FASESS.DECHEANCE)+1, DATEPART(quarter,FACTG.DECH) as QUARTER,
	1 as MOIS, BAIL.PROPRIETE,'''', ''P'',
	0,0,0,0,0,0,0,0,0,0,SUM(ISNULL(FACTD.HT,0))-ISNULL(FACTG.DONTTVA,0) AS RID,0,0
	FROM FACTD, FACTG, BAIL, INDIVIS, FASESS, PROPRIET , SOCIETE 
	WHERE 
	INDIVIS.PROPRIO=SOCIETE.SOCCODE AND
	INDIVIS.PROPRIETE=BAIL.PROPRIETE AND
	PROPRIET.PROPRIETE=BAIL.PROPRIETE AND
	FACTD.NSESSION IN (SELECT NSESSION FROM FASESS WHERE TYPESESS=''R'') AND
	FACTD.NSESSION=FASESS.NSESSION AND
	FACTG.NSESSION=FACTD.NSESSION AND
	FACTG.GROUPE=FACTD.GROUPE AND
	FACTG.LIGNEG=FACTD.LIGNEG AND 
	FACTG.BAIL=BAIL.BAIL AND
	FACTG.FACTURE IS NOT NULL AND
	FACTD.EVENEMENT IN (''RED'', ''RNS'')
	GROUP BY SOCIETE.SOCCODE, SOCIETE.SOCNOM, BAIL.PROPRIETE, FASESS.DECHEANCE, FACTG.DONTTVA, FACTG.DECH
	ORDER BY SOCIETE.SOCCODE, SOCIETE.SOCNOM, BAIL.PROPRIETE, FASESS.DECHEANCE

/* Etape 4 - Alimentation des libellés des propriétés */
UPDATE interface..REGULCHARGE SET LIBELLE=
(SELECT LIBELLE FROM gagi_prod..PROPRIET WHERE gagi_prod..PROPRIET.PROPRIETE=interface..REGULCHARGE.ID_PROPRIETE)', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Travail Quotidien', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20081024, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959
		--@schedule_uid=N'221ee075-2919-4b2e-a2c5-8a02d85d1786'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - Trace Log Erreur Compta]    Script Date: 07/06/2022 15:29:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - Trace Log Erreur Compta', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Alim_trace]    Script Date: 07/06/2022 15:29:42 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Alim_trace', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'TRUNCATE TABLE interface..trace_error_ba

DECLARE @table_name CHAR(10)
DECLARE @societe    CHAR(2)
DECLARE @ID_SOCIETE    CHAR(3)
DECLARE @annee      CHAR(4)
DECLARE Compta_Cursor CURSOR FOR SELECT name FROM dbo.sysobjects WHERE ( xtype = ''U'' ) AND ( name LIKE ''BA%'' ) AND  LEFT( name, 4) NOT IN(''BA_TPECR'', ''BAIL'', ''BANQ'',''BATI'' ) AND ( name <> ''BACOMP'' ) ORDER BY name ASC
            OPEN Compta_Cursor
            FETCH NEXT FROM Compta_Cursor INTO @table_name 
            WHILE @@FETCH_STATUS = 0
            BEGIN
		    SELECT @societe  = SUBSTRING(@table_name,3,2)
			SELECT @annee    = RIGHT(RTRIM(@table_name),4)
			SELECT @ID_SOCIETE = (SELECT SOCCODE FROM gagi_prod..SOCIETE WHERE SOCCOURT=@societe)
--	EXEC(''SELECT '''''' + @societe + '''''', '''''' + @annee + '''''', ((SELECT COUNT(1) FROM gagi_prod..''+@table_name+'')''+
--	''- (SELECT COUNT(1) FROM interface..BA_GLOBAL WHERE EXERCICE='''''' + @annee + '''''' AND ID_SOCIETE='''''' + @societe + '''''')) as Erreur FROM interface..RQT'')

	EXEC(''INSERT INTO interface..trace_error_ba SELECT ''''''+@table_name+'''''', CODEJOUR, PIECE, LIGNE, COUNT(1) FROM gagi_prod..''+@table_name+'' WHERE NOT EXISTS''+
	'' (SELECT * FROM interface..BA_GLOBAL WHERE EXERCICE ='''''' + @annee + '''''' AND ID_SOCIETE=''''''+ @societe + '''''' AND interface..BA_GLOBAL.CODEJOUR=gagi_prod.''+
	@table_name+''.CODEJOUR AND interface..BA_GLOBAL.PIECE=gagi_prod..''+@table_name+''.PIECE AND interface..BA_GLOBAL.LIGNE=gagi_prod..''+@table_name+''.LIGNE) GROUP BY CODEJOUR, PIECE, LIGNE HAVING COUNT(1)>0'')


             FETCH NEXT FROM Compta_Cursor INTO @table_name
             END
             CLOSE Compta_Cursor
             DEALLOCATE Compta_Cursor', 
		@database_name=N'gagi_prod', 
		@output_file_name=N'E:\bases\mssql\Data\MSSQL12.MSSQLSERVER\MSSQL\Log\compta_log.txt', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Day', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20140617, 
		@active_end_date=99991231, 
		@active_start_time=230000, 
		@active_end_time=235959
		--@schedule_uid=N'13781aba-7ac6-4467-a093-31b89374317c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - BDD interface - User Connect]    Script Date: 07/06/2022 15:29:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - BDD interface - User Connect', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Alimentation de la table des utilisateurs connectés. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [insertion]    Script Date: 07/06/2022 15:29:42 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'insertion', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use gagi_prod
insert into interface..user_connect 
SELECT hostname, program_name, nt_domain, nt_username, loginame, 
datepart(year,login_time) as Année,datepart(quarter,login_time) as Trimestre,datepart(month,login_time) as Mois, 
datepart(hour,login_time) as Heure, login_time
FROM master..sysprocesses 
WHERE dbid=db_id() AND program_name=''Prémiance''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'heure', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110706, 
		@active_end_date=99991231, 
		@active_start_time=120000, 
		@active_end_time=115959, 
		--@schedule_uid=N'e6d73e17-ec28-4b85-b370-f8b9be246626'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - DataDistribution Expired subscription clean up]    Script Date: 07/06/2022 15:29:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Subscription Cleanup]    Script Date: 07/06/2022 15:29:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Subscription Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Subscription Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - DataDistribution Expired subscription clean up', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Detects and removes expired subscriptions from published databases.', 
		@category_name=N'REPL-Subscription Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 07/06/2022 15:29:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sys.sp_expired_subscription_cleanup', 
		@server=N'PROSQL01', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=1, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20080418, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959
		--@schedule_uid=N'e4dc7f7e-a949-49d6-a702-40690c51ae7b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - DataDistribution Maintenance - Agent history clean up]    Script Date: 07/06/2022 15:29:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-History Cleanup]    Script Date: 07/06/2022 15:29:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-History Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-History Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - DataDistribution Maintenance - Agent history clean up', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Removes replication agent history from the distribution database.', 
		@category_name=N'REPL-History Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 07/06/2022 15:29:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_MShistory_cleanup @history_retention = 48', 
		@server=N'PROSQL01', 
		@database_name=N'DataDistribution', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110621, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
		--@schedule_uid=N'1be3344b-0e15-41b3-9530-aebf8bfabb36'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - Nettoyage Interface DEP_SNEDA]    Script Date: 07/06/2022 15:29:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - Nettoyage Interface DEP_SNEDA', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Nettoyage]    Script Date: 07/06/2022 15:29:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Nettoyage', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DELETE interface..DEP_SNEDA_GAGI WHERE DDEPENSE IS NULL
DELETE interface..DEP_SNEDA_GAGI_CONTRAT WHERE DDEPENSE IS NULL
DELETE interface..DEP_SNEDA_GAGI_TEST WHERE DDEPENSE IS NULL

DELETE interface_test..DEP_SNEDA_GAGI WHERE DDEPENSE IS NULL
DELETE interface_test..DEP_SNEDA_GAGI_CONTRAT WHERE DDEPENSE IS NULL
DELETE interface_test..DEP_SNEDA_GAGI_TEST WHERE DDEPENSE IS NULL', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Day', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20170407, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=225959, 
		--@schedule_uid=N'ce1e0347-8008-4cac-91d8-ae2b6b18fc06'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - Premiance - Comptabilité MAJ BA ETABL]    Script Date: 07/06/2022 15:29:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - Premiance - Comptabilité MAJ BA ETABL', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [ETABL]    Script Date: 07/06/2022 15:29:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'ETABL', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
DECLARE @table_name CHAR(10)
DECLARE @societe    CHAR(2)
DECLARE @annee      CHAR(4)
DECLARE Compta_Cursor CURSOR FOR SELECT name FROM dbo.sysobjects WHERE ( xtype = ''U'' ) AND ( name LIKE ''BA%'' ) AND  LEFT( name, 4) NOT IN(''BAIL'', ''BANQ'',''BATI'' ) AND ( name <> ''BACOMP'' ) ORDER BY name ASC
            OPEN Compta_Cursor
            FETCH NEXT FROM Compta_Cursor INTO @table_name 
            WHILE @@FETCH_STATUS = 0
            BEGIN
		    SELECT @societe  = SUBSTRING(@table_name,3,2)
			SELECT @annee    = RIGHT(RTRIM(@table_name),4)
	EXEC(

		--''INSERT INTO interface.dbo.BA_GLOBAL '' +
		''UPDATE '' +
		'' gagi_prod..'' + @table_name + '' SET ETABL=''''AUGM'''' WHERE ETABL IS NULL AND CODEJOUR<>''''RAN''''''

	 )
if @annee >= CAST(DATEPART(YEAR,GetDate())-1 as CHAR(4))
BEGIN
	EXEC(

		--''INSERT INTO interface.dbo.BA_GLOBAL '' +
		''UPDATE '' +
		'' gagi_prod..'' + @table_name + '' SET ETABL=NULL WHERE ETABL IS NOT NULL AND CODEJOUR=''''RAN''''''

	 )
END

 FETCH NEXT FROM Compta_Cursor INTO @table_name
 END
 CLOSE Compta_Cursor
DEALLOCATE Compta_Cursor	', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'2h', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20140410, 
		@active_end_date=99991231, 
		@active_start_time=90000, 
		@active_end_time=190000, 
		--@schedule_uid=N'285a8e22-e0c3-4676-b08f-2b1edf06985f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - Premiance - Tous Services MAJ Surface par Nature]    Script Date: 07/06/2022 15:29:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - Premiance - Tous Services MAJ Surface par Nature', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'http://amoconseil.myportal.fr/ticket/view/983. En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [MAJ]    Script Date: 07/06/2022 15:29:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'MAJ', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Mettre en Surface Utile dans la propriété la somme des lots (AFF / L + V) hors terrain et uniquement de type Surface (I.E. exclure les lots en Unités) => PROPRIET.SUTILE

UPDATE PROPRIET

SET SUTILE = 

ROUND((SELECT ROUND(ISNULL(SUM(ISNULL(LAF.NSURFACEAFF,0)),0),2) FROM LAFFECT LAF 

INNER JOIN LOT ON LAF.IDPROPRIETE=LOT.PROPRIETE AND LAF.IDLOT=LOT.LOT AND LOT.SURFACE NOT IN (4)

INNER JOIN PNATURE PNAT ON PNAT.NATURE=LOT.SURFACE AND PNAT.UNITE=1 

WHERE LAF.IDPROPRIETE=PROPRIET.PROPRIETE AND LAF.CAFFECT IN (''L'', ''V'')

AND LAF.DDEBUT <= GetDate() AND (LAF.DFIN >= GetDate() OR LAF.DFIN IS NULL)),2)
-- Mettre en Surface Terrain dans la propriété la somme des lots (AFF / L + V) uniquement terrain => MVALEUR DE PROPCARAC : SELECT IDPROPRIETE FROM PROPCARAC WHERE IDPCARACTERISTIQUE=1

UPDATE PROPCARAC

SET MVALEUR = 

ROUND((SELECT ROUND(ISNULL(SUM(ISNULL(LAF.NSURFACEAFF,0)),0),2) FROM LAFFECT LAF 

INNER JOIN LOT ON LAF.IDPROPRIETE=LOT.PROPRIETE AND LAF.IDLOT=LOT.LOT AND LOT.SURFACE = 4

INNER JOIN PNATURE PNAT ON PNAT.NATURE=LOT.SURFACE AND PNAT.UNITE=1 

WHERE LAF.IDPROPRIETE=PROPCARAC.IDPROPRIETE AND LAF.CAFFECT IN (''L'', ''V'')

AND LAF.DDEBUT <= GetDate() AND (LAF.DFIN >= GetDate() OR LAF.DFIN IS NULL)),2)

WHERE IDPCARACTERISTIQUE=1


-- Mettre en Surface Terrain dans la propriété la somme des lots (AFF / L + V) Totale => MVALEUR DE PROPCARAC : SELECT IDPROPRIETE FROM PROPCARAC WHERE IDPCARACTERISTIQUE=4

UPDATE PROPCARAC

SET MVALEUR = 

ROUND((SELECT ROUND(ISNULL(SUM(ISNULL(LAF.NSURFACEAFF,0)),0),2) FROM LAFFECT LAF 

INNER JOIN LOT ON LAF.IDPROPRIETE=LOT.PROPRIETE AND LAF.IDLOT=LOT.LOT --AND LOT.SURFACE = 4

INNER JOIN PNATURE PNAT ON PNAT.NATURE=LOT.SURFACE AND PNAT.UNITE=1 

WHERE LAF.IDPROPRIETE=PROPCARAC.IDPROPRIETE AND LAF.CAFFECT IN (''L'', ''V'')

AND LAF.DDEBUT <= GetDate() AND (LAF.DFIN >= GetDate() OR LAF.DFIN IS NULL)),2)

WHERE IDPCARACTERISTIQUE=4


-- Mettre en Nb Praking dans la propriété la somme des lots (AFF / L + V) où la famille de Taxe Bureau = Stationnement => MVALEUR DE PROPCARAC : SELECT * FROM PROPCARAC WHERE IDPCARACTERISTIQUE=7

UPDATE PROPCARAC

SET MVALEUR = 

ROUND((SELECT ROUND(ISNULL(SUM(ISNULL(LAF.NSURFACEAFF,0)),0),2) FROM LAFFECT LAF 

INNER JOIN LOT ON LAF.IDPROPRIETE=LOT.PROPRIETE AND LAF.IDLOT=LOT.LOT --AND LOT.SURFACE = 4

INNER JOIN PNATURE PNAT ON PNAT.NATURE=LOT.SURFACE AND PNAT.PFNATNUM=5 

WHERE LAF.IDPROPRIETE=PROPCARAC.IDPROPRIETE AND LAF.CAFFECT IN (''L'', ''V'')

AND LAF.DDEBUT <= GetDate() AND (LAF.DFIN >= GetDate() OR LAF.DFIN IS NULL)),2)

WHERE IDPCARACTERISTIQUE=7', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'day 4X', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=63, 
		@freq_subday_type=8, 
		@freq_subday_interval=4, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20150605, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959
		--@schedule_uid=N'3aaab8bd-f05c-4d31-9379-7c7f6e4d6569'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [AMO Conseil - Premiance - Tous Services MAJ Surface par Nature (doublon ?)]    Script Date: 07/06/2022 15:29:43 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:43 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'AMO Conseil - Premiance - Tous Services MAJ Surface par Nature (doublon ?)', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème, merci d''informer le support dédié : proudreed@amoconseil.com - Société AMO Conseil au 01 42 89 05 68', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Peupler]    Script Date: 07/06/2022 15:29:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Peupler', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'TRUNCATE TABLE SURF_NATURE
INSERT INTO SURF_NATURE

SELECT 
DATEPART(Year,GETDATE()) as [Year], DATEPART(QUARTER,GETDATE()) as [Quarter],
DATEPART(MONTH,GETDATE()) as [Month], DATEPART(DAY,GETDATE()) as [Day],
LAF.IDPROPRIETE as [Propriété], PNAT.NATURE as [Type de lot],
CASE PNAT.UNITE WHEN 1 THEN ''Surface'' WHEN 2 THEN ''Unité'' ELSE ''Error'' END as [Type Surface],
SUM(CASE LAF.CAFFECT WHEN ''L'' THEN isnull(LAF.NSURFACEAFF,0) ELSE 0 END) as [Surface Louée], 
SUM(CASE LAF.CAFFECT WHEN ''V'' THEN isnull(LAF.NSURFACEAFF,0) ELSE 0 END) as [Surface Vacante], 
SUM(isnull(LAF.NSURFACEAFF,0)) as [Total], 
SUM(CASE LAF.CAFFECT WHEN ''L'' THEN isnull(LAF.NSURFACEAFF,0) ELSE 0 END)/SUM(isnull(LAF.NSURFACEAFF,0)) as [Tx. Occ.], 
SUM(CASE LAF.CAFFECT WHEN ''V'' THEN isnull(LAF.NSURFACEAFF,0) ELSE 0 END)/SUM(isnull(LAF.NSURFACEAFF,0)) as [Tx. Vac.]

FROM gagi_prod..LAFFECT LAF
	INNER JOIN gagi_prod..LOT L ON (LAF.IDPROPRIETE=L.PROPRIETE AND LAF.IDLOT=L.LOT)
	INNER JOIN gagi_prod..PNATURE PNAT ON (L.SURFACE=PNAT.NATURE)

WHERE LAF.DDEBUT <= GETDATE() AND (LAF.DFIN >DATEDIFF(Day, 1, GETDATE()) OR LAF.DFIN IS NULL) AND LAF.CAFFECT IN (''L'',''V'')

GROUP BY LAF.IDPROPRIETE,PNAT.NATURE,PNAT.UNITE
-- Suppression des lots avec une surface utile à 0
HAVING SUM(isnull(LAF.NSURFACEAFF,0))>0
', 
		@database_name=N'interface', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Day-To-Day', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110329, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959
		--@schedule_uid=N'a88129bb-023a-40c2-ab7f-8a2c6db9b453'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [DocuWare - DWREF_TEST]    Script Date: 07/06/2022 15:29:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DocuWare - DWREF_TEST', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Import des référentiels PREMIANCE', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [OS CONTRAT]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'OS CONTRAT', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use dwref_test;

IF OBJECT_ID(''GED_PREMIANCE_OS_CONTRAT_TMP'') IS NOT NULL 
DROP TABLE GED_PREMIANCE_OS_CONTRAT_TMP; 

select *  
into dwref_test..GED_PREMIANCE_OS_CONTRAT_TMP
from
(
/* OS */
SELECT rtrim(PROPRIET.CGESTION) SOCIETE_CODE, PROPRIET.[PROPRIETE] +'' - ''+ rtrim(PROPRIET.LIBELLE) PROPRIET_CODELIB, GTOS.IDTIERSINTER +'' - ''+ rtrim(TIERS.RAISON) as TIERS_CODE_LIB, rtrim(GTOS.[IDGTOS]) as ''NO/OS Contrat''
,REPLACE(
CASE 
	WHEN GTCHANTIERAFF.IDPCCHARGE = ''2'' THEN UPPER(LEFT(''NR ''+LEFT(TIERS.RAISON,15)+'' ''+coalesce(GTOS.[TLIBELLE],''''),50))				
	WHEN (rtrim(GTCHANTIER.IDGTPARAMETAT) = ''2-NR'') THEN UPPER(LEFT(''NR ''+LEFT(TIERS.RAISON,15)+'' ''+coalesce(GTOS.[TLIBELLE],''''),50))				
ELSE
	UPPER(LEFT(''R ''+LEFT(TIERS.RAISON,15)+'' ''+coalesce(GTOS.[TLIBELLE], ''''),50)) 	
END,'''''''','' '') as LIBELLE
FROM gagi_test..GTOS 
JOIN gagi_test..PROPRIET ON rtrim(PROPRIET.PROPRIETE) = rtrim(GTOS.[IDPROPRIETE]) 
JOIN gagi_test..[TIERS] ON TIERS.TIERS = GTOS.IDTIERSINTER 
LEFT OUTER JOIN [gagi_test].dbo.GTCHANTIERAFF on GTCHANTIERAFF.IDPCCHARGE = ''2'' and gtos.IDGTOS = GTCHANTIERAFF.IDGTOS
LEFT OUTER JOIN [gagi_test].dbo.GTCHANTIER on GTCHANTIER.IDGTCHANTIER = gtos.IDGTCHANTIER
WHERE (PROPRIET.CDATE is null OR (PROPRIET.CDATE >= cast(''01/01/''+cast(year(getdate())-1 as char)as datetime)) ) and GTOS.[IDGTOS] is not null 
UNION 
SELECT null, ''N/A'',GTOS.IDTIERSINTER +'' - ''+ rtrim(TIERS.RAISON) as TIERS_CODE_LIB, rtrim(GTOS.[IDGTOS]) as ''NO/OS''
,REPLACE(
CASE 
	WHEN GTCHANTIERAFF.IDPCCHARGE = ''2'' THEN UPPER(LEFT(''NR ''+LEFT(TIERS.RAISON,15)+'' ''+coalesce(GTOS.[TLIBELLE],''''),50))				
	WHEN (rtrim(GTCHANTIER.IDGTPARAMETAT) = ''2-NR'') THEN UPPER(LEFT(''NR ''+LEFT(TIERS.RAISON,15)+'' ''+coalesce(GTOS.[TLIBELLE],''''),50))				
ELSE
	UPPER(LEFT(''R ''+LEFT(TIERS.RAISON,15)+'' ''+coalesce(GTOS.[TLIBELLE], ''''),50)) 	
END,'''''''','' '') as LIBELLE
FROM gagi_test..GTOS 
JOIN gagi_test..[TIERS] ON TIERS.TIERS = GTOS.IDTIERSINTER 
LEFT OUTER JOIN [gagi_test].dbo.GTCHANTIERAFF on GTCHANTIERAFF.IDPCCHARGE = ''2'' and gtos.IDGTOS = GTCHANTIERAFF.IDGTOS
LEFT OUTER JOIN [gagi_test].dbo.GTCHANTIER on GTCHANTIER.IDGTCHANTIER = gtos.IDGTCHANTIER
where GTOS.[IDGTOS] is not null 
/* CONTRAT */
UNION 
SELECT rtrim(PROPRIET.CGESTION) SOCIETE_CODE, PROPRIET.[PROPRIETE] +'' - ''+ rtrim(PROPRIET.LIBELLE) PROPRIET_CODELIB, CONTRAT.TIERS +'' - ''+ rtrim(TIERS.RAISON) as TIERS_CODE_LIB, CASE WHEN SYSUSEAFFECT.TAFFVALUE is not null THEN rtrim(SYSUSEAFFECT.TAFFVALUE) ELSE rtrim(CONTRAT.IDCONTRAT) +'' - ''+coalesce(CONTRAT.TLIBELLE, '''') END as ''NO/OS / Contrat'' 
,REPLACE(UPPER(LEFT(LTRIM(coalesce(CONTRAT.TLIBELLE,'''')+'' ''+ LEFT(TIERS.RAISON,15)),50)),'''''''','' '') as LIBELLE
FROM gagi_test..CONTRAT 
JOIN gagi_test..PROPRIET ON rtrim(PROPRIET.PROPRIETE) = rtrim(CONTRAT.[IDPROPRIETE]) 
LEFT JOIN gagi_test..SYSUSEAFFECT ON CONTRAT.IDCONTRAT = SYSUSEAFFECT.TAFFCODE 
JOIN gagi_test..[TIERS] ON TIERS.TIERS = CONTRAT.TIERS 
WHERE (PROPRIET.CDATE is null OR (PROPRIET.CDATE <= cast(''01/01/''+cast(year(getdate())-1 as char)as datetime))) and year(CONTRAT.DFINCONTRATINIT) >= (year(getdate())-2) 
UNION 
SELECT null, ''N/A'',CONTRAT.TIERS +'' - ''+ rtrim(TIERS.RAISON) as TIERS_CODE_LIB, rtrim(SYSUSEAFFECT.TAFFVALUE) as ''NO/OS / Contrat'' 
,REPLACE(UPPER(LEFT(LTRIM(coalesce(CONTRAT.TLIBELLE,'''')+'' ''+ LEFT(TIERS.RAISON,15)),50)),'''''''','' '') as LIBELLE
FROM gagi_test..CONTRAT JOIN gagi_test..PROPRIET ON rtrim(PROPRIET.PROPRIETE) = rtrim(CONTRAT.[IDPROPRIETE]) 
JOIN gagi_test..SYSUSEAFFECT ON CONTRAT.IDCONTRAT= SYSUSEAFFECT.TAFFCODE 
JOIN gagi_test..[TIERS] ON TIERS.TIERS = CONTRAT.TIERS 
WHERE PROPRIET.CDATE is null OR (PROPRIET.CDATE <= cast(''01/01/''+cast(year(getdate())-1 as char)as datetime)) and year(CONTRAT.DFINCONTRATINIT) >= (year(getdate())-2) 
)a;

IF OBJECT_ID(''GED_PREMIANCE_OS_CONTRAT'') IS NOT NULL 
DROP TABLE GED_PREMIANCE_OS_CONTRAT; 

exec sp_rename ''GED_PREMIANCE_OS_CONTRAT_TMP'', ''GED_PREMIANCE_OS_CONTRAT'';', 
		@database_name=N'dwref_test', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [AUTRE]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'AUTRE', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use DWREF_TEST;

IF OBJECT_ID(''GED_PREMIANCE_AUTRE_TMP'') IS NOT NULL 
DROP TABLE GED_PREMIANCE_AUTRE_TMP; 

select *  
into GED_PREMIANCE_AUTRE_TMP
from
(
SELECT ''Défaut'' as Filtre, cast(YEAR(getdate()) as varchar) as ANNEE, PROPRIET.PROPRIETE + '' - '' + rtrim(PROPRIET.LIBELLE) AS PROPRIETE_CODE_LIB, rtrim(PC.CCHARGE) +'' - ''+ rtrim(PC.LIBELLE) as CLE, rtrim(PPD.PDEPENSE) +'' - ''+ rtrim(PPD.LIBELLE) as POSTE 
FROM gagi_test..PCCHARGE PC 
INNER JOIN gagi_test..PPDEPENS PPD ON PPD.CCHARGE=PC.CCHARGE 
LEFT JOIN gagi_test..PROPRIET ON 1=1 
WHERE PC.CTYPE IS NOT NULL AND PC.FARCHIVE IS NULL and PC.CCHARGE is not null and PPD.PDEPENSE is not null 
UNION 
SELECT ''Tantième'' as FILTRE, cast(BUDGEXER.NANNEE as varchar) AS ANNEE, BUDGEXER.IDPROPRIETE + '' - '' + rtrim(PROPRIET.LIBELLE) AS PROPRIETE_CODE_LIB, rtrim(BUDGDATACHG.IDPCCHARGE) +'' - ''+ rtrim(PCCHARGE.LIBELLE) AS CLE, rtrim(BUDGDATACHG.IDPPDEPENS) +'' - ''+ rtrim(PPDEPENS.LIBELLE)+'' - ''+cast(BUDGDATACHG.MPREV as varchar)+''€''  AS POSTE 
FROM gagi_test..BUDGDATACHG 
LEFT JOIN gagi_test..BUDGREV  ON ( BUDGDATACHG.IDBUDGREV = BUDGREV.IDBUDGREV ) 
LEFT JOIN gagi_test..BUDGET ON ( BUDGREV.IDBUDGET = BUDGET.IDBUDGET ) 
LEFT JOIN gagi_test..BUDGEXER ON ( BUDGET.IDBUDGEXER = BUDGEXER.IDBUDGEXER ) 
LEFT JOIN gagi_test..PPDEPENS ON ( BUDGDATACHG.IDPPDEPENS = PPDEPENS.PDEPENSE ) 
LEFT JOIN gagi_test..PCCHARGE ON ( BUDGDATACHG.IDPCCHARGE= PCCHARGE.CCHARGE) 
LEFT JOIN gagi_test..PROPRIET ON BUDGEXER.IDPROPRIETE = PROPRIET.PROPRIETE 
where BUDGEXER.NANNEE > YEAR(getdate()) -3
)a;

IF OBJECT_ID(''GED_PREMIANCE_AUTRE'') IS NOT NULL 
DROP TABLE GED_PREMIANCE_AUTRE; 

exec sp_rename ''GED_PREMIANCE_AUTRE_TMP'', ''GED_PREMIANCE_AUTRE'';', 
		@database_name=N'DWREF_TEST', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Journalier 1 minute', 
		@enabled=0, 
		@freq_type=8, 
		@freq_interval=126, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20170613, 
		@active_end_date=99991231, 
		@active_start_time=83000, 
		@active_end_time=203000, 
		--@schedule_uid=N'd7b00168-090a-4f53-96bf-ebc00939ff83'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [MonBuilding - Export Factures CSV]    Script Date: 07/06/2022 15:29:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MonBuilding - Export Factures CSV', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Export]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Export', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @fileName varchar(4000) = ''D:\MonBuilding\MyFile.csv''
declare @bcpCommand varchar(4000)

SET @bcpCommand = ''bcp "SELECT GetDate() as Hoist_Sched_Tom" queryout '' + @fileName + ''  -c -t , -r \n  -S . -T''

select @bcpCommand 

EXEC master..xp_cmdshell @bcpCommand', 
		@database_name=N'dwdata', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [MY REM - Mon BUILDING]    Script Date: 07/06/2022 15:29:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MY REM - Mon BUILDING', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème : MY REM SOFTWARE (support@myrem.fr)', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [All]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'All', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
 DECLARE @query_cmd varchar(8000);
		SET @query_cmd	=''bcp "select  char(34) + LTRIM(RTRIM(ISNULL(GPL. LOCAT,''''''''))) +char(34) as [Code locataire], char(34) + LTRIM(RTRIM(LTRIM(RTRIM(ISNULL(GPL.NOM,''''''''))) + '''' '''' + LTRIM(RTRIM(ISNULL(GPL. PRENOM,''''''''))))) + char(34) as [Raison social], char(34)+LTRIM(RTRIM(LTRIM(RTRIM(ISNULL(GPL.RCS,''''''''))) + '''' '''' + LTRIM(RTRIM(ISNULL(GPL.RCSVILLE,''''''''))))) + char(34) AS [RCS],char(34)+ISNULL(LEFT(GPL.RCS,9),'''''''')+char(34) AS [siren], char(34)+LTRIM(RTRIM(ISNULL(GPP.POA_ADD1,'''''''') + '''' '''' + ISNULL(GPP.POA_ADD2,'''''''') + '''' '''' + ISNULL(GPP.POA_ADD3,''''''''))) +char(34) as [rue], char(34)+ISNULL(GPP.POA_VILLE,'''''''')+char(34) as [Ville], char(34)+ISNULL(GPP.POA_CP,'''''''')+char(34) as [Code Postal], char(34)+LTRIM(RTRIM(ISNULL(GPP.PROPRIETE,'''''''')))+char(34) as [code Parc d''''activité], char(34)+ISNULL(GPP.POA_PAYS,''''FRANCE'''')+char(34) as [Pays], char(34)+LTRIM(RTRIM(ISNULL(CTL.EMAIL,'''''''')))+char(34) as [email_administrateur], char(34)+LTRIM(RTRIM(ISNULL(CTL.NOM,'''''''')))+char(34) as [nom], char(34)+LTRIM(RTRIM(ISNULL(CTL.PRENOM,'''''''')))+char(34) as [prenom]  from gagi_prod..LOCAT GPL LEFT JOIN gagi_prod..CONTACT CTL ON CTL.RATTACH=GPL.LOCAT AND CTL.CTYPE=''''L'''' AND CTL.TCONTACT=10 INNER JOIN gagi_prod..BAIL GPB ON GPL.IDLOCAT=GPB.IDLOCAT INNER JOIN gagi_prod..PROPRIET GPP ON GPB.PROPRIETE=GPP.PROPRIETE" queryout "C:\Temp\tenants\compagnies.csv" -S PROSQL01 -T -c -C ACP -t";"''
		   --PRINT @query_cmd
		   EXEC xp_cmdshell @query_cmd

--	DECLARE @query_cmd varchar(8000);
		SET @query_cmd	=''bcp "select  char(34) + LTRIM(RTRIM(ISNULL(GPP.CGESTION,''''''''))) + char(34) as [code proprio], char(34) + LTRIM(RTRIM(LTRIM(RTRIM(ISNULL(GPL.RCS,''''''''))) )) + char(34)  AS [RCS] , char(34) + LTRIM(RTRIM(ISNULL(GPL. LOCAT,''''''''))) + char(34) as [Code locataire], char(34) + LTRIM(RTRIM(ISNULL(GPP.PROPRIETE,''''''''))) + char(34) as [code propriété], char(34) + LTRIM(RTRIM(ISNULL(GPB. BAIL,''''''''))) + char(34) as [Code bail], char(34) + LTRIM(RTRIM(ISNULL(CAST(DATEPART(YEAR,GPB.DEFFET) as VARCHAR(4))+''''-''''+CAST(DATEPART(MONTH,GPB.DEFFET) as VARCHAR(2))+''''-''''+CAST(DATEPART(DAY,GPB.DEFFET) as VARCHAR(2)),''''''''))) + Char(34) as [date d''''entrée], char(34) + LTRIM(RTRIM(ISNULL(CAST(DATEPART(YEAR,GPB.DFINBAIL) as VARCHAR(4))+''''-''''+CAST(DATEPART(MONTH,GPB.DFINBAIL) as VARCHAR(2))+''''-''''+CAST(DATEPART(DAY,GPB.DFINBAIL) as VARCHAR(2)),''''''''))) + char(34) as [date de fin] from gagi_prod..LOCAT GPL INNER JOIN gagi_prod..BAIL GPB ON GPL.IDLOCAT=GPB.IDLOCAT INNER JOIN gagi_prod..PROPRIET GPP ON GPB.PROPRIETE=GPP.PROPRIETE" queryout "C:\Temp\tenants\contrat.csv" -S PROSQL01 -T -c -C ACP -t";"''
		   --PRINT @query_cmd
		   EXEC xp_cmdshell @query_cmd', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Export WINSCP MyREM]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Export WINSCP MyREM', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC xp_cmdshell ''C:\WinSCP\MonBuilding\01-Transfert.bat''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Export WinScp Neocles]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Export WinScp Neocles', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC xp_cmdshell ''C:\WinSCP\MonBuilding\01-Transfert_NEOCLES.bat''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'20h15', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190829, 
		@active_end_date=99991231, 
		@active_start_time=201500, 
		@active_end_time=235959
		--@schedule_uid=N'060b9fd8-0b5f-48bc-bf6c-2e645dc4f8cb'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [MY REM - Portail Tenants]    Script Date: 07/06/2022 15:29:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MY REM - Portail Tenants', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'En cas de problème : MY REM SOFTWARE (support@myrem.fr)', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [0-PINDICE]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'0-PINDICE', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';

-- STRUCTURES
-- Création de la table temporaire 02.02
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_pindice'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_pindice;
end try 
begin catch end catch
BEGIN
	SET @mci_ver = ''02.02'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_pindice ('' +
		''mvi VARCHAR(50) NOT NULL,''+
		''Code VARCHAR(100) NOT NULL,''+
		''TindiceId VARCHAR(100),''+
		''TindiceLib VARCHAR(100),''+
		''Periodicite VARCHAR(2),''+
		''IndiceId VARCHAR(100),''+
		''Dpublication DATE,''+
		''Ddebut DATE,''+
		''Valeur DECIMAL(18,2)'' +
		'');''
	exec(@query_sql);
END

BEGIN -- Mise en place PK 02.02
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_pindice ADD PRIMARY KEY (Code)''
	exec(@query_sql);
END

-- DONNEES
BEGIN -- Peuplement PK + base : mvi, CodeSource,Code
if @debug_mode = 1 Print ''Peuplement PK + base : mvi, Code''
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_pindice (mvi, Code) '' +
		''SELECT ''''''+@mci_ver+'''''',PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND ''+
		''FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
		'' WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 ''

	if @debug_mode = 1 PRINT @query_sql
	exec(@query_sql)
END

-- Alimentation des données

BEGIN -- TindiceId
if @debug_mode=1 Print ''TindiceId''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET TindiceId=''+
	''(SELECT INDICE.IDPTYPINDICE FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

BEGIN -- TindiceLib
if @debug_mode=1 Print ''TindiceLib''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET TindiceLib=''+
	''(SELECT PTYPINDICE.TLIBELLE FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

BEGIN -- Periodicite
if @debug_mode=1 Print ''Periodicite''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET Periodicite=''+
	''(SELECT PTYPINDICE.CPERIOD FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

BEGIN -- IndiceId
if @debug_mode=1 Print ''IndiceId''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET IndiceId=''+
	''(SELECT INDICE.CODEIND FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

BEGIN -- Dpublication
if @debug_mode=1 Print ''Dpublication''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET Dpublication=''+
	''(SELECT INDICE.DATE_PUB FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

BEGIN -- Ddebut
if @debug_mode=1 Print ''Ddebut''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET Ddebut=''+
	''(SELECT INDICE.DATE_DEB FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

BEGIN -- Valeur
if @debug_mode=1 Print ''Valeur''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_pindice SET Valeur=''+
	''(SELECT INDICE.VALEUR FROM INDICE INNER JOIN PTYPINDICE ON INDICE.IDPTYPINDICE=PTYPINDICE.IDPTYPINDICE '' +
	''WHERE LEN(RTRIM(LTRIM(INDICE.CODEIND)))>0 AND PTYPINDICE.TLIBELLE + '''''''' + INDICE.CODEIND=Code)'';
exec(@query_sql);
END

if @type=1 
BEGIN
	SET @query_sql = ''SELECT * FROM ''+@base+''..myrem_pindice'';
		exec(@query_sql);
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_pindice'';
--		exec(@query_sql);
END', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [1-ACTIFS]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'1-ACTIFS', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';


-- STRUCTURES
SET @script_section = ''Création de la table temporaire 02.02''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_actif'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_actif;
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.02'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_actif ('' +
		''mvi varchar (50) NOT NULL,'' +
		''CodeSource varchar(255) NOT NULL,'' +
		''CodeActif varchar(20) NOT NULL,'' +
		''libelle varchar(255) NOT NULL,'' +
		''Add1 varchar(100) NOT NULL,'' +
		''Add2 varchar(100),'' +
		''Add3 varchar(100),'' +
		''Add4 varchar(100),'' +
		''CP varchar(10),'' +
		''Ville varchar(100) NOT NULL,'' +
		''Pays varchar(100) NOT NULL,'' +
		''ProprioId varchar(100),'' +
		''ProprioLib varchar(100),'' +
		''AdbId varchar(100),'' +
		''AdbLib varchar(100),'' +
		''MandantId varchar(100),'' +
		''MandantLib varchar(100),'' +
		''GroupementId varchar(100),'' +
		''GroupementLib varchar(100),'' +
		''GroupementLoc varchar(100),'' +
		''TypeId varchar(100),'' +
		''TypeLib varchar(100),'' +
		''VenteDate date,'' +
		''VenteOk varchar(1),'' +
		''DpeDate DATE,'' +
		''DpeOk varchar(1),'' +
		''DpeConsoVal decimal(18,5),'' +
		''DpeConsoClasse character(1),'' +
		''DpeGesVal decimal(18,5),'' +
		''DpeGesClasse character(1),'' +
		''DpeScreenNote decimal(18,5),'' +
		''AssetId varchar(100),'' +
		''AssetLib varchar(100),'' +
		''AssetSurfTotM2 decimal(18,5),'' +
		''AssetSurfTotU decimal(18,5),'' +
		''AssetSurfLoueM2 decimal(18,5),'' +
		''AssetSurfLoueU decimal(18,5),'' +
		''AssetSurfVacM2 decimal(18,5),'' +
		''AssetSurfVacU decimal(18,5),'' +
		''AssetTxOcc decimal(6,3),'' +
		''AssetTxVac decimal(6,3),'' +
		''GestionId varchar(100),'' +
		''GestionLib varchar(100),'' +
		''FinLoyer decimal(18,2),'' +
		''FinDg decimal(18,2),'' +
		''FinBalanceAg decimal(18,2),'' +
		''FinBudgetCharge decimal(18,2),'' +
		''FinBudgetEngage decimal(18,2),'' +
		''FinBudgetRealise decimal(18,2),'' +
		''ExpertiseAnnee varchar(4),'' +
		''ExpertiseValHf decimal(18,2),'' +
		''ExpertiseValFi decimal(18,2),'' +
		''TypeSurface character(1),'' +
		''fk_Pregion_IdRegion varchar(100),'' +
		''fk_Pdept_IdDept varchar(100),'' +
		''fk_Pimmostat_IdImmostat varchar(100),'' +
		''Description1 varchar(255),'' +
		''Description2 varchar(255),'' +
		''Description3 varchar(255),'' +
		''OpeDateSign date,'' +
		''OpeDatePconst date,'' +
		''OpeDateOuverture date,'' +
		''OpeDureeConst integer,'' +
		''MandatType varchar(100),'' +
		''MandatLib varchar(100),'' +
		''MandatDateEffet date,'' +
		''MandatDateFin date,'' +
		''MandatNumero varchar(100),'' +
		''MandatPreavis integer,'' +
		''MandatDuree integer,'' +
		''FiscaActif varchar(100),'' +
		''Icpe varchar(100),'' +
		''Dta varchar(100)    '' +
		'');''
	exec(@query_sql);
END

BEGIN
SET @script_section = ''Mise en place PK 02.02''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_actif ADD PRIMARY KEY (CodeSource, CodeActif)''
	exec(@query_sql);
END

-- DONNEES
BEGIN
SET @script_section = ''Gestion des filtres spécifiques''
if @debug_mode = 1 Print @script_section
	SET @filtre = 
		case @id_client 
			when 1 then case @id_source WHEN ''ACTEVA'' THEN '' AND (P.CDATE > GetDate() OR P.CDATE IS NULL) AND RTRIM(P.CGESTION) NOT IN (''''00000001'''', ''''00000011'''', ''''00000012'''', ''''00000009'''' ) '' ELSE ''  AND (P.CDATE > GetDate() OR P.CDATE IS NULL)'' END
			when 3 then '' AND (P.CDATE > GetDate() OR P.CDATE IS NULL)''
			when 44 then '' AND (D_GROUPEMENT.CODE <> ''''ASLCOPRO'''') AND (P.CDATE > GetDate() OR P.CDATE IS NULL)''
			when 98 then '' AND (P.CDATE > GetDate() OR P.CDATE IS NULL)''
			else '' AND 1=1'' END; 
END


BEGIN
SET @script_section = ''Peuplement PK + base : mvi,CodeSource,CodeActif,libelle,add1,add2,add3,CP,ville,pays''
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_actif (mvi,CodeSource,CodeActif,libelle,Add1,Add2,Add3,CP,Ville,Pays) '' +
		''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''',P.PROPRIETE,P.LIBELLE,ISNULL(P.POA_ADD1,''''ADD1''''),P.POA_ADD2,P.POA_ADD3,P.POA_CP,ISNULL(P.POA_VILLE,''''VILLE''''),ISNULL(P.POA_PAYS,''''FRANCE'''') FROM PROPRIET P ''+
		''LEFT JOIN IMMEUBLE  ON P.IMMEUBLE=IMMEUBLE.IMMEUBLE COLLATE French_CI_AS ''+
		''LEFT JOIN INTERNE D_GROUPEMENT ON IMMEUBLE.GROUPE=D_GROUPEMENT.CODE COLLATE French_CI_AS ''+
		'' WHERE 1=1''+@filtre 
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END


BEGIN SET @script_section = ''POA_ADD3''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET Add3=''+
	''(SELECT RTRIM(ISNULL(I.LIBELLE,''''IMMEUBLE'''')) + '''' (''''+ RTRIM(ISNULL(I.IMMEUBLE,'''''''')) + '''')'''' FROM PROPRIET P INNER JOIN IMMEUBLE I ON P.IMMEUBLE=I.IMMEUBLE ''+
	''WHERE P.PROPRIETE=CodeActif)'';
exec(@query_sql);
END

-- Alimentation des données
BEGIN SET @script_section = ''ProprioId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET ProprioId=''+
	''(SELECT P.CGESTION FROM PROPRIET P ''+
	''WHERE P.PROPRIETE=CodeActif)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ProprioLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET ProprioLib=''+
	''(SELECT D_PROPRIO.NOM FROM PROPRIET P LEFT JOIN PROPRIO D_PROPRIO ON P.CGESTION=D_PROPRIO.PROPRIO COLLATE French_CI_AS ''+
	''WHERE P.PROPRIETE=CodeActif)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''AdbId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AdbId=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL(GP.GROUPE,''''NR'''') FROM PROPRIET P LEFT JOIN GROUPEP GP ON P.GROUPE=GP.GROUPE WHERE P.PROPRIETE=CodeActif) ''+
		''WHEN 1 THEN '''''' + cast(@id_source as varchar(80)) +'''''' ''+
		''WHEN 44 THEN (SELECT ISNULL(INTGA.CODE,''''NR'''') FROM PROPRIET P ''+
			''LEFT JOIN PROPRIETINTSERV PINTSERV_2 ON P.PROPRIETE=PINTSERV_2.IDPROPRIETE AND PINTSERV_2.IDSERVICE=2 '' + --Gestionnaire d''actif
			''LEFT JOIN INTERNE INTGA ON PINTSERV_2.IDINTERNE=INTGA.CODE WHERE P.PROPRIETE=CodeActif)'' + 
		''ELSE NULL END''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''AdbLib''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AdbLib=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL(GP.LIBELLE,''''NR'''') FROM PROPRIET P LEFT JOIN GROUPEP GP ON P.GROUPE=GP.GROUPE WHERE P.PROPRIETE=CodeActif) ''+
		''WHEN 1 THEN '''''' + cast(@id_source as varchar(80)) +'''''' ''+
		''WHEN 44 THEN (SELECT ISNULL(INTGA.LIBELLE,''''NR'''') FROM PROPRIET P ''+
			''LEFT JOIN PROPRIETINTSERV PINTSERV_2 ON P.PROPRIETE=PINTSERV_2.IDPROPRIETE AND PINTSERV_2.IDSERVICE=2 '' + --Gestionnaire d''actif
			''LEFT JOIN INTERNE INTGA ON PINTSERV_2.IDINTERNE=INTGA.CODE WHERE P.PROPRIETE=CodeActif)'' + 
		''ELSE NULL END''; 
exec(@query_sql);
END

BEGIN SET @script_section = ''MandantId''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandantId=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL(CAST(PREGPROP.NIVNUM as VARCHAR(8)),''''0'''') FROM PROPRIET P ''+
			''LEFT JOIN PROPRIO D_PROPRIO ON P.CGESTION=D_PROPRIO.PROPRIO COLLATE French_CI_AS ''+
			''LEFT JOIN PREGPROP ON D_PROPRIO.NIVNUM=PREGPROP.NIVNUM WHERE P.PROPRIETE=CodeActif)''+
		''WHEN 44 THEN (SELECT ISNULL(INTGL.LIBELLE,''''Non renseigné'''') FROM PROPRIET P  ''+
			''LEFT JOIN PROPRIETINTSERV PINTSERV_1 ON P.PROPRIETE=PINTSERV_1.IDPROPRIETE AND PINTSERV_1.IDSERVICE=1 '' + --Gestionnaire locatif
			''LEFT JOIN INTERNE INTGL ON PINTSERV_1.IDINTERNE=INTGL.CODE WHERE P.PROPRIETE=CodeActif)'' +
		''ELSE NULL END''; 
exec(@query_sql);
END

BEGIN SET @script_section = ''MandantLib''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandantLib=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL(PREGPROP.NIVLIBE,''''Autre'''') FROM PROPRIET P ''+
			''LEFT JOIN PROPRIO D_PROPRIO ON P.CGESTION=D_PROPRIO.PROPRIO COLLATE French_CI_AS ''+
			''LEFT JOIN PREGPROP ON D_PROPRIO.NIVNUM=PREGPROP.NIVNUM WHERE P.PROPRIETE=CodeActif)''+
		''WHEN 44 THEN (SELECT ISNULL(INTGL.LIBELLE,''''Non renseigné'''') FROM PROPRIET P  ''+
			''LEFT JOIN PROPRIETINTSERV PINTSERV_1 ON P.PROPRIETE=PINTSERV_1.IDPROPRIETE AND PINTSERV_1.IDSERVICE=1 '' + --Gestionnaire locatif
			''LEFT JOIN INTERNE INTGL ON PINTSERV_1.IDINTERNE=INTGL.CODE WHERE P.PROPRIETE=CodeActif)'' +
		''ELSE NULL END''; 
exec(@query_sql);
END

BEGIN SET @script_section = ''GroupementId''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET GroupementId=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL(((SELECT TOP 1 CAST(MANDGEST as VARCHAR) FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND (M.CADFIN IS NULL OR M.CADFIN >= GetDate()) ORDER BY M.CADFIN DESC)),''''NR'''') FROM PROPRIET P  WHERE P.PROPRIETE=CodeActif)''+
		''ELSE (SELECT RTRIM(ISNULL(CAST(D_GROUPEMENT.CODE as VARCHAR),''''NR'''')) FROM PROPRIET P ''+
			''LEFT JOIN IMMEUBLE  ON P.IMMEUBLE=IMMEUBLE.IMMEUBLE COLLATE French_CI_AS ''+
			''LEFT JOIN INTERNE D_GROUPEMENT ON IMMEUBLE.GROUPE=D_GROUPEMENT.CODE COLLATE French_CI_AS WHERE P.PROPRIETE=CodeActif)''+
		'' END''; 
exec(@query_sql);
END

BEGIN SET @script_section = ''GroupementLib''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET GroupementLib=''+
		''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL((SELECT CASE WHEN LEN(ISNULL(RTRIM(CONTACT.PRENOM),'''''''')+'''' ''''+ISNULL(RTRIM(CONTACT.NOM),''''''''))=1 THEN ''''Non saisi'''' ELSE ISNULL(RTRIM(CONTACT.PRENOM),'''''''')+'''' ''''+ISNULL(RTRIM(CONTACT.NOM),'''''''') END FROM CONTACT WHERE CONTACT.LIGNE=(SELECT TOP 1 MANDGEST FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND (M.CADFIN IS NULL OR M.CADFIN >= GetDate()) ORDER BY M.CADFIN DESC)	AND CONTACT.CTYPE=''''T'''' AND CONTACT.RATTACH=(SELECT TOP 1 MANDAT FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND (M.CADFIN IS NULL OR M.CADFIN >= GetDate()) ORDER BY M.CADFIN DESC)),''''Non Renseigné'''') FROM PROPRIET P  WHERE P.PROPRIETE=CodeActif)''+
		''ELSE (SELECT ISNULL(CASE WHEN LEN(RTRIM(D_GROUPEMENT.LIBELLE))=0 THEN ''''Non Saisi'''' ELSE RTRIM(D_GROUPEMENT.LIBELLE) END, ''''Non renseigné'''') FROM PROPRIET P ''+
			''LEFT JOIN IMMEUBLE  ON P.IMMEUBLE=IMMEUBLE.IMMEUBLE COLLATE French_CI_AS ''+
			''LEFT JOIN INTERNE D_GROUPEMENT ON IMMEUBLE.GROUPE=D_GROUPEMENT.CODE COLLATE French_CI_AS WHERE P.PROPRIETE=CodeActif)''+
		'' END''; 
exec(@query_sql);
END

BEGIN SET @script_section = ''TypeId''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET TypeId=''+
		''(SELECT RTRIM(ISNULL(CAST(P.NATLOCAUX as CHAR),''''SSTYPO'''')) FROM PROPRIET P''+
		'' WHERE P.PROPRIETE=CodeActif)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''TypeLib''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET TypeLib=''+
		''(SELECT RTRIM(ISNULL(P_NATURE.CNATURE,''''Sans Typologie'''')) FROM PROPRIET P ''+
		''LEFT JOIN PNATURE P_NATURE ON P.NATLOCAUX=P_NATURE.NATURE '' +
		'' WHERE P.PROPRIETE=CodeActif)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''GroupementLoc''
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET GroupementLoc=''+
		''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT ISNULL(CASE WHEN LEN(RTRIM(D_GROUPEMENT.LIBELLE))=0 THEN ''''Non Saisi'''' ELSE RTRIM(D_GROUPEMENT.LIBELLE) END, ''''Non renseigné'''') FROM PROPRIET P ''+
			''LEFT JOIN IMMEUBLE  ON P.IMMEUBLE=IMMEUBLE.IMMEUBLE COLLATE French_CI_AS ''+
			''LEFT JOIN INTERNE D_GROUPEMENT ON IMMEUBLE.GROUPE=D_GROUPEMENT.CODE COLLATE French_CI_AS WHERE P.PROPRIETE=CodeActif)''+
		''ELSE NULL END''; 
exec(@query_sql);
END


BEGIN TRY SET @script_section = ''VenteDate''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET VenteDate=''+
		''(SELECT P.CDATE FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)'';
exec(@query_sql);
END TRY

BEGIN CATCH
    SET NOCOUNT ON;
	SELECT CONVERT(varchar(50), ERROR_NUMBER()) AS ErrorNumber,CONVERT(varchar(255), ERROR_MESSAGE()) AS ErrorMessage;
END CATCH

BEGIN TRY SET @script_section = ''VenteOk''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET VenteOk = ''+
		''(SELECT CASE WHEN ISNULL(P.CDATE,''''31/12/2999'''')=''''31/12/2999'''' THEN ''''N'''' ELSE CASE WHEN P.CDATE>GetDate() THEN ''''N'''' ELSE ''''O'''' END END FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)'';
if @debug_mode = 1 Print @query_sql
exec(@query_sql);
END TRY

BEGIN CATCH
    SET NOCOUNT ON;
	SELECT CONVERT(varchar(50), ERROR_NUMBER()) AS ErrorNumber,CONVERT(varchar(255), ERROR_MESSAGE()) AS ErrorMessage;
END CATCH

BEGIN SET @script_section = ''DpeDate''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET DpeDate=''+
		''(SELECT PROPENERGIE.DDPE FROM PROPRIET P ''+
			 ''LEFT JOIN PROPENERGIE ON P.PROPRIETE=PROPENERGIE.IDPROPRIETE ''+
			 ''LEFT JOIN PENVIRONNEMENT A ON A.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTA AND A.CTYPE=''''E'''' ''+
			 ''LEFT JOIN PENVIRONNEMENT B ON B.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTB AND B.CTYPE=''''E'''' ''+
		''WHERE P.PROPRIETE=CodeActif AND PROPENERGIE.NENERGIE = (SELECT MAX(PE.NENERGIE) FROM PROPENERGIE PE WHERE PE.IDPROPRIETE=P.PROPRIETE))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DpeOk''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET DpeOk = ''+
		''(SELECT CASE ISNULL(PROPENERGIE.DDPE,''''31/12/2999'''') WHEN ''''31/12/2999'''' THEN ''''N'''' ELSE ''''O'''' END FROM PROPRIET P ''+
			 ''LEFT JOIN PROPENERGIE ON P.PROPRIETE=PROPENERGIE.IDPROPRIETE ''+
			 ''LEFT JOIN PENVIRONNEMENT A ON A.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTA AND A.CTYPE=''''E'''' ''+
			 ''LEFT JOIN PENVIRONNEMENT B ON B.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTB AND B.CTYPE=''''E'''' ''+
		''WHERE P.PROPRIETE=CodeActif AND PROPENERGIE.NENERGIE = (SELECT MAX(PE.NENERGIE) FROM PROPENERGIE PE WHERE PE.IDPROPRIETE=P.PROPRIETE))'';
if @debug_mode = 1 Print @query_sql
exec(@query_sql);
END

BEGIN SET @script_section = ''DpeConsoVal''
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET DpeConsoVal=''+
		''(SELECT ISNULL(ROUND(PROPENERGIE.MEMISSION,2),0) FROM PROPRIET P ''+
			 ''LEFT JOIN PROPENERGIE ON P.PROPRIETE=PROPENERGIE.IDPROPRIETE ''+
			 ''LEFT JOIN PENVIRONNEMENT A ON A.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTA AND A.CTYPE=''''E'''' ''+
			 ''LEFT JOIN PENVIRONNEMENT B ON B.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTB AND B.CTYPE=''''E'''' ''+
		''WHERE P.PROPRIETE=CodeActif AND PROPENERGIE.NENERGIE = (SELECT MAX(PE.NENERGIE) FROM PROPENERGIE PE WHERE PE.IDPROPRIETE=P.PROPRIETE))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DpeConsoClasse''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET DpeConsoClasse=''+
		''(SELECT ISNULL(B.TLIBELLE,''''-'''') FROM PROPRIET P ''+
			 ''LEFT JOIN PROPENERGIE ON P.PROPRIETE=PROPENERGIE.IDPROPRIETE ''+
			 ''LEFT JOIN PENVIRONNEMENT A ON A.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTA AND A.CTYPE=''''E'''' ''+
			 ''LEFT JOIN PENVIRONNEMENT B ON B.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTB AND B.CTYPE=''''E'''' ''+
		''WHERE P.PROPRIETE=CodeActif AND PROPENERGIE.NENERGIE = (SELECT MAX(PE.NENERGIE) FROM PROPENERGIE PE WHERE PE.IDPROPRIETE=P.PROPRIETE))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DpeGesVal''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET DpeGesVal=''+
		''(SELECT ISNULL(ROUND(PROPENERGIE.MCONSO,2),0) FROM PROPRIET P ''+
			 ''LEFT JOIN PROPENERGIE ON P.PROPRIETE=PROPENERGIE.IDPROPRIETE ''+
			 ''LEFT JOIN PENVIRONNEMENT A ON A.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTA AND A.CTYPE=''''E'''' ''+
			 ''LEFT JOIN PENVIRONNEMENT B ON B.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTB AND B.CTYPE=''''E'''' ''+
		''WHERE P.PROPRIETE=CodeActif AND PROPENERGIE.NENERGIE = (SELECT MAX(PE.NENERGIE) FROM PROPENERGIE PE WHERE PE.IDPROPRIETE=P.PROPRIETE))'';
exec(@query_sql);
END
		
BEGIN SET @script_section = ''DpeGesClasse''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET DpeGesClasse=''+
		''(SELECT ISNULL(A.TLIBELLE,''''-'''') FROM PROPRIET P ''+
			 ''LEFT JOIN PROPENERGIE ON P.PROPRIETE=PROPENERGIE.IDPROPRIETE ''+
			 ''LEFT JOIN PENVIRONNEMENT A ON A.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTA AND A.CTYPE=''''E'''' ''+
			 ''LEFT JOIN PENVIRONNEMENT B ON B.IDPENVIRONNEMENT=PROPENERGIE.IDPENVIRONNEMENTB AND B.CTYPE=''''E'''' ''+
		''WHERE P.PROPRIETE=CodeActif AND PROPENERGIE.NENERGIE = (SELECT MAX(PE.NENERGIE) FROM PROPENERGIE PE WHERE PE.IDPROPRIETE=P.PROPRIETE))'';
exec(@query_sql);
END

		--''DpeScreenNote decimal(18,5),'' +

BEGIN SET @script_section = ''AssetId''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetId=''+
		''CASE ''+cast(@id_client as varchar(80))+
		'' WHEN 2 THEN ''+
		''(SELECT ISNULL((SELECT AAPPORT FROM PROPINFO LEFT JOIN TIERS ON PROPINFO.AAPPORT=TIERS.TIERS WHERE PROPINFO.IDPROPRIETE=P.PROPRIETE),'''''''') FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''+
		''WHEN 3 THEN ''+
		''(SELECT ISNULL(((SELECT TOP 1 CAST(MANDTECH as VARCHAR(8)) FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND (M.CADFIN IS NULL OR M.CADFIN >= GetDate()) ORDER BY M.CADFIN DESC)),''''NR'''')  FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)''+
		''ELSE '''''''' END'';
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetLib''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetLib=''+
		''CASE ''+cast(@id_client as varchar(80))+
		'' WHEN 2 THEN ''+
		''(SELECT ISNULL((SELECT TIERS.RAISON FROM PROPINFO LEFT JOIN TIERS ON PROPINFO.AAPPORT=TIERS.TIERS WHERE PROPINFO.IDPROPRIETE=P.PROPRIETE),'''''''') FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)''+
		''WHEN 3 THEN ''+
		''(SELECT ISNULL((SELECT ISNULL(RTRIM(CONTACT.PRENOM),'''''''')+'''' ''''+ISNULL(RTRIM(CONTACT.NOM),'''''''') FROM CONTACT WHERE RATTACH=''''40000'''' AND CONTACT.LIGNE=(SELECT TOP 1 MANDTECH FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND (M.CADFIN IS NULL OR M.CADFIN >= GetDate()) ORDER BY M.CADFIN DESC)	),''''Non Renseigné'''')   FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)''+
		''ELSE '''''''' END '' 
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfTotM2''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetSurfTotM2=''+
		''(SELECT ISNULL((SELECT SUM(ISNULL(A1.NSURFACEAFF,0)) FROM LAFFECT A1 INNER JOIN LOT L1 ON A1.IDPROPRIETE=L1.PROPRIETE AND A1.IDLOT=L1.LOT  ''+
		''INNER JOIN PNATURE P1 ON L1.SURFACE=P1.NATURE AND ''+ 
			case @id_client when 3 then '' P1.CNATURE NOT LIKE ''''%PARKING%'''' AND P1.CNATURE NOT IN(''''19'''',''''20'''',''''21'''',''''22'''') '' 
			else '' P1.UNITE=1 '' end + 
		'' WHERE A1.CAFFECT IN (''''L'''', ''''V'''') AND A1.IDPROPRIETE=P.PROPRIETE ''+
		''AND A1.DDEBUT<=GETDATE() AND (A1.DFIN>GetDate() OR A1.DFIN IS NULL)),0) FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfTotU''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetSurfTotU=''+
		''(SELECT ''+
		''ISNULL((SELECT SUM(ISNULL(A2.NSURFACEAFF,0)) FROM LAFFECT A2 INNER JOIN LOT L2 ON A2.IDPROPRIETE=L2.PROPRIETE AND A2.IDLOT=L2.LOT  ''+
		''INNER JOIN PNATURE P2 ON L2.SURFACE=P2.NATURE AND ''+ case @id_client when 3 then '' P2.CNATURE LIKE ''''%PARKING%'''' '' else '' P2.UNITE=2 '' end + ''  WHERE A2.CAFFECT IN (''''L'''', ''''V'''') AND A2.IDPROPRIETE=P.PROPRIETE ''+
		''AND A2.DDEBUT<=GETDATE() AND (A2.DFIN>GetDate() OR A2.DFIN IS NULL)),0)'' +
		'' FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfLoueM2''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetSurfLoueM2=''+
		''(SELECT ''+
		''ISNULL((SELECT SUM(ISNULL(A3.NSURFACEAFF,0)) FROM LAFFECT A3 INNER JOIN LOT L3 ON A3.IDPROPRIETE=L3.PROPRIETE AND A3.IDLOT=L3.LOT  ''+
		''INNER JOIN PNATURE P3 ON L3.SURFACE=P3.NATURE AND ''+ case @id_client when 3 then '' P3.CNATURE NOT LIKE ''''%PARKING%'''' AND P3.CNATURE NOT IN(''''19'''',''''20'''',''''21'''',''''22'''') '' else '' P3.UNITE=1 '' end + '' WHERE A3.CAFFECT=''''L'''' AND A3.IDPROPRIETE=P.PROPRIETE ''+
		''AND A3.DDEBUT<=GETDATE() AND (A3.DFIN>GetDate() OR A3.DFIN IS NULL)),0)'' +
		'' FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfLoueU''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetSurfLoueU=''+
		''(SELECT ''+
		''ISNULL((SELECT SUM(ISNULL(A4.NSURFACEAFF,0)) FROM LAFFECT A4 INNER JOIN LOT L4 ON A4.IDPROPRIETE=L4.PROPRIETE AND A4.IDLOT=L4.LOT  ''+
		''INNER JOIN PNATURE P4 ON L4.SURFACE=P4.NATURE AND ''+ case @id_client when 3 then '' P4.CNATURE LIKE ''''%PARKING%'''' '' else '' P4.UNITE=2 '' end + '' WHERE A4.CAFFECT=''''L'''' AND A4.IDPROPRIETE=P.PROPRIETE ''+
		''AND A4.DDEBUT<=GETDATE() AND (A4.DFIN>GetDate() OR A4.DFIN IS NULL)),0)'' +
		'' FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfVacM2''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetSurfVacM2=''+
		''(SELECT ''+
		''ISNULL((SELECT SUM(ISNULL(A5.NSURFACEAFF,0)) FROM LAFFECT A5 INNER JOIN LOT L5 ON A5.IDPROPRIETE=L5.PROPRIETE AND A5.IDLOT=L5.LOT  ''+
		''INNER JOIN PNATURE P5 ON L5.SURFACE=P5.NATURE AND ''+ case @id_client when 3 then '' P5.CNATURE NOT LIKE ''''%PARKING%'''' AND P5.CNATURE NOT IN(''''19'''',''''20'''',''''21'''',''''22'''') '' else '' P5.UNITE=1 '' end + '' WHERE A5.CAFFECT=''''V'''' AND A5.IDPROPRIETE=P.PROPRIETE ''+
		''AND A5.DDEBUT<=GETDATE() AND (A5.DFIN>GetDate() OR A5.DFIN IS NULL)),0)''+
		'' FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''
		exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfVacU''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetSurfVacU=''+
		''(SELECT ''+
		''ISNULL((SELECT SUM(ISNULL(A6.NSURFACEAFF,0)) FROM LAFFECT A6 INNER JOIN LOT L6 ON A6.IDPROPRIETE=L6.PROPRIETE AND A6.IDLOT=L6.LOT  ''+
		''INNER JOIN PNATURE P6 ON L6.SURFACE=P6.NATURE AND ''+ case @id_client when 3 then '' P6.CNATURE LIKE ''''%PARKING%'''' '' else '' P6.UNITE=2 '' end + '' WHERE A6.CAFFECT=''''V'''' AND A6.IDPROPRIETE=P.PROPRIETE ''+
		''AND A6.DDEBUT<=GETDATE() AND (A6.DFIN>GetDate() OR A6.DFIN IS NULL)),0) ''+
		'' FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) ''
		exec(@query_sql);
END
		
BEGIN SET @script_section = ''AssetTxOcc''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetTxOcc=(CASE ISNULL(AssetSurfTotM2,0) WHEN 0 THEN NULL ELSE AssetSurfLoueM2/AssetSurfTotM2 END)''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''AssetTxVac''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET AssetTxVac=(CASE ISNULL(AssetSurfTotM2,0) WHEN 0 THEN NULL ELSE 1-(AssetSurfLoueM2/AssetSurfTotM2) END)'';
	exec(@query_sql);
END

BEGIN SET @script_section = ''GestionId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET GestionId=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 2 THEN (SELECT CASE WHEN LEN(RTRIM(GP.GROUPE))<=3 THEN ''''1-EXPDIR''''  WHEN RTRIM(GP.GROUPE) IN (''''7777'''', ''''9999'''') THEN ''''2-DEV'''' WHEN RTRIM(GP.GROUPE) IN (''''8888'''') THEN ''''3-ACQUIS'''' ELSE ''''4-AUTRE'''' END FROM PROPRIET P LEFT JOIN GROUPEP GP ON P.GROUPE=GP.GROUPE WHERE P.PROPRIETE=CodeActif) ''+
		''WHEN 3 THEN (SELECT ISNULL((SELECT TOP 1 CODMAND FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND M.CADFIN IS NULL ORDER BY M.CADFIN DESC),'''''''') FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)'' + 
		''ELSE NULL END''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''GestionLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET GestionLib=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 2 THEN (SELECT CASE WHEN LEN(RTRIM(GP.GROUPE))<=3 THEN ''''En exploitation directe''''  WHEN RTRIM(GP.GROUPE) IN (''''7777'''', ''''9999'''') THEN ''''En développement'''' WHEN RTRIM(GP.GROUPE) IN (''''8888'''') THEN ''''En Acquisition'''' ELSE ''''Autre'''' END FROM PROPRIET P LEFT JOIN GROUPEP GP ON P.GROUPE=GP.GROUPE WHERE P.PROPRIETE=CodeActif) ''+
		''WHEN 3 THEN (SELECT ISNULL((SELECT TYPE FROM PMAND PM WHERE PM.NATMAND=(SELECT TOP 1 CODMAND FROM MANDAT M WHERE M.PROPRIETE=P.PROPRIETE AND M.CADFIN IS NULL ORDER BY M.CADFIN DESC)),'''''''') FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)'' + 
		''ELSE NULL END''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FinLoyer''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinLoyer=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN ''+
		''(ISNULL((SELECT SUM(ISNULL(ECHFIN.MANNUEL,0)) FROM ECHFIN INNER JOIN BAIL ON ECHFIN.BAIL=BAIL.BAIL AND ECHFIN.DDEBUT <= GETDATE() AND ECHFIN.DFIN > GETDATE() ''+
		''INNER JOIN PROPRIET P2 ON BAIL.PROPRIETE=P2.PROPRIETE AND P2.PROPRIETE=CodeActif INNER JOIN EVENT ON ECHFIN.EVENEMENT=EVENT.EVENEMENT AND EVENT.CTYPE=''''LOYER''''),0)) ''+
		''ELSE ''+
		''(ISNULL((SELECT SUM(ISNULL(LOYERACT,0)) FROM BAIL B1 WHERE (B1.DRESILIAT > GetDate() OR B1.DRESILIAT IS NULL) AND B1.PROPRIETE=CodeActif),0)) END''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FinDg''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinDg=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN ''+
		''(ISNULL((SELECT SUM(ISNULL(ECHFIN.MANNUEL,0)) FROM ECHFIN INNER JOIN BAIL ON ECHFIN.BAIL=BAIL.BAIL AND ECHFIN.DDEBUT <= GETDATE() ''+
		''INNER JOIN PROPRIET P2 ON BAIL.PROPRIETE=P2.PROPRIETE AND P2.PROPRIETE=CodeActif INNER JOIN EVENT ON ECHFIN.EVENEMENT=EVENT.EVENEMENT AND EVENT.CTYPE=''''DG''''),0)) ''+
		''ELSE ''+
		''(ISNULL((SELECT SUM(ISNULL(DGACTU,0)) FROM BAIL B1 WHERE (B1.DRESILIAT > GetDate() OR B1.DRESILIAT IS NULL) AND B1.PROPRIETE=CodeActif),0)) END''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FinBalanceAg''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBalanceAg=''+
		''(ISNULL((SELECT SUM(ISNULL(TTC,0))-SUM(ISNULL(REGLE,0)) FROM FACTG FG  ''+
		''INNER JOIN BAIL B3 ON FG.BAIL=B3.BAIL '' +
		''WHERE FG.DEXIGIBLE < GetDate() AND (B3.DRESILIAT > GetDate() OR B3.DRESILIAT IS NULL) AND FG.FACTURE IS NOT NULL AND B3.PROPRIETE=CodeActif),0)) ''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FinBudgetCharge''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBudgetCharge=''+
	''(ISNULL((SELECT SUM(ISNULL(BD1.MPREV,0)) ''+
	''FROM BUDGDATACHG BD1 ''+
	''INNER JOIN BUDGREV BD2 ON BD1.IDBUDGREV = BD2.IDBUDGREV INNER JOIN BUDGET BD3 ON BD2.IDBUDGET = BD3.IDBUDGET INNER JOIN BUDGEXER BD4 ON BD3.IDBUDGEXER = BD4.IDBUDGEXER ''+
	''INNER JOIN PROPRIET PTE ON BD4.IDPROPRIETE = PTE.PROPRIETE AND PTE.PROPRIETE = CodeActif INNER JOIN PROPRIO STE ON PTE.CGESTION = STE.PROPRIO INNER JOIN IMMEUBLE IMM ON PTE.IMMEUBLE=IMM.IMMEUBLE ''+
	''INNER JOIN INTERNE INT ON IMM.GROUPE=INT.CODE INNER JOIN PPDEPENS PPD ON BD1.IDPPDEPENS=PPD.PDEPENSE WHERE BD4.NANNEE = DATEPART(YEAR,GetDate())),0))''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FinBudgetEngage''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBudgetEngage=''+
	''(ISNULL((SELECT  ''+
	''SUM(ISNULL(CTRAFF.MHT,0)) as [HT] ''+
	''FROM CTRAFF,CTRREV,CTRPROP,CONTRAT ''+
	''WHERE CTRPROP.IDCONTRAT=CONTRAT.IDCONTRAT AND ''+
	''CTRPROP.IDCONTRAT=CTRREV.IDCONTRAT AND CTRAFF.IDCTRREV=CTRREV.IDCTRREV AND ''+
	''(YEAR(CTRAFF.DFIN)=YEAR(GetDate()) OR YEAR(CTRAFF.DFIN) IS NULL) AND ''+ 
	''(YEAR(DRESILIATION) < YEAR(GetDate()) OR DRESILIATION IS NULL) AND  ''+
	''CTRPROP.PROPRIETE=CodeActif ''+
	''GROUP BY CTRPROP.PROPRIETE),0))''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FinBudgetRealise''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBudgetRealise=''+
	''(ISNULL((SELECT SUM(ISNULL(DD.HT,0)) FROM DEPENSED DD ''+
	''INNER JOIN DEPENSEG DG ON DG.SCPI=DD.SCPI AND DG.REFERENCE=DD.REFERENCE AND DG.STATUT<>''''A'''' AND DG.TYPDEPENS<>''''O'''' ''+
	''INNER JOIN PROPRIET PTE ON DG.PROPRIETE = PTE.PROPRIETE AND PTE.PROPRIETE = CodeActif INNER JOIN PROPRIO STE ON PTE.CGESTION = STE.PROPRIO ''+
	''INNER JOIN IMMEUBLE IMM ON PTE.IMMEUBLE=IMM.IMMEUBLE INNER JOIN INTERNE INT ON IMM.GROUPE=INT.CODE ''+
	''INNER JOIN PPDEPENS PPD ON DD.PDEPENSE=PPD.PDEPENSE AND ISBUDGET=''''O'''' ''+
	''LEFT JOIN CONTRAT CTR ON DG.TYPCOD=CTR.IDCONTRAT WHERE DATEPART(YEAR,DD.DDEBUT) = DATEPART(YEAR,GetDate())),0))''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''ExpertiseAnnee''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET ExpertiseAnnee=''+
		''(SELECT CAST(YEAR(EDATE) as CHAR(4)) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif  ''+
		''AND EXPERTIS.ANNEEREF=(SELECT MAX(EXPERTIS.ANNEEREF) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif) ''+
		''AND EXPERTIS.LIGNE=(SELECT MAX(EXPERTIS.LIGNE) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif  ''+
		''AND EXPERTIS.ANNEEREF=(SELECT MAX(EXPERTIS.ANNEEREF) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif))) ''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''ExpertiseValHf''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET ExpertiseValHf=''+
		''(SELECT ISNULL(MONTHF,0) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif  ''+
		''AND EXPERTIS.ANNEEREF=(SELECT MAX(EXPERTIS.ANNEEREF) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif) ''+
		''AND EXPERTIS.LIGNE=(SELECT MAX(EXPERTIS.LIGNE) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif  ''+
		''AND EXPERTIS.ANNEEREF=(SELECT MAX(EXPERTIS.ANNEEREF) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif))) ''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''ExpertiseValFi''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET ExpertiseValFi=''+
		''(SELECT ISNULL(MONTFI,0) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif  ''+
		''AND EXPERTIS.ANNEEREF=(SELECT MAX(EXPERTIS.ANNEEREF) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif) ''+
		''AND EXPERTIS.LIGNE=(SELECT MAX(EXPERTIS.LIGNE) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif  ''+
		''AND EXPERTIS.ANNEEREF=(SELECT MAX(EXPERTIS.ANNEEREF) FROM EXPERTIS WHERE EXPERTIS.PROPRIETE=CodeActif))) ''; 
	exec(@query_sql);
END

	--TypeSurface

--BEGIN SET @script_section = ''fk_Pregion_IdRegion''
--if @debug_mode = 1 Print @script_section
--		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET fk_Pregion_IdRegion=''+
--		''CASE ''+cast(@id_client as varchar(80))+''  ''+
--			''WHEN 3 THEN ISNULL((SELECT ''+@base_mci+''.dbo.removeStringCharacters(ID_REG,''''-,.&/"'''''''''''''''''''') FROM  ''+@base_mci+''..param_region WHERE ID_REG=(SELECT ID_REG FROM  ''+@base_mci+''..param_departement WHERE ISNULL(RTRIM(LEFT(CP,2)),''''99'''')=RTRIM(RIGHT(''''00''''+LEFT(ID_DEPT,2),2)) COLLATE French_CI_AS) COLLATE French_CI_AS),'''''''') WHERE LEFT(CP,2)<>''''97'''')''+
--		''ELSE NULL END''
--	exec(@query_sql); 
--END

--BEGIN SET @script_section = ''fk_Pdept_IdDept''
--if @debug_mode = 1 Print @script_section
--		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET fk_Pdept_IdDept=''+
--		''CASE ''+cast(@id_client as varchar(80))+''  ''+
--			''WHEN 3 THEN ISNULL((SELECT ''+@base_mci+''.dbo.removeStringCharacters(ID_DEPT,''''-,.&/"'''''''''''''''''''') FROM  ''+@base_mci+''..param_departement WHERE ISNULL(RTRIM(LEFT(CP,2)),''''99'''')=RTRIM(RIGHT(''''00''''+LEFT(ID_DEPT,2),2)) COLLATE French_CI_AS),'''''''')  WHERE LEFT(CP,2)<>''''97'''')''+
--		''ELSE NULL END''
--	exec(@query_sql); 
--END


--BEGIN SET @script_section = ''fk_Pimmostat_IdImmostat''
--if @debug_mode = 1 Print @script_section
--		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET fk_Pimmostat_IdImmostat=''+
--		''CASE ''+cast(@id_client as varchar(80))+''  ''+
--			''WHEN 3 THEN ISNULL(''+@base_mci+''.dbo.removeStringCharacters((SELECT  ''+@base_mci+''.dbo.codepostal_immostat_Z2(LEFT(CP,2))),''''-,.&/"''''''''''''''''''''),'''''''')''+
--		''ELSE NULL END''
--	exec(@query_sql); 
--END

--Description1
--Description2
BEGIN SET @script_section = ''Description2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET Description2=''+
	''ISNULL((SELECT CASE WHEN GEST.PLEINEPRO=''''O'''' THEN ''''Pleine Propiété (''''+CAST(GEST.ANNEE AS VARCHAR(4))+'''')''''''+ 
	'' ELSE CASE WHEN GEST.COPRO=''''O'''' Then ''''Copropriété (''''+CAST(GEST.ANNEE AS VARCHAR(4))+'''')'''' ELSE ''''Non Renseigné'''' END END''+
	'' FROM GESTION GEST WHERE GEST.PROPRIETE=CodeActif AND GEST.ANNEE = (SELECT MAX(GEST2.ANNEE) FROM GESTION GEST2 WHERE GEST2.PROPRIETE=GEST.PROPRIETE AND GEST2.ANNEE <= DATEPART(YEAR,GETDATE()))''+
	'' ),''''Non Renseigné'''')''; 
	if @debug_mode = 1 Print @query_sql
	exec(@query_sql);
END
--Description3

BEGIN SET @script_section = ''OpeDateSign''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET OpeDateSign=''+
	''(SELECT P.ADATE FROM PROPRIET P WHERE P.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END

		--OpeDatePconst
		--OpeDateOuverture
		--OpeDureeConst


BEGIN SET @script_section = ''MandatType''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatType=''+
	''(SELECT ISNULL(M.NATMAND,''''SM'''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''MandatLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatLib=''+
	''(SELECT ISNULL(PM.TYPE,''''Sans mandat'''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''MandatDateEffet''
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatDateEffet=''+
	''(SELECT ISNULL(CAST(M.CADEFFET as VARCHAR(80)),'''''''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''MandatDateFin''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatDateFin=''+
	''(SELECT ISNULL(CAST(M.CADFIN as VARCHAR(80)),'''''''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''MandatNumero''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatNumero=''+
	''(SELECT ISNULL(M.NUMMAND,'''''''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END		

BEGIN SET @script_section = ''MandatPreavis''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatPreavis=''+
	''(SELECT ISNULL(CAST(M.CAPREAVIS as VARCHAR(80)),'''''''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END		

BEGIN SET @script_section = ''MandatDuree''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET MandatDuree=''+
	''(SELECT ISNULL(CAST(((ISNULL(M.CADUREE,0)*12)+ISNULL(M.CADUREE2,0)) as VARCHAR(80)),'''''''') FROM MANDAT M LEFT JOIN PMAND PM ON M.NATMAND=PM.NATMAND WHERE (M.CADFIN IS NULL OR M.CADFIN > GetDate()) AND M.PROPRIETE=CodeActif)''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''FiscaActif''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FiscaActif=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
		''WHEN 3 THEN (SELECT CASE PTVA.TVA WHEN 8 THEN ''''TTC'''' ELSE ''''HT'''' END FROM PROPRIET P LEFT JOIN PTVA PTVA ON P.TVA=PTVA.TVA WHERE P.PROPRIETE=CodeActif)'' + 
		''ELSE ''''HT'''' END''; 
	exec(@query_sql);
END

BEGIN SET @script_section = ''Icpe''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET Icpe=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT PENVCHOIX.TLIBELLE FROM PROPENV LEFT JOIN PENVCHOIX ON PROPENV.IDPENVCHOIX=PENVCHOIX.IDPENVCHOIX WHERE PROPENV.IDPENVIRONNEMENT=118 AND PROPENV.IDPROPRIETE=CodeActif)''+
			''WHEN 44 THEN (SELECT PENVCHOIX.TLIBELLE FROM PROPENV LEFT JOIN PENVCHOIX ON PROPENV.IDPENVCHOIX=PENVCHOIX.IDPENVCHOIX WHERE PROPENV.IDPENVIRONNEMENT=118 AND PROPENV.IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
exec(@query_sql);
END

BEGIN SET @script_section = ''Dta''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET Dta=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT PENVCHOIX.TLIBELLE FROM PROPENV LEFT JOIN PENVCHOIX ON PROPENV.IDPENVCHOIX=PENVCHOIX.IDPENVCHOIX WHERE PROPENV.IDPENVIRONNEMENT=117 AND PROPENV.IDPROPRIETE=CodeActif)''+
			''WHEN 44 THEN (SELECT PENVCHOIX.TLIBELLE FROM PROPENV LEFT JOIN PENVCHOIX ON PROPENV.IDPENVCHOIX=PENVCHOIX.IDPENVCHOIX WHERE PROPENV.IDPENVIRONNEMENT=117 AND PROPENV.IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
exec(@query_sql);
END

BEGIN
SET @script_section = ''Add''''s on 02.03''
if @debug_mode = 1 Print @script_section
SET @mci_ver = ''02.03'';
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_actif ADD Latitude varchar(11), Longitude varchar(11);''
	exec(@query_sql);
	
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_actif ADD libretexte1 varchar(255), libretexte2 varchar(255), libretexte3 varchar(255), libretexte4 varchar(255), libretexte5 varchar(255), libretexte6 varchar(255), libretexte7 varchar(255), libretexte8 varchar(255), libretexte9 varchar(255), libretexte10 varchar(255);''
	exec(@query_sql);
	
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_actif ADD librenumerique1 decimal(18,2), librenumerique2 decimal(18,2), librenumerique3 decimal(18,2), librenumerique4 decimal(18,2), librenumerique5 decimal(18,2);''
	exec(@query_sql);

	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_actif ADD libredate1 date, libredate2 date, libredate3 date, libredate4 date, libredate5 date;''
	exec(@query_sql);

	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET mvi=''''''+@mci_ver+'''''''';
	exec(@query_sql);
END

	BEGIN SET @script_section = ''Longitude''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET Longitude=''+
		''(SELECT LEFT(TVALEUR,11) FROM PROPCARAC WHERE IDPROPRIETE=CodeActif AND IDPCARACTERISTIQUE=123)''; 
		exec(@query_sql);
	END

	BEGIN SET @script_section = ''Latitude''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET Latitude=''+
		''(SELECT LEFT(TVALEUR,11) FROM PROPCARAC WHERE IDPROPRIETE=CodeActif AND IDPCARACTERISTIQUE=124)''; 
		exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 1''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte1=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=1 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 2''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte2=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=2 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 3''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte3=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=3 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 4''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte4=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=4 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 5''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte5=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=5 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 6''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte6=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=6 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 7''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte7=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=7 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 8''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte8=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=8 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Texte Libre 9''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte9=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=9 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	exec(@query_sql);
	END

BEGIN SET @script_section = ''Numeric Libre 1''
if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET librenumerique1=''+
		''CASE ''+cast(@id_client as varchar(80))+
		''WHEN 3 THEN ''+
		''(SELECT ISNULL((SELECT ISNULL(APRIXNET,0) FROM PROPINFO WHERE PROPINFO.IDPROPRIETE=P.PROPRIETE),'''''''') FROM PROPRIET P WHERE P.PROPRIETE=CodeActif) '' +
		''ELSE ''''0'''' END'';
		exec(@query_sql);
	END

if @type=1 
BEGIN
	SET @query_sql = ''SELECT * FROM ''+@base+''..myrem_actif'';
		exec(@query_sql);
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_actif'';
--		exec(@query_sql);
END', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [2-LOTS]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'2-LOTS', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';


-- STRUCTURES
SET @script_section = ''Création de la table temporaire 02.02''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_lot'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_lot;
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.02'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_lot ('' +
		''mvi varchar (50) NOT NULL,'' +
		''CodeSource varchar(255) NOT NULL,'' +
		''CodeLot varchar(40) NOT NULL,'' +
		''Libelle varchar(255) NOT NULL,'' +
		''fk_Actif_CodeActif VARCHAR (100) NOT NULL,'' +
		''TypeId varchar(100),'' +
		''TypeLib varchar(100),'' +
		''DispoDate date,'' +
		''DispoOK varchar(1),'' +
		''DpeDate date,'' +
		''DpeOk varchar(1),'' +
		''DpeConsoVal integer,'' +
		''DpeConsoClasse varchar(1),'' +
		''DpeGesVal integer,'' +
		''DpeGesClasse varchar(1),'' +
		''AssetSurfTotM2 numeric,'' +
		''AssetSurfTotU integer,'' +
		''AssetSurfLoueM2 numeric,'' +
		''AssetSurfLoueU integer,'' +
		''AssetSurfVacM2 numeric,'' +
		''AssetSurfVacU integer,'' +
		''FinLoyer numeric,'' +
		''FinCharge numeric,'' +
		''FinTfonciere numeric,'' +
		''FinTbureau numeric,'' +
		''FinTlocidf numeric,'' +
		''DpeScreenNote numeric,'' +
		''TypeSurface varchar(1),'' +
		''GroupementId varchar(100),'' +
		''GroupementLib varchar(100)'' +
		'');''
	exec(@query_sql);
END
SET @script_section = ''Mise en place PK 02.02''
BEGIN
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_lot ADD PRIMARY KEY (CodeLot, fk_Actif_CodeActif, CodeSource)''
	exec(@query_sql);
END

-- DONNEES
SET @script_section = ''Peuplement PK + base : mvi, CodeLot, Libelle, fk_Actif_CodeActif, CodeSource''
BEGIN
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_lot (mvi, CodeSource, CodeLot, Libelle, fk_Actif_CodeActif, DpeScreenNote) '' +
		''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''',LOT.LOT+'''' - ''''+ISNULL(LAF.IDBAIL,''''VACANT'''')+'''' - ''''+ISNULL(CAST(LAF.IDLAFFECT as VARCHAR(18)),''''IDLAFFECT''''), ''''Lot ''''+LOT.LOT, LAF.IDPROPRIETE, LAF.IDLAFFECT FROM LAFFECT LAF ''+
			''INNER JOIN ''+@base+''..myrem_actif P ON LAF.IDPROPRIETE=P.CodeActif ''+
			''INNER JOIN LOT LOT ON LAF.IDPROPRIETE=LOT.PROPRIETE AND LAF.IDLOT=LOT.LOT ''+
			''WHERE LAF.DDEBUT <= GETDATE() AND (LAF.DFIN>GETDATE() OR LAF.DFIN IS NULL) AND LAF.CAFFECT IN (''''V'''',''''L'''')''
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

-- Alimentation des données
BEGIN SET @script_section = ''TypeId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET TypeId=''+
	''(SELECT L.SURFACE FROM LOT L WHERE L.PROPRIETE=fk_Actif_CodeActif AND L.LOT=LEFT(CodeLot,8))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''TypeLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET TypeLib=''+
	''(SELECT PNAT.CNATURE FROM LOT L INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE WHERE L.PROPRIETE=fk_Actif_CodeActif AND L.LOT=LEFT(CodeLot,8))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''GroupementId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET GroupementId=''+
	''NULL'';
exec(@query_sql);
END

BEGIN SET @script_section = ''GroupementLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET GroupementLib=''+
	''NULL'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DispoDate''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET DispoDate=''+
	''(SELECT CASE LAF.CAFFECT '' + 
		''WHEN ''''V'''' THEN LAF.DDEBUT  '' +
		''WHEN ''''L'''' THEN ISNULL(LAF.DFIN,(SELECT CASE WHEN B.DFINBAIL<=GetDate() THEN DATEADD(MONTH,B.DPREAVIS,GetDate()) ELSE B.DFINBAIL END FROM BAIL B WHERE B.BAIL=LAF.IDBAIL))  '' +
		''ELSE NULL END FROM LAFFECT LAF WHERE LAF.IDLAFFECT=DpeScreenNote)'';
if @debug_mode = 1 Print @query_sql
exec(@query_sql);
END

BEGIN SET @script_section = ''DispoOK''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET DispoOK=''+
	''(SELECT CASE LAF.CAFFECT WHEN ''''V'''' THEN ''''O'''' ELSE ''''N'''' END FROM LAFFECT LAF WHERE LAF.IDLAFFECT=DpeScreenNote)'';
exec(@query_sql);
END

		--''DpeDate date,'' +
		--''DpeOk varchar(1),'' +
		--''DpeConsoVal integer,'' +
		--''DpeConsoClasse varchar(1),'' +
		--''DpeGesVal integer,'' +
		--''DpeGesClasse varchar(1),'' +

BEGIN SET @script_section = ''AssetSurfTotM2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET AssetSurfTotM2=''+
	--''CASE ''+cast(@id_client as varchar(80))+'' ''+
	--''WHEN 3 THEN '' +
	''(SELECT SUM(CASE PNAT.UNITE WHEN 2 THEN 0 ELSE ISNULL(LAF.NSURFACEAFF,0) END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.IDLAFFECT=DpeScreenNote) '' --+
	--''END'';
exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfTotU''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET AssetSurfTotU=''+
	--''CASE ''+cast(@id_client as varchar(80))+'' ''+
	--''WHEN 3 THEN 0 '' +
	''(SELECT SUM(CASE PNAT.UNITE WHEN 1 THEN 0 ELSE ISNULL(LAF.NSURFACEAFF,0) END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.IDLAFFECT=DpeScreenNote) '' --+
	--''END'';
exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfLoueM2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET AssetSurfLoueM2=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
	''WHEN 3 THEN '' +
	''(SELECT SUM(CASE LAF.CAFFECT WHEN ''''L'''' THEN CASE L.GESTION WHEN ''''N'''' THEN ''+
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''0 ''+
		 ''ELSE L.PONDEREE END '' +
		 ''WHEN ''''P'''' THEN '' +
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''0 '' +
		 ''ELSE ((LAF.NSURFACEAFF*L.PONDEREE)/LAF.NSURFACELOT) END ''+
	''END ELSE 0 END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.IDLAFFECT=DpeScreenNote) '' +

	''ELSE (SELECT SUM(CASE PNAT.UNITE WHEN 2 THEN 0 ELSE ISNULL(LAF.NSURFACEAFF,0) END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''L'''' AND LAF.IDLAFFECT=DpeScreenNote) '' +
	''END'';
exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfLoueU''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET AssetSurfLoueU=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
	''WHEN 3 THEN '' +
	''(SELECT SUM(CASE LAF.CAFFECT WHEN ''''L'''' THEN CASE L.GESTION WHEN ''''N'''' THEN ''+
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''CASE WHEN PNAT.UNITE=2 THEN L.UTILE WHEN PNAT.UNITE=1 THEN L.PONDEREE ELSE LAF.NSURFACEAFF END ''+
		 ''ELSE 0 END '' +
		 ''WHEN ''''P'''' THEN '' +
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''CASE WHEN PNAT.UNITE=2 THEN ((LAF.NSURFACEAFF*L.UTILE)/LAF.NSURFACELOT) WHEN PNAT.UNITE=1 THEN ((LAF.NSURFACEAFF*L.PONDEREE)/LAF.NSURFACELOT) ELSE LAF.NSURFACEAFF END '' +
		 ''ELSE 0 END ''+
	''END ELSE 0 END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.IDLAFFECT=DpeScreenNote) '' +

	''ELSE (SELECT SUM(CASE PNAT.UNITE WHEN 1 THEN 0 ELSE ISNULL(LAF.NSURFACEAFF,0) END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''L'''' AND LAF.IDLAFFECT=DpeScreenNote) '' +
	''END'';
exec(@query_sql);
END

BEGIN SET @script_section = ''AssetSurfVacM2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET AssetSurfVacM2=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
	''WHEN 3 THEN '' +
	''(SELECT SUM(CASE LAF.CAFFECT WHEN ''''V'''' THEN CASE L.GESTION WHEN ''''N'''' THEN ''+
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''0 ''+
		 ''ELSE L.PONDEREE END '' +
		 ''WHEN ''''P'''' THEN '' +
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''0 '' +
		 ''ELSE ((LAF.NSURFACEAFF*L.PONDEREE)/LAF.NSURFACELOT) END ''+
	''END ELSE 0 END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.IDLAFFECT=DpeScreenNote) '' +
	''ELSE (SELECT SUM(CASE PNAT.UNITE WHEN 2 THEN 0 ELSE ISNULL(LAF.NSURFACEAFF,0) END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''V'''' AND LAF.IDLAFFECT=DpeScreenNote) '' +
	''END'';
exec(@query_sql);
END
		
BEGIN SET @script_section = ''AssetSurfVacU''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET AssetSurfVacU=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
	''WHEN 3 THEN '' +
	''(SELECT SUM(CASE LAF.CAFFECT WHEN ''''V'''' THEN CASE L.GESTION WHEN ''''N'''' THEN ''+
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''CASE WHEN PNAT.UNITE=2 THEN L.UTILE WHEN PNAT.UNITE=1 THEN L.PONDEREE ELSE LAF.NSURFACEAFF END ''+
		 ''ELSE 0 END '' +
		 ''WHEN ''''P'''' THEN '' +
	''CASE WHEN PNAT.CNATURE LIKE ''''%PARKING%'''' THEN	'' +
		''CASE WHEN PNAT.UNITE=2 THEN ((LAF.NSURFACEAFF*L.UTILE)/LAF.NSURFACELOT) WHEN PNAT.UNITE=1 THEN ((LAF.NSURFACEAFF*L.PONDEREE)/LAF.NSURFACELOT) ELSE LAF.NSURFACEAFF END '' +
		 ''ELSE 0 END ''+
	''END ELSE 0 END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''V'''' AND LAF.IDLAFFECT=DpeScreenNote) '' +
	''ELSE (SELECT SUM(CASE PNAT.UNITE WHEN 1 THEN 0 ELSE ISNULL(LAF.NSURFACEAFF,0) END) FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''V'''' AND LAF.IDLAFFECT=DpeScreenNote) '' +
	''END'';
exec(@query_sql);
END

		--''FinLoyer numeric,'' +
		--''FinCharge numeric,'' +
		--''FinTfonciere numeric,'' +
		--''FinTbureau numeric,'' +
		--''FinTlocidf numeric,'' +

BEGIN SET @script_section = ''TypeSurface''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET TypeSurface=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
	''WHEN 3 THEN '' +
	''(SELECT CASE WHEN PNAT.CNATURE NOT LIKE ''''%PARKING%'''' THEN ''''S'''' ELSE ''''U'''' END FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''V'''' AND LAF.IDLAFFECT=DpeScreenNote) ''  +
	''ELSE (SELECT CASE PNAT.UNITE WHEN 1 THEN ''''S'''' ELSE ''''U'''' END FROM LAFFECT LAF ''+
		''INNER JOIN LOT L ON LAF.IDLOT=L.LOT AND LAF.IDPROPRIETE=L.PROPRIETE '' +
		''INNER JOIN PNATURE PNAT ON L.SURFACE=PNAT.NATURE '' +
		'' WHERE LAF.CAFFECT=''''V'''' AND LAF.IDLAFFECT=DpeScreenNote) '' +
	''END'';
exec(@query_sql);
END

	
SET @script_section = ''Add''''s on 02.03''
BEGIN
if @debug_mode = 1 Print @script_section
SET @mci_ver = ''02.03'';
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_lot ADD fk_Bail_CodeBail varchar(255);''
	exec(@query_sql);
	
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_lot ADD libretexte1 varchar(255), libretexte2 varchar(255), libretexte3 varchar(255), libretexte4 varchar(255), libretexte5 varchar(255), libretexte6 varchar(255), libretexte7 varchar(255), libretexte8 varchar(255), libretexte9 varchar(255), libretexte10 varchar(255);''
	exec(@query_sql);
	
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_lot ADD librenumerique1 decimal(18,2), librenumerique2 decimal(18,2), librenumerique3 decimal(18,2), librenumerique4 decimal(18,2), librenumerique5 decimal(18,2);''
	exec(@query_sql);

	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_lot ADD libredate1 date, libredate2 date, libredate3 date, libredate4 date, libredate5 date;''
	exec(@query_sql);

	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET mvi=''''''+@mci_ver+'''''''';
	exec(@query_sql);

END

BEGIN SET @script_section = ''fk_Bail_CodeBail''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET fk_Bail_CodeBail=''+
	''(SELECT IDBAIL FROM LAFFECT LAF WHERE LAF.IDLAFFECT=DpeScreenNote)'';
exec(@query_sql);
END


	BEGIN SET @script_section = ''Texte Libre 1''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET libretexte1=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(L.ETAGE,''''-'''') FROM ''+@base+''..LOT L WHERE L.PROPRIETE=fk_Actif_CodeActif AND L.LOT=LEFT(CodeLot,8))''+
		''ELSE NULL END''
	exec(@query_sql);
	END

	BEGIN SET @script_section = ''Numeric Libre 1''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_lot SET librenumerique1=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN (SELECT ISNULL(L.PONDEREE,0) FROM ''+@base+''..LOT L WHERE L.PROPRIETE=fk_Actif_CodeActif AND L.LOT=LEFT(CodeLot,8))''+
		''ELSE NULL END''
	exec(@query_sql);
	END

-- SELECT * FROM myrem_lot WHERE 1=1 /*DISPO_ok=''N'' AND DISPO_date IS NOT NULL*/ ORDER BY fk_Actif_CodeActif,CodeLot 
--SELECT fk_Actif_CodeActif, CodeLot, (SELECT CASE LAF.CAFFECT WHEN ''V'' THEN LAF.DDEBUT ELSE NULL END FROM LAFFECT LAF WHERE LAF.IDPROPRIETE=fk_Actif_CodeActif AND (LAF.IDLOT+'' - ''+ISNULL(LAF.IDBAIL,''VACANT''))=CodeLot) FROM myrem_lot 
--GROUP BY fk_Actif_CodeActif,CodeLot
--HAVING COUNT(1) >1
--ORDER BY fk_Actif_CodeActif,CodeLot
', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [3-BAIL]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'3-BAIL', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';


-- STRUCTURES



SET @script_section = ''Création de la table temporaire 02.02''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_bail'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_bail;
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.02'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_bail ('' +
		''mvi VARCHAR(50) NOT NULL,''+
		''CodeSource VARCHAR(255) NOT NULL,''+
		''BailCode VARCHAR(100) NOT NULL,''+
		''Libelle VARCHAR(255) NOT NULL,''+
		''fk_Actif_CodeActif VARCHAR(100) NOT NULL,''+
		''fk_Pcncc_IdCncc VARCHAR(100),''+
		''fk_Pnaf_IdNaf VARCHAR(100),''+
		''fk_PindiceCode_IdIndice VARCHAR(100),''+
		''fk_PindiceCode_IdIndiceIni VARCHAR(100),''+
		''LocataireLib VARCHAR(100),''+
		''EnseigneLib VARCHAR(100),''+
		''ActiviteId VARCHAR(100),''+
		''ActiviteLib VARCHAR(200),''+
		''TypeId VARCHAR(100),''+
		''TypeLib VARCHAR(100),''+
		''NatureId VARCHAR(100),''+
		''NatureLib VARCHAR(100),''+
		''Duree DECIMAL(18,2),''+
		''DateDebut DATE,''+
		''DateFin DATE,''+
		''DateNextBreak DATE,''+
		''FinLoyerIni DECIMAL(18,2),''+
		''FinLoyerActuel DECIMAL(18,2),''+
		''FinDgIni DECIMAL(18,2),''+
		''FinDgActuel DECIMAL(18,2),''+
		''TermeId VARCHAR(20),''+
		''TermeLib VARCHAR(20),''+
		''FrequenceId VARCHAR(20),''+
		''FrequenceLib VARCHAR(20),''+
		''SurfaceTotale DECIMAL(18,2),''+
		''FinCharges DECIMAL(18,2),''+
		''FinTaxes DECIMAL(18,2),''+
		''FinDette DECIMAL(18,2),''+
		''RcsNum VARCHAR(100),''+
		''RcsVille VARCHAR(255),''+
		''CofaceScoreRating DECIMAL(18,2),''+
		''CofaceNotation VARCHAR(10),''+
		''ContactLib VARCHAR(100),''+
		''ContactAdd1 VARCHAR(255),''+
		''ContactAdd2 VARCHAR(255),''+
		''ContactCp VARCHAR(20),''+
		''ContactVille VARCHAR(255),''+
		''ContactPays VARCHAR(255),''+
		''ContactTel VARCHAR(100),''+
		''ContactMail VARCHAR(255),''+
		''Comment1 VARCHAR(1000),''+
		''Comment2 VARCHAR(1000),''+
		''Comment3 VARCHAR(1000),''+
		''DpeDate DATE,''+
		''DpeOk VARCHAR(1),''+
		''DpeConsoVal DECIMAL(18,5),''+
		''DpeConsoClasse VARCHAR(1),''+
		''DpeGesVal DECIMAL(18,5),''+
		''DpeGesClasse VARCHAR(1),''+
		''DpeScreenNote DECIMAL(18,5)''+
		'');''
	exec(@query_sql);
END


BEGIN SET @script_section = ''Mise en place PK 02.02''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_bail ADD PRIMARY KEY (CodeSource,BailCode,fk_Actif_CodeActif)''
	exec(@query_sql);
END

BEGIN
SET @script_section = ''Gestion des filtres spécifiques''
if @debug_mode = 1 Print @script_section
	SET @filtre = 
		case @id_client 
			when 3 then '' AND (B.DRESILIAT > GetDate() OR B.DRESILIAT IS NULL)''
			else '' AND 1=1'' END; 
END

-- DONNEES
BEGIN SET @script_section = ''Peuplement PK + base : mvi, CodeSource,BailCode,Libelle,fk_Actif_CodeActif''
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_bail (mvi, CodeSource,BailCode,Libelle,fk_Actif_CodeActif) '' +
		''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''',B.BAIL, REPLACE(B.LIBELLE,''''"'''',''''''''), B.PROPRIETE FROM BAIL B ''+
			''INNER JOIN ''+@base+''..myrem_actif P ON B.PROPRIETE=P.CodeActif ''+
		'' WHERE 1=1''+@filtre 

	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

-- Alimentation des données

		--fk_Pcncc_IdCncc VARCHAR(100),
		--fk_Pnaf_IdNaf VARCHAR(100),

BEGIN SET @script_section = ''fk_PindiceCode_IdIndice''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET fk_PindiceCode_IdIndice=''+
	''(SELECT PTI.TLIBELLE+B.INDICEACT FROM BAIL B LEFT JOIN PTYPINDICE PTI ON B.IDPTYPINDICE=PTI.IDPTYPINDICE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''fk_PindiceCode_IdIndiceIni''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET fk_PindiceCode_IdIndiceIni=''+
	''(SELECT PTI.TLIBELLE+B.INDICEREF FROM BAIL B LEFT JOIN PTYPINDICE PTI ON B.IDPTYPINDICEINITIAL=PTI.IDPTYPINDICE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''LocataireLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET LocataireLib=''+
	''(SELECT L.LIBELLE FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''EnseigneLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET EnseigneLib=''+
	''(SELECT PENS.TLIBELLE FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN PENSEIGNE PENS ON L.IDPENSEIGNE=PENS.IDPENSEIGNE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ActiviteId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ActiviteId=''+
	''(SELECT L.IDPACTIVITE FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN PENSEIGNE PENS ON L.IDPENSEIGNE=PENS.IDPENSEIGNE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ActiviteLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ActiviteLib=''+
	''(SELECT PACT.TLIBPACTIVITE FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN PACTIVITE PACT ON L.IDPACTIVITE=PACT.IDPACTIVITE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''TypeId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET TypeId=''+
	''(SELECT B.TBAIL FROM BAIL B ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''TypeLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET TypeLib=''+
	''(SELECT PTY.CTYPE FROM BAIL B ''+
	 ''LEFT JOIN PTYPE PTY ON B.TBAIL = PTY.TYPE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''NatureId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET NatureId=''+
	''(SELECT B.NATURE FROM BAIL B ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''NatureLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET NatureLib=''+
	''(SELECT PNAT.CNATURE FROM BAIL B ''+
	 ''LEFT JOIN PNATURE PNAT ON B.NATURE = PNAT.NATURE ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''Duree''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET Duree=''+
	''(SELECT B.DUREE FROM BAIL B ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DateDebut''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET DateDebut=''+
	''(SELECT B.DEFFET FROM BAIL B ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DateFin''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET DateFin=''+
	''(SELECT B.DRESILIAT FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''DateNextBreak''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET DateNextBreak=''+
	''CASE ''+cast(@id_client as varchar(80))+'' ''+
	''WHEN 3 THEN '' +
	--''(SELECT ISNULL((SELECT TOP 1 (DPREAVIS) FROM RESIL WHERE RESIL.PROPRIETE=B.PROPRIETE AND RESIL.BAIL=BAIL.BAIL AND RESIL.DRESIL>GETDATE()),DateAdd(Month,B.DPREAVIS,GetDate()) FROM BAIL B ''+
	''(SELECT ISNULL((SELECT TOP 1 (DPREAVIS) FROM RESIL WHERE RESIL.PROPRIETE=B.PROPRIETE AND RESIL.BAIL=B.BAIL AND RESIL.DRESIL>GETDATE()),DateAdd(Month,B.DPREAVIS,GetDate())) FROM BAIL B ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)''+
	''ELSE ''+
	''(SELECT ISNULL((SELECT TOP 1 (DRESIL) FROM RESIL WHERE RESIL.PROPRIETE=B.PROPRIETE AND RESIL.BAIL=B.BAIL AND RESIL.DRESIL>GETDATE()),DateAdd(Month,B.DPREAVIS,GetDate())) FROM BAIL B ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)''+
	''END''
exec(@query_sql);
END

BEGIN SET @script_section = ''FinLoyerIni''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FinLoyerIni=''+
	''(SELECT B.LOYERINI FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FinLoyerActuel''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FinLoyerActuel=''+
	''(SELECT B.LOYERACT FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FinDgIni''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FinDgIni=''+
	''(SELECT B.DGINI FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FinDgActuel''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FinDgActuel=''+
	''(SELECT B.DGACTU FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''TermeId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET TermeId=''+
	''(SELECT B.TERME FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''TermeLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET TermeLib=''+
	''(SELECT CASE B.TERME WHEN ''''A'''' THEN ''''A Echoir'''' WHEN ''''E'''' THEN ''''Echu'''' ELSE ''''Non prévu'''' END FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FrequenceId''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FrequenceId=''+
	''(SELECT B.FREQUENCE FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FrequenceLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FrequenceLib=''+
	''(SELECT CASE B.FREQUENCE WHEN ''''M'''' THEN ''''Mensuel'''' WHEN ''''T'''' THEN ''''Trimestriel'''' WHEN ''''S'''' THEN ''''Semestriel'''' WHEN ''''A'''' THEN ''''Annuel'''' ELSE ''''Non prévu'''' END FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''SurfaceTotale''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET SurfaceTotale=''+
	''(SELECT B.SURFACE FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

		--FinCharges DECIMAL(18,2),
		--FinTaxes DECIMAL(18,2),

BEGIN SET @script_section = ''FinDette''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET FinDette=''+
	''(SELECT (SELECT SUM(ISNULL(D.HT,0))-SUM(ISNULL(D.HTPAYE,0))  ''+
	''FROM FACTD D ''+
	''INNER JOIN FACTG G ON D.NSESSION=G.NSESSION AND D.GROUPE=G.GROUPE AND D.LIGNEG=G.LIGNEG AND G.FACTURE IS NOT NULL ''+
	'' AND G.DEXIGIBLE <= GetDate() '' +
	''AND G.BAIL=B.BAIL) FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode) ''
exec(@query_sql);
END

BEGIN SET @script_section = ''RcsNum''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET RcsNum=''+
	''(SELECT L.RCS FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''RcsVille''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET RcsVille=''+
	''(SELECT L.RCSVILLE FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

		--CofaceScoreRating DECIMAL(18,2),
		--CofaceNotation VARCHAR(10),

BEGIN SET @script_section = ''ContactLib''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactLib=''+
	''(SELECT CT.NOM FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactAdd1''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactAdd1=''+
	''(SELECT CT.ADD1 FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactAdd2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactAdd2=''+
	''(SELECT CT.ADD2 FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactCp''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactCp=''+
	''(SELECT CT.CP FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactVille''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactVille=''+
	''(SELECT CT.VILLE FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactPays''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactPays=''+
	''(SELECT CT.PAYS FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactTel''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactTel=''+
	''(SELECT CT.TEL FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''ContactMail''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET ContactMail=''+
	''(SELECT CT.EMAIL FROM BAIL B ''+
	''INNER JOIN LOCAT L ON B.IDLOCAT=L.IDLOCAT ''+
	''LEFT JOIN CONTACT CT ON L.ADR_FACT=CT.LIGNE AND L.LOCAT=CT.RATTACH AND CT.CTYPE=''''L'''' ''+
	''WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

BEGIN SET @script_section = ''Comment1''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET Comment1=''+
	''(SELECT REPLACE(REPLACE(B.COMMENTAIR,CHAR(10),''''''''),CHAR(13),'''''''') FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)'';
exec(@query_sql);
END

		--Comment2 VARCHAR(1000),
		--Comment3 VARCHAR(1000),

		--DpeDate DATE,
		--DpeOk VARCHAR(1),
		--DpeConsoVal DECIMAL(18,5),
		--DpeConsoClasse VARCHAR(1),
		--DpeGesVal DECIMAL(18,5),
		--DpeGesClasse VARCHAR(1),
		--DpeScreenNote DECIMAL(18,5)


BEGIN
SET @script_section = ''Add''''s on 02.03''
if @debug_mode = 1 Print @script_section
SET @mci_ver = ''02.03'';
	
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_bail ADD libretexte1 varchar(255), libretexte2 varchar(255), libretexte3 varchar(255), libretexte4 varchar(255), libretexte5 varchar(255), libretexte6 varchar(255), libretexte7 varchar(255), libretexte8 varchar(255), libretexte9 varchar(255), libretexte10 varchar(255);''
	exec(@query_sql);
	
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_bail ADD librenumerique1 decimal(18,2), librenumerique2 decimal(18,2), librenumerique3 decimal(18,2), librenumerique4 decimal(18,2), librenumerique5 decimal(18,2);''
	exec(@query_sql);

	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_bail ADD libredate1 date, libredate2 date, libredate3 date, libredate4 date, libredate5 date;''
	exec(@query_sql);

	SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET mvi=''''''+@mci_ver+'''''''';
	exec(@query_sql);
END


	BEGIN SET @script_section = ''Texte Libre 1''
	if @debug_mode = 1 Print @script_section
		SET @query_sql = ''UPDATE ''+@base+''..myrem_bail SET libretexte1=''+
		''CASE ''+cast(@id_client as varchar(80))+''  ''+
			''WHEN 3 THEN ''+
			''(SELECT (SELECT CAST(SUM(ISNULL(BCA1.MCAREEL,0)) as VARCHAR(max))+'''' € (''''+CAST(DATEPART(YEAR,BCA1.DDEBUT) as CHAR(4))+'''')'''' ''+
			''FROM ''+@base+''..BAILCA BCA1 INNER JOIN ''+@base+''..BAIL B1 ON BCA1.BAIL=B1.BAIL ''+
			''WHERE B.BAIL=BCA1.BAIL AND BCA1.MCAREEL IS NOT NULL AND DATEPART(YEAR,BCA1.DDEBUT)=DATEPART(YEAR,GETDATE())-1 ''+
			''GROUP BY B1.PROPRIETE, BCA1.BAIL, DATEPART(YEAR,BCA1.DDEBUT) ''+
			''UNION ALL ''+
			''SELECT CAST(SUM(ISNULL(BCA2.MCAREEL,0)) as VARCHAR(max))+'''' € (''''+CAST(DATEPART(YEAR,BCA2.DDEBUT) as CHAR(4))+'''')''''  ''+
			''FROM ''+@base+''..BAILCA BCA2 INNER JOIN ''+@base+''..BAIL B2 ON BCA2.BAIL=B2.BAIL ''+
			''WHERE B.BAIL=BCA2.BAIL AND BCA2.MCAREEL IS NOT NULL AND DATEPART(YEAR,BCA2.DDEBUT)=DATEPART(YEAR,GETDATE())-2 ''+
			''AND BCA2.BAIL NOT IN (SELECT DISTINCT(BAC0.BAIL) FROM ''+@base+''..BAILCA BAC0 WHERE ISNULL(BAC0.MCAREEL,0)>0 AND DATEPART(YEAR,BAC0.DDEBUT)=DATEPART(YEAR,GETDATE())-1) ''+
			''GROUP BY B2.PROPRIETE, BCA2.BAIL, DATEPART(YEAR,BCA2.DDEBUT)) ''+
			''FROM BAIL B WHERE B.PROPRIETE=fk_Actif_CodeActif AND B.BAIL=BailCode)''+
			--(SELECT ISNULL(INTE.LIBELLE,''''Non Renseigné'''') FROM ''+@base+''..PROPRIETINTSERV PIS INNER JOIN ''+@base+''..INTERNE INTE ON PIS.IDINTERNE = INTE.CODE WHERE PIS.IDSERVICE=1 AND IDPROPRIETE=CodeActif)''+
		''ELSE NULL END''
	if @debug_mode = 1 Print @query_sql
	exec(@query_sql);
	END

-- SELECT * FROM myrem_bail where libretexte1 IS NOT NULL', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [4-BUDGET]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'4-BUDGET', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*
-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';



-- STRUCTURES
SET @script_section = ''Création de la table temporaire 02.04''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_budget'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_budget;
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.04'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_budget ('' +
			''[mvi] varchar (50) NOT NULL,'' +
			''[CodeSource] varchar (50) NOT NULL,'' +
			''[RubriqueId] [varchar](100) NOT NULL,'' +
			''[RubriqueLib] [varchar](100) NULL,'' +
			''[SrubriqueId] [varchar](100) NOT NULL,'' +
			''[SrubriqueLib] [varchar](100) NULL,'' +
			''[Exercice] [char](4) NOT NULL,'' +
			''[BudgetHt] [decimal](18, 2) NULL,'' +
			''[RatioM2] [decimal](18, 2)  NOT NULL,'' +
			''[RealiseHt] [decimal](18, 2) NULL,'' +
			''[NRHt] [decimal](18, 2) NULL,'' +
			''[fk_Actif_CodeActif] [varchar](50) NOT NULL,'' +
			''[TypeId] [varchar](10) NOT NULL,'' +
			''[TypeLib] [varchar](255) NULL,'' +
			'') ON [PRIMARY];''
	exec(@query_sql);
END

BEGIN
SET @script_section = ''Mise en place PK 02.04''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_budget ADD CONSTRAINT PK_MyREM_Budget PRIMARY KEY (CodeSource, RubriqueId, SrubriqueId, Exercice, fk_Actif_CodeActif, TypeId, RatioM2)''
	exec(@query_sql);
END

-- Déclarations spécifiques au Budget
DECLARE @id_bud_modele int;
SET @id_bud_modele = (CASE	WHEN @id_client = 3 THEN 1 -- Avant 3  
							WHEN @id_client = 8 THEN 3  
							WHEN @id_client = 1 THEN 3  
							WHEN @id_client = 44 THEN 6  
							WHEN @id_client = 2  OR @id_client = 5  OR @id_client = 9 THEN 2  
							ELSE  1 END);
SET @forcer_bud_modele = (CASE	--WHEN @id_client = 8 THEN ''N''  
								WHEN @id_client = 1 OR @id_client = 2 OR @id_client = 3 OR @id_client = 5  OR @id_client = 9  OR @id_client = 44 THEN ''O''  
								ELSE  ''N'' END);
DECLARE @id_annee_Actu Char(4);
DECLARE @id_annee_Last Char(4);
-- Année du budget : l''année en court 
SET @id_annee_Actu = CONVERT (CHAR(4),YEAR(GETDATE()))
SET @id_annee_Last = CONVERT (CHAR(4), (CONVERT (INT,@id_annee_Actu )-1))


-- Nettoyage des données de la table pour le couple client / source Type TVX
SET @query_sql = ''DELETE FROM ''+@base+''..myrem_budget where  [TypeId] =''''TVX'''' AND CodeSource=''''''+cast(@id_source as varchar(80))+''''''''
	if @debug_mode = 1 PRINT @query_sql;		
exec(@query_sql);


-- Execution Insertion Budget TRAVAUX
SET @query_sql_1 = 
	''INSERT INTO '' +@base+''..myrem_budget ''+
	''SELECT ''''''+@mci_ver+'''''','''''' +
	cast(@id_source as varchar(80))+'''''', ''+
	''CH.TDESC as [RubriqueId], ''+
	''CH.TDESC as [RubriqueLib], ''+
	''CH.TLIBELLE as [SrubriqueId], ''+
	''CH.TLIBELLE as [SrubriqueLib], ''+
	''CAST(DATEPART(YEAR,CHB.DDEBUT) as VARCHAR(4)) as [Exercice], ''+
	''CHB.HT as [BudgetHt], ''+-- Est le montant du Prévisionnel : [MRVUE_CHANTIER_BUD] 
	''CH.IDGTCHANTIER as [RatioM2], ''+-- Est le Ration Budget / Surface Totale. Dans la première boucle sert à l''ID unique du chantier (IDGTCHANTIER) 
	''0 as [RealiseHt], ''+-- Est le Mt Réalisé [MRVUE_OS] MTHTREGLE=REALISE 
	''0 as [NRHt], ''+-- Doit devenir l''''engagé [MRVUE_OS] MTINI = ENGAGE
	''CH.IDPROPRIETE as [fk_Actif_CodeActif], ''+
	''''''TVX'''' as [TypeId], ''+
	''''''Budget CAPEX'''' as [TypeLib] ''+
	''FROM '' +@base+''..MRVUE_CHANTIER_BUD CHB ''+
	''	INNER JOIN '' +@base+''..MRVUE_CHANTIER CH ON CHB.IDGTCHANTIER = CH.IDGTCHANTIER '' +
	'' WHERE DATEPART(YEAR,CHB.DDEBUT)>=DATEPART(YEAR,GetDate())-3 AND EXISTS (SELECT * FROM '' +@base+''..myrem_actif WHERE (CH.IDPROPRIETE)='' +@base+''..myrem_actif.CodeActif COLLATE French_CI_AS AND ''+
	@base+''..myrem_actif.CodeSource=''''''+CAST(@id_source as VARCHAR(80))+'''''') ''
	if @debug_mode = 1 PRINT @query_sql_1;	
	exec(@query_sql_1);

	-- Ensuite MAJ des Engagé
	SET @query_sql_2 = 
	''UPDATE '' +@base+''..myrem_budget SET [NRHt] = ''+
	'' (SELECT ISNULL(SUM(ISNULL(OS.MHTINIT,0)),0) FROM '' +@base+''..MRVUE_OS OS WHERE OS.IDPROPRIETE = fk_Actif_CodeActif AND OS.IDGTCHANTIER = RatioM2 AND CAST(DATEPART(YEAR,OS.DOS) as VARCHAR(4)) = Exercice) ''+
	'' WHERE  [TypeId] =''''TVX'''' ''
	if @debug_mode = 1 PRINT @query_sql_2;	
	exec(@query_sql_2);

	-- Ensuite MAJ des Réalisés
	SET @query_sql_3 = 
	'' UPDATE '' +@base+''..myrem_budget SET [RealiseHt] = ''+
	'' (SELECT ISNULL(SUM(ISNULL(OS.MHTREGLE,0)),0) FROM '' +@base+''..MRVUE_OS OS WHERE OS.IDPROPRIETE = fk_Actif_CodeActif AND OS.IDGTCHANTIER = RatioM2 AND CAST(DATEPART(YEAR,OS.DOS) as VARCHAR(4)) = Exercice) ''+
	'' WHERE  [TypeId] =''''TVX'''' ''
	if @debug_mode = 1 PRINT @query_sql_3;
	exec(@query_sql_3);


-- Nettoyage des données de la table pour le couple client / source Type CHG
SET @query_sql = ''DELETE FROM ''+@base+''..myrem_budget where  [TypeId] =''''CHG'''' AND CodeSource=''''''+cast(@id_source as varchar(80))+''''''''
	if @debug_mode = 1 PRINT @query_sql;		
exec(@query_sql);

	
BEGIN
SET @script_section = ''Modification en place PK 02.04''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_budget DROP CONSTRAINT PK_MyREM_Budget''
	exec(@query_sql);
END
-- Execution Insertion Budget de Charge SELECT * FROM BUDGMODLDET 
SET @query_sql_1 = 
	''INSERT INTO '' +@base+''..myrem_budget ''+
	''SELECT ''''''+@mci_ver+'''''','''''' +
	cast(@id_source as varchar(80))+'''''', ''+
	''BUDG.CLE as [RubriqueId], ''+
	''(SELECT ISNULL(TDESC,''''Non Trouvé'''') FROM BUDGMODLDET WHERE IDBUDGMODL=2 AND NNIV2 = 0 AND NNIV1 = (SELECT NNIV1 FROM BUDGMODLDET WHERE IDBUDGMODL=2 AND IDPCCHARGE=BUDG.CLE AND IDPPDEPENS = BUDG.POSTE)) as [RubriqueLib], ''+
	''BUDG.POSTE as [SrubriqueId], ''+
	''CASE WHEN  ''+
		''(SELECT TOP 1 N2.NNIV3 FROM BUDGMODLDET N2 WHERE N2.NNIV2 = (SELECT DISTINCT(NNIV2) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND	IDBUDGMODL=2 AND IDPCCHARGE=N2.IDPCCHARGE AND IDPPDEPENS = N2.IDPPDEPENS)  ''+
		''AND  N2.NNIV1 = (SELECT DISTINCT(NNIV1) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND IDBUDGMODL=2 AND IDPCCHARGE=N2.IDPCCHARGE AND IDPPDEPENS = N2.IDPPDEPENS) AND N2.IDPCCHARGE=BUDG.CLE AND N2.IDPPDEPENS = BUDG.POSTE ) > 0  ''+
		''THEN  ''+
			''ISNULL((SELECT TOP 1 ISNULL(N2.TDESC,''''Non Trouvé'''') FROM BUDGMODLDET N2 WHERE N2.FOPEN=''''O'''' AND N2.NNIV3 = 0 AND N2.NNIV1 = (SELECT DISTINCT(NNIV1) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND IDBUDGMODL=2 AND IDPCCHARGE=BUDG.CLE AND IDPPDEPENS = BUDG.POSTE) AND N2.NNIV2 = (SELECT DISTINCT(NNIV2) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND IDBUDGMODL=2 AND IDPCCHARGE=BUDG.CLE AND IDPPDEPENS = BUDG.POSTE)),''''Indeterminé'''') ''+
			''+ ''+
			''ISNULL((SELECT TOP 1 ISNULL( '''' / '''' +N3.TDESC,'''''''') FROM BUDGMODLDET N3 WHERE N3.FOPEN=''''O'''' AND N3.NNIV4 = 0 AND N3.NNIV1 = (SELECT DISTINCT(NNIV1) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND IDBUDGMODL=2 AND IDPCCHARGE=BUDG.CLE AND IDPPDEPENS = BUDG.POSTE) AND N3.NNIV2 = (SELECT DISTINCT(NNIV2) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND IDBUDGMODL=2 AND IDPCCHARGE=BUDG.CLE AND IDPPDEPENS = BUDG.POSTE) AND N3.NNIV3 = (SELECT DISTINCT(NNIV3) FROM BUDGMODLDET WHERE FOPEN=''''O'''' AND IDBUDGMODL=2 AND IDPCCHARGE=BUDG.CLE AND IDPPDEPENS = BUDG.POSTE)),''''Indeterminé'''')	 ''+
		''ELSE LTRIM(RTRIM(BUDG.LCHARGE)) + ''''/'''' + LTRIM(RTRIM(BUDG.LDEPENSE)) END as [SrubriqueLib], ''+
	''BUDG.ANNEE as [Exercice], ''+
	''BUDG.PREV_HT as [BudgetHt], ''+ -- Est le montant du Prévisionnel
	''0 as [RatioM2],  ''+
	''BUDG.REEL_HT as [RealiseHt], ''+ -- Est le Mt Réalisé
	''BUDG.ENGAGE_HT as [NRHt], ''+ --Doit devenir l''engagé
	''BUDG.PROPRIETE as [fk_Actif_CodeActif], ''+
	''''''CHG'''' as [TypeId], ''+
	''''''Budget Charges'''' as [TypeLib] ''+
	''FROM [MRVUE_BUDGET] BUDG WHERE BUDG.ANNEE >= CAST(DATEPART(YEAR,GetDate())-3 as VARCHAR(4)) '' +
	'' AND EXISTS (SELECT * FROM '' +@base+''..myrem_actif WHERE (BUDG.PROPRIETE)='' +@base+''..myrem_actif.CodeActif COLLATE French_CI_AS AND '' +
	@base+''..myrem_actif.CodeSource=''''''+CAST(@id_source as VARCHAR(80))+'''''') ''
		if @debug_mode = 1 PRINT @query_sql_1;	
	exec(@query_sql_1);



--BEGIN
--SET @script_section = ''Modification en place PK 02.04''
--if @debug_mode = 1 Print @script_section
--	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_budget ADD CONSTRAINT PK_MyREM_Budget PRIMARY KEY (CodeSource, RubriqueId, SrubriqueId, Exercice, fk_Actif_CodeActif, TypeId)''
--	exec(@query_sql);
--END



-- MAJ RatioM2
SET @query_sql_3 = 
'' UPDATE '' +@base+''..myrem_budget SET [RatioM2] = [BudgetHt] / ''+
'' CASE ISNULL((SELECT ISNULL([AssetSurfTotM2],1) FROM '' +@base+''..myrem_actif ACT WHERE ACT.[CodeActif] = fk_Actif_CodeActif),1) WHEN 0 THEN 1 ELSE ISNULL((SELECT ISNULL([AssetSurfTotM2],1) FROM '' +@base+''..myrem_actif ACT WHERE ACT.[CodeActif] = fk_Actif_CodeActif),1)  END''--+
--'' WHERE  [TypeId] =''''TVX'''' ''
if @debug_mode = 1 PRINT @query_sql_3;
exec(@query_sql_3);


-- MAJ des Actifs		
BEGIN SET @script_section = ''FinBudgetCharge''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBudgetCharge=''+
	''(SELECT SUM(ISNULL(BUDG.BudgetHt,0)) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif AND BUDG.Exercice=(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FinBudgetEngage''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBudgetEngage=''+
	''(SELECT SUM(ISNULL(BUDG.NRHt,0)) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif AND BUDG.Exercice=(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''FinBudgetRealise''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET FinBudgetRealise=''+
	''(SELECT SUM(ISNULL(BUDG.RealiseHt,0)) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif AND BUDG.Exercice=(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif))'';
exec(@query_sql);
END
	
BEGIN SET @script_section = ''librenumerique1''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET librenumerique1=''+
	''(SELECT SUM(ISNULL(BUDG.BudgetHt,0)) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif AND BUDG.Exercice=(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''librenumerique2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET librenumerique2=''+
	''(SELECT SUM(ISNULL(BUDG.NRHt,0)) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif AND BUDG.Exercice=(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''librenumerique3''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET librenumerique3=''+
	''(SELECT SUM(ISNULL(BUDG.RealiseHt,0)) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif AND BUDG.Exercice=(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif))'';
exec(@query_sql);
END

BEGIN SET @script_section = ''Texte Libre 1''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte1=''+
	''(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''CHG'''' AND BUDG.fk_Actif_CodeActif=CodeActif)''
exec(@query_sql);
END

BEGIN SET @script_section = ''Texte Libre 2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_actif SET libretexte2=''+
	''(SELECT Max(BUDG.Exercice) FROM '' +@base+''..myrem_budget BUDG WHERE BUDG.TypeId=''''TVX'''' AND BUDG.fk_Actif_CodeActif=CodeActif)''
exec(@query_sql);
END
*/', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [5-INTERVENANTS]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'5-INTERVENANTS', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';


-- STRUCTURES



SET @script_section = ''Création de la table temporaire 02.02''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_intervenant'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_intervenant; -- SELECT * FROM myrem_intervenant
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.02'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_intervenant ('' +
		''mvi VARCHAR(50) NOT NULL,''+
		''IdSource VARCHAR(255) NOT NULL,''+
		''CodeIntervenant VARCHAR(100) NOT NULL,''+
		''IdTypeParent VARCHAR(100) NOT NULL,''+
		''Civilite INT NULL,''+
		''Fonction VARCHAR(100) NULL,''+
		''CodeCategorie VARCHAR(100) NOT NULL,''+
		''LibCategorie VARCHAR(100) NULL,''+
		''Nom VARCHAR(255) NULL,''+
		''Prenom VARCHAR(255) NULL,''+
		''Add1 VARCHAR(255) NULL,''+
		''Add2 VARCHAR(255) NULL,''+
		''Add3 VARCHAR(255) NULL,''+
		''Add4 VARCHAR(255) NULL,''+
		''Cp VARCHAR(255) NULL,''+
		''Ville VARCHAR(255) NULL,''+
		''Pays VARCHAR(255) NULL,''+
		''Telephone VARCHAR(255) NULL,''+
		''Mobile VARCHAR(255) NULL,''+
		''Username VARCHAR(255) NULL,''+
		''Email VARCHAR(255) NULL''+
		'');''
	exec(@query_sql);
END


BEGIN SET @script_section = ''Mise en place PK 02.02''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_intervenant ADD PRIMARY KEY (IdSource,CodeIntervenant,IdTypeParent,CodeCategorie)''
	exec(@query_sql);
END

-- DONNEES
BEGIN SET @script_section = ''Peuplement PK + base : mvi, IdSource,CodeIntervenant,IdTypeParent,CodeCategorie''
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_intervenant (mvi, IdSource,CodeIntervenant,IdTypeParent,CodeCategorie) '' +
		''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''',L.LOCAT, ''''LOCATAIRE_ADMIN_[ROLE]'''', ''''LOC'''' FROM LOCAT L ''+
		''WHERE L.IDLOCAT IN (SELECT B.IDLOCAT FROM ''+@base+''..BAIL B INNER JOIN ''+@base+''..myrem_actif P ON B.PROPRIETE=P.CodeActif ''+
		''WHERE (B.DRESILIAT IS NULL OR B.DRESILIAT > GetDate())) ''

	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

-- Alimentation des données
BEGIN SET @script_section = ''Civilité''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Civilite=''+
	''(SELECT CAST(CASE ISNULL(PT.TITRE,1) WHEN 1 THEN 0 WHEN 2 THEN 1 ELSE 0 END as INT) FROM ''+@base+''..LOCAT L ''+
	''LEFT JOIN PTITRE PT ON L.TITRE=PT.TITRE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';

	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

-- Alimentation des données
BEGIN SET @script_section = ''Fonction''
if @debug_mode = 1 Print @script_section
--	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Civilite=''+
--	''(SELECT CAST(CASE ISNULL(PT.TITRE,1) WHEN 1 THEN 0 WHEN 2 THEN 1 ELSE 0 END as INT) FROM ''+@base+''..LOCAT L ''+
--	''LEFT JOIN PTITRE PT ON L.TITRE=PT.TITRE ''+
--	''WHERE L.LOCAT=CodeIntervenant)'';

--	if @debug_mode = 1 PRINT @query_sql;
--exec(@query_sql);
END

-- Alimentation des données
BEGIN SET @script_section = ''Nom''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Nom=''+
	''(SELECT LTRIM(RTRIM(L.NOM)) FROM ''+@base+''..LOCAT L WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''LibCategorie''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET LibCategorie=''''LOCATAIRE'''''';--+
	--''(SELECT REPLACE(LTRIM(RTRIM(L.LIBELLE)),''''"'''','''''''') FROM ''+@base+''..LOCAT L WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Prénom''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Prenom=''+
	''(SELECT LTRIM(RTRIM(L.PRENOM)) FROM ''+@base+''..LOCAT L WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END


BEGIN SET @script_section = ''Add1''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Add1=''+
	''(SELECT CT.ADD1 FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Add2''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Add2=''+
	''(SELECT CT.ADD2 FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Add3''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Add3=''+
	''(SELECT CT.ADD3 FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Add4''
if @debug_mode = 1 Print @script_section
--	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Add4=''+
--	''(SELECT CT.ADD1 FROM ''+@base+''..LOCAT L '' +
--	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
--	''WHERE L.LOCAT=CodeIntervenant)'';
--	if @debug_mode = 1 PRINT @query_sql;
--exec(@query_sql);
END


BEGIN SET @script_section = ''Cp''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Cp=''+
	''(SELECT CT.Cp FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Ville''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Ville=''+
	''(SELECT CT.Ville FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Pays''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Pays=''+
	''(SELECT CT.PAYS FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END


BEGIN SET @script_section = ''Telephone''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Telephone=''+
	''(SELECT ISNULL(CT.TEL,L.TEL) FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Mobile''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Telephone=''+
	''(SELECT ISNULL(CT.PORTABLE,L.TEL) FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Username''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Username=''+
	''(SELECT ISNULL(CT.EMAIL,L.EMAIL) FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''EMAIL''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''UPDATE ''+@base+''..myrem_intervenant SET Email=''+
	''(SELECT ISNULL(CT.EMAIL,L.EMAIL) FROM ''+@base+''..LOCAT L '' +
	''INNER JOIN CONTACT CT ON CT.CTYPE=''''L'''' AND CT.RATTACH=L.LOCAT AND L.ADR_COURR=CT.LIGNE ''+
	''WHERE L.LOCAT=CodeIntervenant)'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END



BEGIN SET @script_section = ''Gestionnaire Locatif - Groupe de Quittanecement''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''INSERT INTO ''+@base+''..myrem_intervenant ([mvi],[IdSource],[CodeIntervenant],[IdTypeParent],[Fonction],[CodeCategorie] ''+
	'',[LibCategorie],[Nom],[Add1],[Add2],[Add3],[Cp],[Ville],[Telephone],[Username],[Email]) ''+
 ''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''', ''''GRPQUIT-''''+LTRIM(RTRIM(G.GROUPE)), ''''ACTIF_[ROLE]'''', ''''Gestionnaire Locatif'''', ''''GL'''', ''''Gestionnaire Locatif'''', '' +
	''G.LIBELLE,  G.ADD1,  G.ADD2,  G.ADD3,  G.CP,  G.VILLE, G.TEL, G.EMAIL, G.EMAIL FROM GROUPEP G'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END


/*
ACTIF_[ROLE]
*/


BEGIN SET @script_section = ''Intervenants de la propriété''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''INSERT INTO ''+@base+''..myrem_intervenant ([mvi],[IdSource],[CodeIntervenant],[IdTypeParent],[Fonction],[CodeCategorie] ''+
	'',[LibCategorie],[Nom],[Add1],[Add2],[Add3],[Cp],[Ville],[Telephone],[Username],[Email]) ''+
	''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''', CAST(PROPRIETTIERSCONT.IDTTIERS as VARCHAR(20))+''''-''''+CAST(PROPRIETTIERSCONT.IDTIERS as VARCHAR(20)), ''+ 
	''''''ACTIF_[ROLE]'''', PTTIERS.CTTIERS, PTTIERS.TTIERS, PTTIERS.CTTIERS, LTRIM(RTRIM(LTRIM(RTRIM(CONTACT.NOM)))), ''+
	''CONTACT.ADD1, CONTACT.ADD2, CONTACT.ADD3, CONTACT.CP, CONTACT.VILLE, CONTACT.TEL, CONTACT.EMAIL, CONTACT.EMAIL ''+
	''FROM gagi_prod..PROPRIETTIERSCONT ''+
	''INNER JOIN gagi_prod..CONTACT ON CONTACT.RATTACH=PROPRIETTIERSCONT.IDTIERS AND LIGNE=PROPRIETTIERSCONT.IDCONTACT AND CONTACT.CTYPE=''''T'''' ''+
	''INNER JOIN gagi_prod..PTTIERS ON PROPRIETTIERSCONT.IDTTIERS=PTTIERS.TTIERS ''+
	''GROUP BY PROPRIETTIERSCONT.IDTTIERS, PROPRIETTIERSCONT.IDTIERS, PTTIERS.CTTIERS, PTTIERS.TTIERS, CONTACT.NOM, CONTACT.PRENOM, ''+
	''CONTACT.ADD1, CONTACT.ADD2, CONTACT.ADD3, CONTACT.CP, CONTACT.VILLE, CONTACT.TEL, CONTACT.EMAIL '';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [6-INTERVENANTACTIFS]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'6-INTERVENANTACTIFS', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';


-- STRUCTURES



SET @script_section = ''Création de la table temporaire 02.04''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_aintervenantactif'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_aintervenantactif;
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.04'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_aintervenantactif ('' +
		''mvi VARCHAR(50) NOT NULL,''+
		''CodeSource VARCHAR(255) NOT NULL,''+
		''fk_Interv_CodeActif VARCHAR(100) NOT NULL,''+
		''fk_Actif_IdActif VARCHAR(255) NOT NULL,''+
		''CodeCategorie VARCHAR(100) NOT NULL''+
		'');''
	exec(@query_sql);
END


BEGIN SET @script_section = ''Mise en place PK 02.04''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_aintervenantactif ADD PRIMARY KEY (CodeSource,fk_Interv_CodeActif,fk_Actif_IdActif,CodeCategorie)''
	exec(@query_sql);
END

-- DONNEES
BEGIN SET @script_section = ''Peuplement PK + base : mvi, CodeSource,fk_Interv_CodeActif,fk_Actif_IdActif''
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_aintervenantactif (mvi, CodeSource,fk_Interv_CodeActif,fk_Actif_IdActif,CodeCategorie) '' +
		''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''', ''''GRPQUIT-''''+LTRIM(RTRIM(G.GROUPE)), P.PROPRIETE, ''''GRPQUIT'''' FROM PROPRIET P ''+
		''INNER JOIN GROUPEP G ON P.GROUPE=G.GROUPE AND (P.CDATE IS NULL OR P.CDATE > GetDate()) ''

		-- SELECT * FROM gagi_prod..myrem_aintervenantactif
		-- SELECT * FROM gagi_prod..PROPRIET P
		-- SELECT * FROM gagi_prod..GROUPEP G
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

BEGIN SET @script_section = ''Intervenants de la propriété''
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
	''INSERT INTO ''+@base+''..myrem_aintervenantactif (mvi, CodeSource,fk_Interv_CodeActif,fk_Actif_IdActif,CodeCategorie) '' +
	''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''', CAST(PROPRIETTIERSCONT.IDTTIERS as VARCHAR(20))+''''-''''+CAST(PROPRIETTIERSCONT.IDTIERS as VARCHAR(20)), PROPRIETTIERSCONT.IDPROPRIETE, PTTIERS.TTIERS ''+ 
	''FROM gagi_prod..PROPRIETTIERSCONT ''+
		''INNER JOIN gagi_prod..PTTIERS ON PROPRIETTIERSCONT.IDTTIERS=PTTIERS.TTIERS ''+
	''GROUP BY PROPRIETTIERSCONT.IDTTIERS, PROPRIETTIERSCONT.IDTIERS, PROPRIETTIERSCONT.IDPROPRIETE, PTTIERS.TTIERS'';
	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END

', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [7-INTERVENANTLOCATAIRE]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'7-INTERVENANTLOCATAIRE', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement


	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @result int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(250);



	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';


-- STRUCTURES



SET @script_section = ''Création de la table temporaire 02.04''
begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''myrem_aintervenantlocataire'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_aintervenantlocataire;
end try 
begin catch end catch
BEGIN
if @debug_mode = 1 Print @script_section
	SET @mci_ver = ''02.04'';
	SET @query_sql = 
		''CREATE TABLE ''+@base+''..myrem_aintervenantlocataire ('' +
		''mvi VARCHAR(50) NOT NULL,''+
		''CodeSource VARCHAR(255) NOT NULL,''+
		''CodeIntervenant VARCHAR(100) NOT NULL,''+
		''fk_Actif_IdActif VARCHAR(255) NOT NULL''+
		'');''
	exec(@query_sql);
END


BEGIN SET @script_section = ''Mise en place PK 02.04''
if @debug_mode = 1 Print @script_section
	SET @query_sql = ''ALTER TABLE ''+@base+''..myrem_aintervenantlocataire ADD PRIMARY KEY (CodeSource,CodeIntervenant,fk_Actif_IdActif)''
	exec(@query_sql);
END

-- DONNEES
BEGIN SET @script_section = ''Peuplement PK + base : mvi, CodeSource,CodeIntervenant,fk_Actif_IdActif''
if @debug_mode = 1 Print @script_section
	SET @query_sql = 
		''INSERT INTO ''+@base+''..myrem_aintervenantlocataire (mvi, CodeSource,CodeIntervenant,fk_Actif_IdActif) '' +
		''SELECT ''''''+@mci_ver+'''''',''''''+@id_source+'''''', L.LOCAT, LTRIM(RTRIM(B.PROPRIETE))+''''_''''+LTRIM(RTRIM(B.BAIL)) FROM LOCAT L ''+
		''INNER JOIN BAIL B ON L.IDLOCAT=B.IDLOCAT AND (B.DRESILIAT IS NULL OR B.DRESILIAT > GetDate()) ''+
		''GROUP BY L.LOCAT, B.PROPRIETE, B.BAIL''

	if @debug_mode = 1 PRINT @query_sql;
exec(@query_sql);
END', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [98-BCPEXPORT]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'98-BCPEXPORT', 
		@step_id=9, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- Déclaration et peuplement
BEGIN

	SET NOCOUNT ON
	SET DATEFORMAT dmy

	DECLARE @type int;
	SET @type = 1; --1 SQL, 2 Batch

	-- On déclare les variables
	DECLARE @mci_ver varchar(50);

	DECLARE @id_client int;
	DECLARE @debug_mode int;
		SET @debug_mode = 1;
	DECLARE @id_source varchar(80);
	DECLARE @base varchar(80);
	DECLARE @query_sql varchar(max);
	DECLARE @filtre varchar(max);
	DECLARE @script_section varchar(255);
	DECLARE @path_web varchar(255);

	-- On peuple les variables

IF @type = 1 
	BEGIN

	SET @id_client = 3;
	SET @debug_mode = 1;
	SET @base = ''gagi_prod'';
	SET @id_source = ''PROUDREED'';
	SET @path_web = ''C:\Temp\tenants\'';
	END
END

	--DECLARE @query_sql varchar(max);
	DECLARE @query_sql1 varchar(max);
	DECLARE @query_end nvarchar(max);
	DECLARE @query_cmd varchar(8000);
	DECLARE @data_type varchar(100);
	
	begin try 
if exists (select * from tempdb.INFORMATION_SCHEMA.TABLES where TABLE_NAME = ''##tmp_export'' AND TABLE_SCHEMA = ''dbo'')
    drop table ##tmp_export;
end try 
begin catch end catch

	DECLARE @col_name varchar(255);
	DECLARE @file_name varchar(255);
	DECLARE @file_table varchar(255);
	DECLARE @select_name varchar(255);
	DECLARE @select_table varchar(255);
	
	
-- Préparation de la génération des fichiers

begin try 
if exists (select * from INFORMATION_SCHEMA.TABLES where TABLE_NAME LIKE ''myrem_fichier'' AND TABLE_SCHEMA = ''dbo'')
    drop table myrem_fichier;
end try 
begin catch end catch


BEGIN
	SET @query_sql = ''CREATE TABLE ''+@base+''..myrem_fichier (myrem_table varchar(100), myrem_nfichier varchar(100));''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''actif'''',''''1-Actif.csv'''');''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''lot'''',''''3-Lot.csv'''');''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''bail'''',''''2-Bail.csv'''');''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''pindice'''',''''0-Pindice.csv'''');''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''budget'''',''''4-Budget.csv'''');''
	exec(@query_sql);
	
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''intervenant'''',''''7-Intervenant.csv'''');''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''aintervenantactif'''',''''8-Aintervenantactif.csv'''');''
	exec(@query_sql);
	SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''aintervenantlocataire'''',''''9-Aintervenantlocataire.csv'''');''
	exec(@query_sql);

	--SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''gddl_0_categorie'''',''''GDDL-0-categorie.csv'''');''
	--exec(@query_sql);
	--SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''gddl_1_donnee'''',''''GDDL-1-donnee.csv'''');''
	--exec(@query_sql);
	--SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''gddl_2_valeur'''',''''GDDL-2-valeur.csv'''');''
	--exec(@query_sql);
	--SET @query_sql =  ''INSERT INTO ''+@base+''..myrem_fichier VALUES (''''gddh_0_valeur'''',''''GDDH-0-valeur.csv'''');''
	--exec(@query_sql);
END

	--SET @query_sql =  ''SELECT * FROM ''+@base+''..myrem_fichier''
	--exec(@query_sql);


CREATE TABLE ##tmp_export (fichier varchar(max), myrem_data varchar(max))

--SELECT * FROM myrem_actif
--SELECT * FROM myrem_fichier
--SELECT * FROM ##tmp_export

-- Boucler sur les noms dans myrem_fichier pour créer les en-tête en dynamique sur la base du script
DECLARE File_Cursor CURSOR FOR SELECT ''myrem_''+mrf.myrem_table FROM myrem_fichier mrf
    OPEN File_Cursor
        FETCH NEXT FROM File_Cursor INTO @file_table
        WHILE @@FETCH_STATUS = 0
        BEGIN
		--PRINT @file_table
		-- Initialisation de l''insert
		SET @query_end = ''INSERT INTO ##tmp_export (myrem_data) SELECT (''''''
		SET @query_sql1 = ''''

			DECLARE tcol_name CURSOR FOR SELECT name FROM sys.columns where object_id = (SELECT object_id FROM sys.tables WHERE name=@file_table) order by column_id asc
			/*
			SELECT name FROM sys.columns where object_id = (SELECT object_id FROM sys.tables WHERE name=''myrem_actif'') order by column_id asc
			*/
			OPEN tcol_name
			FETCH NEXT FROM tcol_name INTO @col_name
			WHILE @@FETCH_STATUS = 0
			BEGIN
			--PRINT @col_name
				
			-- Avec "
				SET @query_end = @query_end + ''"'' + @col_name+''";''
			-- Sans "
				-- SET @query_end = @query_end + @col_name+'';''
			
			FETCH NEXT FROM tcol_name INTO @col_name
			END
			CLOSE tcol_name
			DEALLOCATE tcol_name
		
		SET @query_end=left(@query_end,LEN(@query_end)-1)+'''''');''
		EXEC(@query_end);
		SET @query_end=''UPDATE ##tmp_export SET fichier='''''' + RIGHT(@file_table,LEN(@file_table)-6) + '''''' where fichier IS NULL''
		EXEC(@query_end);
		
		FETCH NEXT FROM File_Cursor INTO @file_table
		END
		CLOSE File_Cursor
		DEALLOCATE File_Cursor

--INSERT INTO ##tmp_export (myrem_data) SELECT ''"''+ISNULL(LTRIM(RTRIM(CAST(mvi as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CodeSource as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CodeActif as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(libelle as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Add1 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Add2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Add3 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Add4 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Cp as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Ville as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Pays as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ProprioId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ProprioLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AdbId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AdbLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandantId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandantLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GroupementId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GroupementLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GroupementLoc as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(VenteDate as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(VenteOk as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeDate as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeOk as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeConsoVal as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeConsoClasse as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeGesVal as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeGesClasse as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeScreenNote as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfTotM2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfTotU as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfLoueM2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfLoueU as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfVacM2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfVacU as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetTxOcc as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetTxVac as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GestionId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GestionLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinLoyer as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinDg as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinBalanceAg as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinBudgetCharge as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinBudgetEngage as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinBudgetRealise as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ExpertiseAnnee as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ExpertiseValHf as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ExpertiseValFi as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeSurface as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Pregion_IdRegion as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Pdept_IdDept as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Pimmostat_IdImmostat as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Description1 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Description2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Description3 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(OpeDateSign as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(OpeDatePconst as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(OpeDateOuverture as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(OpeDureeConst as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatType as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatDateEffet as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatDateFin as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatNumero as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatPreavis as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(MandatDuree as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FiscaActif as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Icpe as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Dta as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Latitude as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Longitude as VARCHAR(max)))),'''') +''"'' FROM myrem_actif
--UPDATE ##tmp_export SET fichier=''actif'' where fichier IS NULL
--INSERT INTO ##tmp_export (myrem_data) SELECT ''"''+ISNULL(LTRIM(RTRIM(CAST(mvi as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CodeSource as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CodeLot as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Libelle as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Actif_CodeActif as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DispoDate as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DispoOK as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeDate as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeOk as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeConsoVal as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeConsoClasse as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeGesVal as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeGesClasse as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfTotM2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfTotU as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfLoueM2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfLoueU as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfVacM2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(AssetSurfVacU as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinLoyer as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinCharge as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinTfonciere as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinTbureau as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinTlocidf as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeScreenNote as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeSurface as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GroupementId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(GroupementLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(IdBail as VARCHAR(max)))),'''') +''"'' FROM myrem_lot
--UPDATE ##tmp_export SET fichier=''lot'' where fichier IS NULL
--INSERT INTO ##tmp_export (myrem_data) SELECT ''"''+ISNULL(LTRIM(RTRIM(CAST(mvi as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CodeSource as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(BailCode as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Libelle as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Actif_CodeActif as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Pcncc_IdCncc as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_Pnaf_IdNaf as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_PindiceCode_IdIndice as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(fk_PindiceCode_IdIndiceIni as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(LocataireLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(EnseigneLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ActiviteId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ActiviteLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TypeLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(NatureId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(NatureLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Duree as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DateDebut as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DateFin as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DateNextBreak as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinLoyerIni as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinLoyerActuel as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinDgIni as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinDgActuel as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TermeId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TermeLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FrequenceId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FrequenceLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(SurfaceTotale as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinCharges as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinTaxes as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(FinDette as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(RcsNum as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(RcsVille as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CofaceScoreRating as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CofaceNotation as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactAdd1 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactAdd2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactCp as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactVille as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactPays as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactTel as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(ContactMail as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Comment1 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Comment2 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Comment3 as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeDate as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeOk as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeConsoVal as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeConsoClasse as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeGesVal as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeGesClasse as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(DpeScreenNote as VARCHAR(max)))),'''') +''"'' FROM myrem_bail
--UPDATE ##tmp_export SET fichier=''bail'' where fichier IS NULL
--INSERT INTO ##tmp_export (myrem_data) SELECT ''"''+ISNULL(LTRIM(RTRIM(CAST(mvi as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(CodeIndice as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TindiceId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(TindiceLib as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Periodicite as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(IndiceId as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Dpublication as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Ddebut as VARCHAR(max)))),'''')+''";"''+ISNULL(LTRIM(RTRIM(CAST(Valeur as VARCHAR(max)))),'''') +''"'' FROM myrem_pindice
--UPDATE ##tmp_export SET fichier=''pindice'' where fichier IS NULL


DECLARE File_Cursor CURSOR FOR SELECT myrem_table, myrem_nfichier FROM myrem_fichier 
    OPEN File_Cursor
        FETCH NEXT FROM File_Cursor INTO @file_table, @file_name 
        WHILE @@FETCH_STATUS = 0
        BEGIN
		
		SET @query_end = ''INSERT INTO ##tmp_export (fichier, myrem_data) SELECT ''''''+@file_table+'''''',''''"''''+''
		PRINT  @query_end
		SET @query_sql1 = ''''
			DECLARE Select_Cursor CURSOR FOR SELECT COLUMN_NAME, DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME=''myrem_''+@file_table 
				OPEN Select_Cursor
					FETCH NEXT FROM Select_Cursor INTO @select_name, @data_type 
					WHILE @@FETCH_STATUS = 0
					BEGIN

					IF @data_type like ''%char%'' 
					SET @query_end = @query_end + ''ISNULL(LTRIM(RTRIM(CAST(REPLACE(REPLACE(''+@select_name+'', CHAR(13), ''''''''), CHAR(10), '''''''') as VARCHAR(max)))),'''''''')'' + ''+''''";"''''+''
					
					ELSE IF @data_type like ''%date%'' 
					SET @query_end = @query_end + ''ISNULL(LTRIM(RTRIM(CAST(CONVERT(VARCHAR(10),''+@select_name+'',103) as VARCHAR(max)))),'''''''')'' + ''+''''";"''''+''
					
					ELSE -- Numériques
					SET @query_end = @query_end + ''ISNULL(LTRIM(RTRIM(CAST(ISNULL(''+@select_name+'',0) as VARCHAR(max)))),'''''''')'' + ''+''''";"''''+''
					
					
					--PRINT  @query_end
					SET @query_sql1 = @query_sql1+''"''+@select_name+''";''

					FETCH NEXT FROM Select_Cursor INTO @select_name, @data_type
					END
				CLOSE Select_Cursor
			DEALLOCATE Select_Cursor
		   
		   --PRINT @query_sql1
		   
		   SET @query_end = @query_end + '''''' FROM myrem_''+@file_table+''''
		   SET @query_end = REPLACE(@query_end,''+''''";"''''+'''' FROM '','' +''''"'''' FROM '')

		   PRINT  @query_end
		   EXECUTE sp_executesql @query_end
		   
		   --PRINT  @query_sql1
		   --SET @query_sql1 = LEFT(@query_sql1,LEN(@query_sql1)-1) + '' FROM myrem_''+@file_table+''''
		   --SET @query_sql1 = REPLACE(@query_sql1,''+'''',''''+'''' FROM '','' +'''' FROM '')
		   --PRINT  @query_sql1
		   --EXEC  @query_sql1

		   --SET @query_cmd	=''bcp "SELECT ''''''+LEFT(@query_sql1,len(@query_sql1)-1)+'''''' UNION ALL SELECT myrem_data FROM ##tmp_export where fichier=''''''+@file_table+''''''" queryout "D:\''+@file_name+''" -T -c -t''
		   SET @query_cmd	=''bcp "SELECT myrem_data FROM ##tmp_export where fichier=''''''+@file_table+''''''" queryout "C:\Temp\tenants\''+@file_name+''" -S PROSQL01 -T -c -C ACP -t''
		   --PRINT @query_cmd
		   EXEC xp_cmdshell @query_cmd
    --SELECT * FROM ##tmp_export

	    FETCH NEXT FROM File_Cursor INTO @file_table, @file_name 
        END
    CLOSE File_Cursor
DEALLOCATE File_Cursor

-- Nettoyage
--BEGIN --Fichier
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_fichier;''
--	exec(@query_sql);
--END

--BEGIN -- Actif
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_actif;''
--	exec(@query_sql);
--END

--BEGIN -- Lot
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_lot;''
--	exec(@query_sql);
--END

--BEGIN -- Lot
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_bail;''
--	exec(@query_sql);
--END

--BEGIN -- Pindice
--	SET @query_sql = ''DROP TABLE ''+@base+''..myrem_pindice;''
--	exec(@query_sql);
--END

', 
		@database_name=N'gagi_prod', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [99-ExportWinSCP]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'99-ExportWinSCP', 
		@step_id=10, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC xp_cmdshell ''C:\WinSCP\ExtranetLocataire\01-Transfert.bat''', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'20h15', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20190829, 
		@active_end_date=99991231, 
		@active_start_time=201500, 
		@active_end_time=235959
		--@schedule_uid=N'060b9fd8-0b5f-48bc-bf6c-2e645dc4f8cb'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [NEOCLES - Reinitialize subscriptions having data validation failures]    Script Date: 07/06/2022 15:29:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Alert Response]    Script Date: 07/06/2022 15:29:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Alert Response' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Alert Response'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'NEOCLES - Reinitialize subscriptions having data validation failures', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Reinitializes all subscriptions that have data validation failures.', 
		@category_name=N'REPL-Alert Response', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec sys.sp_MSreinit_failed_subscriptions @failure_level = 1', 
		@server=N'PROSQL01', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [NEOCLES - Replication agents checkup]    Script Date: 07/06/2022 15:29:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Checkup]    Script Date: 07/06/2022 15:29:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Checkup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Checkup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'NEOCLES - Replication agents checkup', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Detects replication agents that are not logging history actively.', 
		@category_name=N'REPL-Checkup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Run agent.]    Script Date: 07/06/2022 15:29:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Run agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'sys.sp_replication_agent_checkup @heartbeat_interval = 10', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Replication agent schedule.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110621, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
		--@schedule_uid=N'c5528ba1-412d-49c9-b2aa-d2cd21976e48'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [Nettoyage de la distribution : Distributor]    Script Date: 07/06/2022 15:29:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Distribution Cleanup]    Script Date: 07/06/2022 15:29:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Distribution Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Distribution Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Nettoyage de la distribution : Distributor', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Suppression des transactions répliquées de la base de données de distribution.', 
		@category_name=N'REPL-Distribution Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Exécution de l'Agent.]    Script Date: 07/06/2022 15:29:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Exécution de l''Agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_MSdistribution_cleanup @min_distretention = 0, @max_distretention = 72', 
		@server=N'PROSQL01', 
		@database_name=N'Distributor', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Planification de l''agent de réplication.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171208, 
		@active_end_date=99991231, 
		@active_start_time=500, 
		@active_end_time=459, 
		--@schedule_uid=N'01b974ef-d1ab-48b0-88e2-259a9aa05e85'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [Nettoyage de l'abonnement expiré]    Script Date: 07/06/2022 15:29:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Subscription Cleanup]    Script Date: 07/06/2022 15:29:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Subscription Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Subscription Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Nettoyage de l''abonnement expiré', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Détecte et retire les abonnements expirés des bases de données publiées.', 
		@category_name=N'REPL-Subscription Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Exécution de l'Agent.]    Script Date: 07/06/2022 15:29:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Exécution de l''Agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC sys.sp_expired_subscription_cleanup', 
		@server=N'PROSQL01', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Planification de l''agent de réplication.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=1, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171208, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959
		--@schedule_uid=N'a9935070-3ba3-4e4d-8797-939462c3fca4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [Nettoyage de l'historique de l'agent : Distributor]    Script Date: 07/06/2022 15:29:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-History Cleanup]    Script Date: 07/06/2022 15:29:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-History Cleanup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-History Cleanup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Nettoyage de l''historique de l''agent : Distributor', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Supprime l''historique de l''agent de réplication de la base de données de distribution.', 
		@category_name=N'REPL-History Cleanup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Exécution de l'Agent.]    Script Date: 07/06/2022 15:29:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Exécution de l''Agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC dbo.sp_MShistory_cleanup @history_retention = 48', 
		@server=N'PROSQL01', 
		@database_name=N'Distributor', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Planification de l''agent de réplication.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171208, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
		--@schedule_uid=N'34960628-1176-4a18-8a3b-5934a84deae1'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [TITAN_UnPivot_Files]    Script Date: 07/06/2022 15:29:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]    Script Date: 07/06/2022 15:29:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'TITAN_UnPivot_Files', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Pas de description disponible.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa_proudreed', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [UnPivot_Resultat_LT]    Script Date: 07/06/2022 15:29:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'UnPivot_Resultat_LT', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use dwh_proudreed

TRUNCATE TABLE TITAN_ANAPLAN_RSLT_LT_PROPRE

--Select UNIVERS, DATE_EXPORT, N__OPN,N__OPN2,INDICE, PERIODE_BRUTE, MONTANT into TITAN_ANAPLAN_RSLT_LT_PROPRE
Insert into TITAN_ANAPLAN_RSLT_LT_PROPRE SELECT UNIVERS, DATE_EXPORT, N__OPN,N__OPN2,INDICE, PERIODE_BRUTE, MONTANT    
FROM   
   (SELECT UNIVERS, DATE_EXPORT, N__OPN, N__OPN2 ,INDICE, JAN_22, F_V_22, MAR_22, AVR_22, MAI_22, JUN_22, JUL_22, AO__22, SEP_22, OCT_22, NOV_22, D_C_22, JAN_23, F_V_23, MAR_23, AVR_23, MAI_23, JUN_23, JUL_23, AO__23, SEP_23, OCT_23, NOV_23, D_C_23, JAN_24, F_V_24, MAR_24, AVR_24, MAI_24, JUN_24, JUL_24, AO__24, SEP_24, OCT_24, NOV_24, D_C_24, JAN_25, F_V_25, MAR_25, AVR_25, MAI_25, JUN_25, JUL_25, AO__25, SEP_25, OCT_25, NOV_25, D_C_25, JAN_26, F_V_26, MAR_26, AVR_26, MAI_26, JUN_26, JUL_26, AO__26, SEP_26, OCT_26, NOV_26, D_C_26, JAN_27, F_V_27, MAR_27, AVR_27, MAI_27, JUN_27, JUL_27, AO__27, SEP_27, OCT_27, NOV_27, D_C_27, JAN_28, F_V_28, MAR_28, AVR_28, MAI_28, JUN_28, JUL_28, AO__28, SEP_28, OCT_28, NOV_28, D_C_28, JAN_29, F_V_29, MAR_29, AVR_29, MAI_29, JUN_29, JUL_29, AO__29, SEP_29, OCT_29, NOV_29, D_C_29, JAN_30, F_V_30, MAR_30, AVR_30, MAI_30, JUN_30, JUL_30, AO__30, SEP_30, OCT_30, NOV_30, D_C_30, JAN_31, F_V_31, MAR_31, AVR_31, MAI_31, JUN_31, JUL_31, AO__31, SEP_31, OCT_31, NOV_31, D_C_31
   FROM TITAN_ANAPLAN_RSLT_BRUTE) p  
UNPIVOT  
   (MONTANT FOR PERIODE_BRUTE IN   
      (JAN_22, F_V_22, MAR_22, AVR_22, MAI_22, JUN_22, JUL_22, AO__22, SEP_22, OCT_22, NOV_22, D_C_22, JAN_23, F_V_23, MAR_23, AVR_23, MAI_23, JUN_23, JUL_23, AO__23, SEP_23, OCT_23, NOV_23, D_C_23, JAN_24, F_V_24, MAR_24, AVR_24, MAI_24, JUN_24, JUL_24, AO__24, SEP_24, OCT_24, NOV_24, D_C_24, JAN_25, F_V_25, MAR_25, AVR_25, MAI_25, JUN_25, JUL_25, AO__25, SEP_25, OCT_25, NOV_25, D_C_25, JAN_26, F_V_26, MAR_26, AVR_26, MAI_26, JUN_26, JUL_26, AO__26, SEP_26, OCT_26, NOV_26, D_C_26, JAN_27, F_V_27, MAR_27, AVR_27, MAI_27, JUN_27, JUL_27, AO__27, SEP_27, OCT_27, NOV_27, D_C_27, JAN_28, F_V_28, MAR_28, AVR_28, MAI_28, JUN_28, JUL_28, AO__28, SEP_28, OCT_28, NOV_28, D_C_28, JAN_29, F_V_29, MAR_29, AVR_29, MAI_29, JUN_29, JUL_29, AO__29, SEP_29, OCT_29, NOV_29, D_C_29, JAN_30, F_V_30, MAR_30, AVR_30, MAI_30, JUN_30, JUL_30, AO__30, SEP_30, OCT_30, NOV_30, D_C_30, JAN_31, F_V_31, MAR_31, AVR_31, MAI_31, JUN_31, JUL_31, AO__31, SEP_31, OCT_31, NOV_31, D_C_31))
   as unpvt;

-- remplace l''indice (EUR3M, EUR3M_JC,...) par partie variable pour import Anaplan
Update TITAN_ANAPLAN_RSLT_LT_PROPRE 
SET INDICE = ''Partie variable'' where INDICE != ''Partie fixe'';

-- Les lignes de total sont supprimées
Delete TITAN_ANAPLAN_RSLT_LT_PROPRE where UNIVERS is null;


ALTER TABLE dbo.TITAN_ANAPLAN_RSLT_LT_PROPRE DROP COLUMN PERIODE_OK;
ALTER TABLE dbo.TITAN_ANAPLAN_RSLT_LT_PROPRE ADD PERIODE_OK AS CONCAT(''01/'',Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(LEFT(PERIODE_BRUTE,3),''JAN'',''01''),''F_V'',''02''),''MAR'',''03''),''AVR'',''04''),''MAI'',''05''),''JUN'',''06''),''JUL'',''07''),''AO_'',''08''),''SEP'',''09''),''OCT'',''10''),''NOV'',''11''),''D_C'',''12''),''/20'',RIGHT(PERIODE_BRUTE,2));
ALTER TABLE dbo.TITAN_ANAPLAN_RSLT_LT_PROPRE DROP COLUMN CODE_UNIQUE;
ALTER TABLE dbo.TITAN_ANAPLAN_RSLT_LT_PROPRE ADD CODE_UNIQUE AS CONCAT(UNIVERS,''-'',N__OPN,''-'',N__OPN2,''-'',INDICE,''-'',PERIODE_BRUTE) ;

select * from TITAN_ANAPLAN_RSLT_LT_PROPRE
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [UnPivot_Mvt_CRD]    Script Date: 07/06/2022 15:29:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'UnPivot_Mvt_CRD', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use dwh_proudreed

TRUNCATE TABLE TITAN_ANAPLAN_MVT_CRD_PROPRE

--Select NO_OPN, MOUVEMENT, PERIODE_BRUTE, MONTANT, IMMEUBLES into TITAN_ANAPLAN_MVT_CRD_PROPRE
Insert into TITAN_ANAPLAN_MVT_CRD_PROPRE (NO_OPN, MOUVEMENT, PERIODE_BRUTE, MONTANT, IMMEUBLES) SELECT NO_OPN, MOUVEMENT, PERIODE_BRUTE, MONTANT, IMMEUBLES    
FROM   
   (SELECT MOUVEMENT, NO_OPN, IMMEUBLES, JAN_22, F_V_22, MAR_22, AVR_22, MAI_22, JUN_22, JUL_22, AO__22, SEP_22, OCT_22, NOV_22, D_C_22, JAN_23, F_V_23, MAR_23, AVR_23, MAI_23, JUN_23, JUL_23, AO__23, SEP_23, OCT_23, NOV_23, D_C_23, JAN_24, F_V_24, MAR_24, AVR_24, MAI_24, JUN_24, JUL_24, AO__24, SEP_24, OCT_24, NOV_24, D_C_24, JAN_25, F_V_25, MAR_25, AVR_25, MAI_25, JUN_25, JUL_25, AO__25, SEP_25, OCT_25, NOV_25, D_C_25, JAN_26, F_V_26, MAR_26, AVR_26, MAI_26, JUN_26, JUL_26, AO__26, SEP_26, OCT_26, NOV_26, D_C_26, JAN_27, F_V_27, MAR_27, AVR_27, MAI_27, JUN_27, JUL_27, AO__27, SEP_27, OCT_27, NOV_27, D_C_27, JAN_28, F_V_28, MAR_28, AVR_28, MAI_28, JUN_28, JUL_28, AO__28, SEP_28, OCT_28, NOV_28, D_C_28, JAN_29, F_V_29, MAR_29, AVR_29, MAI_29, JUN_29, JUL_29, AO__29, SEP_29, OCT_29, NOV_29, D_C_29, JAN_30, F_V_30, MAR_30, AVR_30, MAI_30, JUN_30, JUL_30, AO__30, SEP_30, OCT_30, NOV_30, D_C_30, JAN_31, F_V_31, MAR_31, AVR_31, MAI_31, JUN_31, JUL_31, AO__31, SEP_31, OCT_31, NOV_31, D_C_31
   FROM TITAN_ANAPLAN_MVT_CRD_BRUTE) p  
UNPIVOT  
   (MONTANT FOR PERIODE_BRUTE IN   
      (JAN_22, F_V_22, MAR_22, AVR_22, MAI_22, JUN_22, JUL_22, AO__22, SEP_22, OCT_22, NOV_22, D_C_22, JAN_23, F_V_23, MAR_23, AVR_23, MAI_23, JUN_23, JUL_23, AO__23, SEP_23, OCT_23, NOV_23, D_C_23, JAN_24, F_V_24, MAR_24, AVR_24, MAI_24, JUN_24, JUL_24, AO__24, SEP_24, OCT_24, NOV_24, D_C_24, JAN_25, F_V_25, MAR_25, AVR_25, MAI_25, JUN_25, JUL_25, AO__25, SEP_25, OCT_25, NOV_25, D_C_25, JAN_26, F_V_26, MAR_26, AVR_26, MAI_26, JUN_26, JUL_26, AO__26, SEP_26, OCT_26, NOV_26, D_C_26, JAN_27, F_V_27, MAR_27, AVR_27, MAI_27, JUN_27, JUL_27, AO__27, SEP_27, OCT_27, NOV_27, D_C_27, JAN_28, F_V_28, MAR_28, AVR_28, MAI_28, JUN_28, JUL_28, AO__28, SEP_28, OCT_28, NOV_28, D_C_28, JAN_29, F_V_29, MAR_29, AVR_29, MAI_29, JUN_29, JUL_29, AO__29, SEP_29, OCT_29, NOV_29, D_C_29, JAN_30, F_V_30, MAR_30, AVR_30, MAI_30, JUN_30, JUL_30, AO__30, SEP_30, OCT_30, NOV_30, D_C_30, JAN_31, F_V_31, MAR_31, AVR_31, MAI_31, JUN_31, JUL_31, AO__31, SEP_31, OCT_31, NOV_31, D_C_31))
   as unpvt;

ALTER TABLE dbo.TITAN_ANAPLAN_MVT_CRD_PROPRE DROP COLUMN PERIODE_OK;
ALTER TABLE dbo.TITAN_ANAPLAN_MVT_CRD_PROPRE ADD PERIODE_OK AS CONCAT(''01/'',Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(LEFT(PERIODE_BRUTE,3),''JAN'',''01''),''F_V'',''02''),''MAR'',''03''),''AVR'',''04''),''MAI'',''05''),''JUN'',''06''),''JUL'',''07''),''AO_'',''08''),''SEP'',''09''),''OCT'',''10''),''NOV'',''11''),''D_C'',''12''),''/20'',RIGHT(PERIODE_BRUTE,2));

DECLARE @univers_Rslt_LT as Varchar(100);
SELECT @univers_Rslt_LT = MAX(Univers) FROM TITAN_ANAPLAN_RSLT_LT_PROPRE;

Update TITAN_ANAPLAN_MVT_CRD_PROPRE 
SET Univers = @univers_Rslt_LT

ALTER TABLE dbo.TITAN_ANAPLAN_MVT_CRD_PROPRE DROP COLUMN DATE_EXPORT;
ALTER TABLE dbo.TITAN_ANAPLAN_MVT_CRD_PROPRE ADD DATE_EXPORT AS CONCAT(CONVERT (varchar, getdate(),103),'' '',left(CONVERT (time, GETDATE()),5)) ;
ALTER TABLE dbo.TITAN_ANAPLAN_MVT_CRD_PROPRE DROP COLUMN OPN_IMMEUBLE;
ALTER TABLE dbo.TITAN_ANAPLAN_MVT_CRD_PROPRE ADD OPN_IMMEUBLE AS CONCAT(NO_OPN,''-'',IMMEUBLES) ;

select * from TITAN_ANAPLAN_MVT_CRD_PROPRE', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [UnPivot_Notionnel]    Script Date: 07/06/2022 15:29:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'UnPivot_Notionnel', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use dwh_proudreed

TRUNCATE TABLE TITAN_ANAPLAN_NOTIONNEL_PROPRE

--Select UNIVERS, DATE_EXPORT, NUM_OPN, PERIODE_BRUTE, MONTANT into TITAN_ANAPLAN_NOTIONNEL_PROPRE
insert into TITAN_ANAPLAN_NOTIONNEL_PROPRE (NUM_OPN, PERIODE_BRUTE, MONTANT)  Select NUM_OPN, PERIODE_BRUTE, MONTANT
FROM   
   (SELECT NUM_OPN, ENCOURS__JAN_22, ENCOURS__F_V_22, ENCOURS__MAR_22, ENCOURS__AVR_22, ENCOURS__MAI_22, ENCOURS__JUN_22, ENCOURS__JUL_22, ENCOURS__AO__22, ENCOURS__SEP_22, ENCOURS__OCT_22, ENCOURS__NOV_22, ENCOURS__D_C_22, ENCOURS__JAN_23, ENCOURS__F_V_23, ENCOURS__MAR_23, ENCOURS__AVR_23, ENCOURS__MAI_23, ENCOURS__JUN_23, ENCOURS__JUL_23, ENCOURS__AO__23, ENCOURS__SEP_23, ENCOURS__OCT_23, ENCOURS__NOV_23, ENCOURS__D_C_23, ENCOURS__JAN_24, ENCOURS__F_V_24, ENCOURS__MAR_24, ENCOURS__AVR_24, ENCOURS__MAI_24, ENCOURS__JUN_24, ENCOURS__JUL_24, ENCOURS__AO__24, ENCOURS__SEP_24, ENCOURS__OCT_24, ENCOURS__NOV_24, ENCOURS__D_C_24, ENCOURS__JAN_25, ENCOURS__F_V_25, ENCOURS__MAR_25, ENCOURS__AVR_25, ENCOURS__MAI_25, ENCOURS__JUN_25, ENCOURS__JUL_25, ENCOURS__AO__25, ENCOURS__SEP_25, ENCOURS__OCT_25, ENCOURS__NOV_25, ENCOURS__D_C_25, ENCOURS__JAN_26, ENCOURS__F_V_26, ENCOURS__MAR_26, ENCOURS__AVR_26, ENCOURS__MAI_26, ENCOURS__JUN_26, ENCOURS__JUL_26, ENCOURS__AO__26, ENCOURS__SEP_26, ENCOURS__OCT_26, ENCOURS__NOV_26, ENCOURS__D_C_26, ENCOURS__JAN_27, ENCOURS__F_V_27, ENCOURS__MAR_27, ENCOURS__AVR_27, ENCOURS__MAI_27, ENCOURS__JUN_27, ENCOURS__JUL_27, ENCOURS__AO__27, ENCOURS__SEP_27, ENCOURS__OCT_27, ENCOURS__NOV_27, ENCOURS__D_C_27, ENCOURS__JAN_28, ENCOURS__F_V_28, ENCOURS__MAR_28, ENCOURS__AVR_28, ENCOURS__MAI_28, ENCOURS__JUN_28, ENCOURS__JUL_28, ENCOURS__AO__28, ENCOURS__SEP_28, ENCOURS__OCT_28, ENCOURS__NOV_28, ENCOURS__D_C_28, ENCOURS__JAN_29, ENCOURS__F_V_29, ENCOURS__MAR_29, ENCOURS__AVR_29, ENCOURS__MAI_29, ENCOURS__JUN_29, ENCOURS__JUL_29, ENCOURS__AO__29, ENCOURS__SEP_29, ENCOURS__OCT_29, ENCOURS__NOV_29, ENCOURS__D_C_29 
   FROM TITAN_ANAPLAN_NOTIONNEL_BRUTE) p  
UNPIVOT  
   (MONTANT FOR PERIODE_BRUTE IN   
      (ENCOURS__JAN_22, ENCOURS__F_V_22, ENCOURS__MAR_22, ENCOURS__AVR_22, ENCOURS__MAI_22, ENCOURS__JUN_22, ENCOURS__JUL_22, ENCOURS__AO__22, ENCOURS__SEP_22, ENCOURS__OCT_22, ENCOURS__NOV_22, ENCOURS__D_C_22, ENCOURS__JAN_23, ENCOURS__F_V_23, ENCOURS__MAR_23, ENCOURS__AVR_23, ENCOURS__MAI_23, ENCOURS__JUN_23, ENCOURS__JUL_23, ENCOURS__AO__23, ENCOURS__SEP_23, ENCOURS__OCT_23, ENCOURS__NOV_23, ENCOURS__D_C_23, ENCOURS__JAN_24, ENCOURS__F_V_24, ENCOURS__MAR_24, ENCOURS__AVR_24, ENCOURS__MAI_24, ENCOURS__JUN_24, ENCOURS__JUL_24, ENCOURS__AO__24, ENCOURS__SEP_24, ENCOURS__OCT_24, ENCOURS__NOV_24, ENCOURS__D_C_24, ENCOURS__JAN_25, ENCOURS__F_V_25, ENCOURS__MAR_25, ENCOURS__AVR_25, ENCOURS__MAI_25, ENCOURS__JUN_25, ENCOURS__JUL_25, ENCOURS__AO__25, ENCOURS__SEP_25, ENCOURS__OCT_25, ENCOURS__NOV_25, ENCOURS__D_C_25, ENCOURS__JAN_26, ENCOURS__F_V_26, ENCOURS__MAR_26, ENCOURS__AVR_26, ENCOURS__MAI_26, ENCOURS__JUN_26, ENCOURS__JUL_26, ENCOURS__AO__26, ENCOURS__SEP_26, ENCOURS__OCT_26, ENCOURS__NOV_26, ENCOURS__D_C_26, ENCOURS__JAN_27, ENCOURS__F_V_27, ENCOURS__MAR_27, ENCOURS__AVR_27, ENCOURS__MAI_27, ENCOURS__JUN_27, ENCOURS__JUL_27, ENCOURS__AO__27, ENCOURS__SEP_27, ENCOURS__OCT_27, ENCOURS__NOV_27, ENCOURS__D_C_27, ENCOURS__JAN_28, ENCOURS__F_V_28, ENCOURS__MAR_28, ENCOURS__AVR_28, ENCOURS__MAI_28, ENCOURS__JUN_28, ENCOURS__JUL_28, ENCOURS__AO__28, ENCOURS__SEP_28, ENCOURS__OCT_28, ENCOURS__NOV_28, ENCOURS__D_C_28, ENCOURS__JAN_29, ENCOURS__F_V_29, ENCOURS__MAR_29, ENCOURS__AVR_29, ENCOURS__MAI_29, ENCOURS__JUN_29, ENCOURS__JUL_29, ENCOURS__AO__29, ENCOURS__SEP_29, ENCOURS__OCT_29, ENCOURS__NOV_29, ENCOURS__D_C_29))
	   as unpvt;

DECLARE @univers_Rslt_LT as Varchar(100);
SELECT @univers_Rslt_LT = MAX(Univers) FROM TITAN_ANAPLAN_RSLT_LT_PROPRE;

Update TITAN_ANAPLAN_NOTIONNEL_PROPRE 
SET UNIVERS = @univers_Rslt_LT


ALTER TABLE dbo.TITAN_ANAPLAN_NOTIONNEL_PROPRE DROP COLUMN DATE_EXPORT;
ALTER TABLE dbo.TITAN_ANAPLAN_NOTIONNEL_PROPRE ADD DATE_EXPORT AS CONCAT(CONVERT (varchar, getdate(),103),'' '',left(CONVERT (time, GETDATE()),5)) ;
ALTER TABLE dbo.TITAN_ANAPLAN_NOTIONNEL_PROPRE DROP COLUMN PERIODE_OK;
ALTER TABLE dbo.TITAN_ANAPLAN_NOTIONNEL_PROPRE ADD PERIODE_OK AS CONCAT(''01/'',Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(Replace(SUBSTRING(PERIODE_BRUTE,10,3),''JAN'',''01''),''F_V'',''02''),''MAR'',''03''),''AVR'',''04''),''MAI'',''05''),''JUN'',''06''),''JUL'',''07''),''AO_'',''08''),''SEP'',''09''),''OCT'',''10''),''NOV'',''11''),''D_C'',''12''),''/20'',RIGHT(PERIODE_BRUTE,2));


select * from TITAN_ANAPLAN_NOTIONNEL_PROPRE', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'2h_ouvrées', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=2, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20220422, 
		@active_end_date=99991231, 
		@active_start_time=80705, 
		@active_end_time=220705, 
		--@schedule_uid=N'322be1f1-cac4-4454-9a9f-669d20b18ea6'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO

/****** Object:  Job [Vérification des agents de réplication]    Script Date: 07/06/2022 15:29:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [REPL-Checkup]    Script Date: 07/06/2022 15:29:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'REPL-Checkup' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'REPL-Checkup'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Vérification des agents de réplication', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Détecte les agents de réplication n''ayant pas d''enregistrement historique actif.', 
		@category_name=N'REPL-Checkup', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Exécution de l'Agent.]    Script Date: 07/06/2022 15:29:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Exécution de l''Agent.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'sys.sp_replication_agent_checkup @heartbeat_interval = 10', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Planification de l''agent de réplication.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=1, 
		@freq_recurrence_factor=0, 
		@active_start_date=20171208, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
		--@schedule_uid=N'4d77a2f6-b2ca-43a8-b493-d0b10e26a7fc'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


