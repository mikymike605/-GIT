-- J'utilise la base master, mais vous pouvez utiliser une autre base de votre choix 
USE AdminSQL 
GO 
IF NOT EXISTS ( SELECT p.* 
				FROM sys.procedures AS p WITH (nolock) 
				INNER JOIN sys.schemas AS s WITH (nolock) 
				  ON p.schema_id = p.schema_id 
				WHERE s.name = N'dbo' AND P.name = N'uspListeFichiersDataOuLogOrphelinsDeBasesDeDonnees' AND P.type IN (N'P', N'PC') 
			  ) 
BEGIN 
	EXEC dbo.sp_executesql 
		 @statement = N'CREATE PROCEDURE dbo.uspListeFichiersDataOuLogOrphelinsDeBasesDeDonnees 
AS 
BEGIN 
-- !!! "Stub" doit �tre impl�ment� !!! 
SET NOCOUNT ON; 
END; '; 
END; 
GO 
  
-- ---------------------------------------------------------------------------- 
-- Proc�dure          : dbo.uspListeFichiersDataOuLogOrphelinsDeBasesDeDonnees 
-- Cr�ateur           : Hamid MIRA 
-- Date de cr�ation   : 28/12/2016 
-- Objet              : Ce script permet de lister les fichiers de donn�es (.mdf, .ndf, etc.) 
--                      ou les fichiers de journaux de transactions (.ldf) orphelins, c.�.d. des fichiers (.mdf, .ndf, ldf , etc.) 
--                      qui ne sont rattach�s � aucune base de donn�es du Serveur. 
-- Param�tres : 
--   @pi_DefaultDirectoryData : Le r�pertoire explicite des fichiers de donn�es (.mdf, ndf)  Exemple : N'C:\SQL\Data' 
--                              Transmettez NULL pour utiliser le r�pertoire par d�faut des fichiers de donn�es d�fini au niveau de l'instance 
--   @pi_DefaultDirectoryLog  : Le r�pertoire explicite des fichiers des journaux de transaction  (.ldf) )  Exemple : 'C:\SQL\Log' 
--                              Transmettez NULL pour utiliser le r�pertoire par d�faut des fichiers des journaux de transactions d�fini au niveau de l'instance 
-- Exemple d'utilisation : 
--   EXEC dbo.uspListeFichiersDataOuLogOrphelinsDeBasesDeDonnees NULL, NULL 
--   EXEC dbo.uspListeFichiersDataOuLogOrphelinsDeBasesDeDonnees N'D:\DATA', N'L:\Log' 
-- ---------------------------------------------------------------------------- 
ALTER PROCEDURE dbo.uspListeFichiersDataOuLogOrphelinsDeBasesDeDonnees 
(@pi_DefaultDirectoryData nvarchar(512) = NULL, 
 @pi_DefaultDirectoryLog  nvarchar(512) = NULL  ) 
AS 
BEGIN 
	SET NOCOUNT ON 
	DECLARE @MasterDirectoryData nvarchar(512), 
			@MasterDirectoryLog nvarchar(512),  
			@VersionMajor tinyint; 
  
	SET @VersionMajor = CAST(LEFT(CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(128)), CHARINDEX('.',CAST(SERVERPROPERTY('ProductVersion') AS nvarchar(128))) - 1) AS INT); 
	PRINT '@VersionMajor=['+CAST(ISNULL(@VersionMajor,-1) AS VARCHAR(2))+']'; 
  
	IF @pi_DefaultDirectoryData IS NULL 
	BEGIN 
		-- Version SQL Server 2008 R2 (incluse) et versions ant�rieures 
		IF @VersionMajor <= 10 
		BEGIN 
			EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultData', @pi_DefaultDirectoryData output 
		END 
		ELSE 
		BEGIN 
			-- Version SQL Server 2012 (incluse) et versions sup�rieures 
			SET @pi_DefaultDirectoryData =	CAST(SERVERPROPERTY('INSTANCEDEFAULTDATAPATH') AS nvarchar(512)); 
		END; 
		IF @pi_DefaultDirectoryData IS NULL 
		BEGIN 
			EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters', N'SqlArg0', @MasterDirectoryData output 
			SET @MasterDirectoryData = SUBSTRING(@MasterDirectoryData, 3, 255) 
			SET @MasterDirectoryData = SUBSTRING(@MasterDirectoryData, 1, LEN(@MasterDirectoryData) - CHARINDEX('\', REVERSE(@MasterDirectoryData))) 
			SET @pi_DefaultDirectoryData = @MasterDirectoryData; 
		END; 
	END; 
  
	IF @pi_DefaultDirectoryLog IS NULL 
	BEGIN 
		-- Version SQL Server 2008 R2 (incluse) et versions ant�rieures 
		IF @VersionMajor <= 10 
		BEGIN 
			EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultLog', @pi_DefaultDirectoryLog output 
		END 
		ELSE 
		BEGIN 
			-- Version SQL Server 2012 (incluse) et versions sup�rieures 
			SET @pi_DefaultDirectoryLog =  CAST( SERVERPROPERTY('INSTANCEDEFAULTLOGPATH') AS nvarchar(512)); 
		END; 
  
		IF @pi_DefaultDirectoryLog IS NULL 
		BEGIN 
			EXEC master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters', N'SqlArg2', @MasterDirectoryLog output 
			SET @MasterDirectoryLog = SUBSTRING(@MasterDirectoryLog, 3, 255) 
			SET @MasterDirectoryLog = SUBSTRING(@MasterDirectoryLog, 1, LEN(@MasterDirectoryLog) - CHARINDEX('\', REVERSE(@MasterDirectoryLog))) 
			SET @pi_DefaultDirectoryLog = @MasterDirectoryLog; 
		END; 
	END; 
  
	-- Recadrage �ventuel de la valeur @pi_DefaultDirectoryData 
	SET @pi_DefaultDirectoryData = RTRIM(LTRIM((@pi_DefaultDirectoryData))); 
	SET @pi_DefaultDirectoryData  = LEFT(@pi_DefaultDirectoryData, 2) + REPLACE (RIGHT(@pi_DefaultDirectoryData, len(@pi_DefaultDirectoryData) -2), '\\', '\'); 
	IF RIGHT(@pi_DefaultDirectoryData, 1) <> '\' 
		SET @pi_DefaultDirectoryData = @pi_DefaultDirectoryData + '\'; 
  
    -- Recadrage �ventuel de la valur @pi_DefaultDirectoryLog 
	SET @pi_DefaultDirectoryLog = RTRIM(LTRIM(( @pi_DefaultDirectoryLog))); 
	SET @pi_DefaultDirectoryLog =  LEFT(@pi_DefaultDirectoryLog, 2) + REPLACE (RIGHT(@pi_DefaultDirectoryLog, len(@pi_DefaultDirectoryLog) -2), '\\', '\'); 
	IF RIGHT( @pi_DefaultDirectoryLog, 1) <> '\' 
		SET @pi_DefaultDirectoryLog = @pi_DefaultDirectoryLog + '\'; 
  
	PRINT '@pi_DefaultDirectoryData=[' +ISNULL(@pi_DefaultDirectoryData, '{NULL}') +']'; 
	PRINT '@pi_DefaultDirectoryLog=[' +ISNULL( @pi_DefaultDirectoryLog, '{NULL}') +']'; 
  
	IF OBJECT_ID('tempdb.dbo.#DirTreeData') IS NOT NULL 
		DROP TABLE #DirTreeData 
	IF OBJECT_ID('tempdb.dbo.#DirTreeLog') IS NOT NULL 
		DROP TABLE #DirTreeLog 
  
	-- ----------------------------------------- 
	CREATE TABLE #DirTreeData( 
		Id int identity(1,1) PRIMARY KEY CLUSTERED, 
		SubDirectory nvarchar(255), 
		Depth smallint, 
		FileFlag bit, 
		ParentDirectoryID int 
		); 
	CREATE TABLE #DirTreeLog( 
		Id int identity(1,1) PRIMARY KEY CLUSTERED, 
		SubDirectory nvarchar(255), 
		Depth smallint, 
		FileFlag bit, 
		ParentDirectoryID int 
		); 
  
	INSERT INTO #DirTreeData (SubDirectory, Depth, FileFlag) 
	EXEC master..xp_dirtree @pi_DefaultDirectoryData, 1, 1; -- Profondeur : 1 (premier niveau), Lister �galement les fichiers : 1  (Oui) 
  
	UPDATE #DirTreeData 
		SET SubDirectory = @pi_DefaultDirectoryData + LTRIM(RTRIM(SubDirectory)); 
  
	IF ISNULL(@pi_DefaultDirectoryLog, '') <> ISNULL(@pi_DefaultDirectoryData, '') 
	BEGIN 
		INSERT INTO #DirTreeLog(SubDirectory, Depth, FileFlag) 
		EXEC master..xp_dirtree  @pi_DefaultDirectoryLog, 1, 1; -- Profondeur : 1 (premier niveau), lister �galement les fichiers : 1  (Oui) 
		UPDATE #DirTreeLog 
			SET SubDirectory = @pi_DefaultDirectoryLog + LTRIM(RTRIM(SubDirectory)); 
	END 
  
	;WITH smf AS 
	  (SELECT LEFT(RTRIM(LTRIM(physical_name)), 2) + REPLACE (RIGHT(RTRIM(LTRIM(physical_name)), len(RTRIM(LTRIM(physical_name))) -2), '\\', '\') AS physical_name_fmt 
       FROM master.sys.master_files WITH (NOLOCK) ) 
  
	SELECT SubDirectory 
	FROM #DirTreeData  dtd 
	LEFT OUTER JOIN smf 
	   ON smf.physical_name_fmt = dtd.SubDirectory 
	WHERE dtd.FileFlag = 1            -- Fichiers uniquement (ignorer les r�pertoires) 
	AND smf.physical_name_fmt IS NULL -- Pas de correspondance du fichier SubDirectory dans master.sys.master_files 
	UNION ALL 
	SELECT SubDirectory 
	FROM #DirTreeLog dtl 
	LEFT OUTER JOIN smf 
	   ON smf.physical_name_fmt = dtl.SubDirectory 
	WHERE dtl.FileFlag = 1            -- Fichier uniquement (ignorer les r�pertoires) 
	AND smf.physical_name_fmt IS NULL --  Pas de correspondance du fichier SubDirectory dans master.sys.master_files 
	ORDER BY SubDirectory;  
  
	-- Suppression des tables temporaires  
	IF OBJECT_ID('tempdb.dbo.#DirTreeData') IS NOT NULL 
		DROP TABLE #DirTreeData 
	IF OBJECT_ID('tempdb.dbo.#DirTreeLog') IS NOT NULL 
		DROP TABLE #DirTreeLog 
END; 
GO