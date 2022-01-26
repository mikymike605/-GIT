EXEC sp_configure 'show advanced options',1
reconfigure

EXEC sp_configure 'xp_cmdshell',1
reconfigure
GO

IF OBJECT_ID('sauvegarde_base') IS NOT NULL
DROP PROCEDURE sauvegarde_base
GO

CREATE PROCEDURE sauvegarde_base (
@nom_base sysname,
@type_sauvegarde varchar(50) = 'COMPLET',
@repertoire_destination varchar(500) = 'DEFAULT'
)
AS
/***************************************************************************************
B. Vesan, Cap Data Consulting, F�vrier 2012
Cette procedure permet de sauvegarder une base de donn�es ou son journal transactionnel.
@type_sauvegarde (type de la sauvegarde ) peut valoir:
COMPLET pour une sauvegarde compl�te, option par d�faut
COPY_ONLY pour une sauvegarde compl�te sans interrompre la s�quence des sauvegardes
DIFFERENTIEL pour une sauvegarde diff�rentielle
LOG pour une sauvegarde du journal de transactions.
@repertoire_destination contient le chemin accueillant la sauvegarde.
un r�pertoire est cr�� dans le chemin sp�cifi�
Lorsque sa valeur n'est pas pr�cis�e, la sauvegarde s'effectuera sur l'emplacement sp�cifi� dans
la table "parametre", dont la d�finition peut �tre trouv�e ici:

http://blog.capdata.fr/index.php/table_parametre

Le format des fichiers est:
<nom de la base>_<type de sauvegarde>_<date>_<heure>.BAK
ex: RMLBD_COMPLET_20120201_131738.BAK
La proc�dure retournera 0 en cas de succ�s, 1 en cas d'�chec.
***************************************************************************************/
BEGIN
SET NOCOUNT ON
DECLARE @cmd varchar(4000),@prefixe_fichier varchar(100),@destination varchar(4000),/*@compteur int,*/@code_retour int,@msg varchar(1000),@fichier_source varchar(500)
CREATE TABLE #TABLE_OUTPUT(ligne varchar(500))
CREATE TABLE #TABLE_SOURCE (source varchar(500),cpt int)
CREATE TABLE #TABLE_DESTINATION (destination varchar(500),cpt int)

IF upper(@type_sauvegarde) NOT IN ('COMPLET','DIFFERENTIEL','COPY_ONLY','LOG')
BEGIN
SET @msg = 'Echec de l'' ex�cution de sauvegarde_base : le type de sauvegarde '+ISNULL(@type_sauvegarde,'(valeur nulle)')+' n''est pas reconnu'
RAISERROR (@msg, 16, 1) WITH NOWAIT,LOG
return 1
END

IF DB_ID(@nom_base) IS NULL
BEGIN
SET @msg = 'Echec de l'' ex�cution de sauvegarde_base : La base '+ISNULL(@nom_base,'(valeur nulle)')+' n''existe pas'
RAISERROR (@msg, 16, 1) WITH NOWAIT,LOG
return 1
END

IF ( DATABASEPROPERTYEX(@nom_base,'Status ')!='ONLINE' OR EXISTS (select 1 FROM sys.databases WHERE name=@nom_base AND source_database_id IS NOT NULL))
BEGIN
SET @msg = 'La base '+@nom_base+' n''est pas disponible ou il s''agit d''un snapshot'
PRINT @msg
return 0
END

IF @repertoire_destination = 'DEFAULT'
BEGIN
IF EXISTS (SELECT * FROM outils_dba.sys.tables where name='parametres')
BEGIN
SELECT @repertoire_destination = CAST( valeur AS varchar(500)) FROM dbo.parametres WHERE nom_parametre='repertoire_sauvegarde' AND cible=@nom_base
IF @repertoire_destination = 'DEFAULT' SELECT @repertoire_destination = CAST( valeur AS varchar(500)) FROM dbo.parametres WHERE nom_parametre='repertoire_sauvegarde' AND cible IS NULL
END
ELSE
BEGIN
SET @msg = 'Echec de l'' ex�cution de sauvegarde_base : Aucune destination n''est d�finie pour la base '+ @nom_base
RAISERROR (@msg, 16, 1) WITH NOWAIT,LOG
return 1
END
END

----------- Si aucune sauvegarde compl�te n'existe pour la base et que la sauvegarde demand�e est une Diff ou TLog, il faut demander une sauvegarde compl�te:

IF ((upper(@type_sauvegarde) NOT IN ('COMPLET','COPY_ONLY')) AND NOT EXISTS (select 1 from msdb.dbo.backupset where database_name=@nom_base and type='D' and is_copy_only = 0))

EXEC sauvegarde_base @nom_base, 'COMPLET', @repertoire_destination

----------- G�r�ration de la cha�ne de caract�res correspondant � la destination
set @prefixe_fichier = REPLACE(@nom_base,' ','_') + '_' + upper(@type_sauvegarde) + '_'+ convert(varchar(8),getdate(),112) + '_' + RIGHT('0'+CONVERT(varchar(2),datepart(hh,getdate())),2)+ RIGHT('0'+CONVERT(varchar(2),datepart(mi,getdate())),2)+RIGHT('0'+CONVERT(varchar(2),datepart(ss,getdate())),2)
set @cmd = 'mkdir "'+@repertoire_destination + '\'+REPLACE(@nom_base,' ','_')+'"'

-- Le r�pertoire est cr�� � la vol�e
TRUNCATE TABLE #TABLE_OUTPUT
INSERT INTO #TABLE_OUTPUT
EXECUTE @code_retour=master.dbo.xp_cmdshell @cmd

-- Si le r�pertoire ne peut �tre cr�� pour une cause autre que le fait qu'il existe d�j�, on sort en erreur
IF (@code_retour !=0 AND NOT EXISTS (select * from #TABLE_OUTPUT WHERE ligne like '%already exists%' OR ligne like '%existe d%'))
BEGIN
SELECT @msg = 'Echec de l'' ex�cution de sauvegarde_base lors de l''appel � '+ISNULL(@cmd,'?')+':'+ligne FROM #TABLE_OUTPUT WHERE ligne IS NOT NULL
RAISERROR (@msg, 16, 1) WITH NOWAIT,LOG
return 1
END
SET @destination = 'DISK='''+LTRIM(RTRIM(@repertoire_destination)) + '\'+REPLACE(@nom_base,' ','_')+'\'+@prefixe_fichier+'.BAK'''

-- G�n�ration de la commande BACKUP DATABASE ou BACKUP LOG en fonction du type de sauvegarde demand�
IF (upper(@type_sauvegarde)='LOG')
BEGIN
IF databasepropertyex(@nom_base,'Recovery')='SIMPLE'
BEGIN
SET @msg = 'Echec de l'' ex�cution de sauvegarde_base : La base '+ISNULL(@nom_base,'(valeur nulle)')+' est en mode de recouvrement SIMPLE, les sauvegardes de LOG sont donc impossibles'
RAISERROR (@msg, 16, 1) WITH NOWAIT,LOG
return 1
END
SET @cmd = 'BACKUP LOG ['+@nom_base+'] TO '+@destination +' WITH INIT'
END
ELSE SET @cmd = 'BACKUP DATABASE ['+@nom_base+'] TO '+@destination +' WITH INIT'
IF (upper(@type_sauvegarde)='COPY_ONLY')
SET @cmd = @cmd + ', COPY_ONLY'

IF (upper(@type_sauvegarde)='DIFFERENTIEL')
SET @cmd = @cmd + ', DIFFERENTIAL'

PRINT @cmd
EXECUTE(@cmd)

IF NOT EXISTS (select 1 from msdb.dbo.backupmediafamily where physical_device_name like '%'+@prefixe_fichier+'%')
BEGIN
SET @msg='Echec de l'' ex�cution de sauvegarde_base lors de l''appel � '+ISNULL(@cmd,'?') +'. Consultez le journal d''erreurs pour plus d''informations'
RAISERROR (@msg, 16, 1) WITH NOWAIT,LOG
return 1
END
END
GO