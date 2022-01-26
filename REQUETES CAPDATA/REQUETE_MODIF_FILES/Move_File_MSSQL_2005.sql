-- D�claration des variables


DECLARE @DB_Name nvarchar(255)


DECLARE @DataPath nvarchar(255) 
set @DataPath = 'C:\DATA\'


DECLARE @LogPath nvarchar(255) 
set @LogPath = 'C:\Log\'


DECLARE @LogicalFileName nvarchar(MAX)


DECLARE @FileType nvarchar(255)


DECLARE @FileExtension nvarchar(255)


DECLARE @FranmerQuery nvarchar(MAX)


DECLARE @PhysicalFileName nvarchar(MAX)


--Cr�ation d'une table temporaire pour stocker les informations des fichiers de donn�es et logs.


--Le pr�fixe # devant le nom de la table (MyDB dans cet exemple) permet de cr�er la table dans la base TempDB.


CREATE Table #MyDB (MyDB_DBName nvarchar(255), MyDB_DBLogicalFileName nvarchar(255), MyDB_DBFileType nvarchar(255),MyDB_DBFileExtension nvarchar(255),MyDB_DBPhysicalFileName nvarchar(255))


-- Insertion des donn�es dans la table temporaire � partir des tables syst�mes sys.master_files et sys.databases


INSERT INTO #MyDB (MyDB_DBName , MyDB_DBLogicalFileName , MyDB_DBFileType ,MyDB_DBFileExtension, MyDB_DBPhysicalFileName )


Select b.name as DBName, a.name as BdLogicalFileName, a.type_desc as DBFileType, RIGHT(physical_name,CHARINDEX('\',physical_name)) as Extension, reverse(left(reverse(physical_name), charindex('\', reverse(physical_name)) -1)) as PhysicalFileName from


master.sys.master_files a inner join sys.databases b


ON a.database_id = b.database_id


-- D�claration d'un curseur afin de parcourir les lignes de la table temporaire


DECLARE MyCursor CURSOR FOR select MyDB_DBName , MyDB_DBLogicalFileName , MyDB_DBFileType ,MyDB_DBFileExtension,MyDB_DBPhysicalFileName FROM #MyDB;


OPEN MyCursor;


-- Cr�ation de la requ�te ALTER DATABASE en r�cup�rant, ligne par ligne, les informations de la table temporaire afin de remplir les diff�rentes variables


FETCH NEXT FROM MyCursor INTO @DB_Name, @LogicalFileName , @FileType, @FileExtension, @PhysicalFileName;


-- Balayage ligne par ligne de la table temporaire jusqu'� la fin


WHILE @@FETCH_STATUS = 0


BEGIN


-- Test du type de fichier pour orienter les fichiers de donn�es (ROWS) sur un disque et les fichiers des transactions sur un autre disque


IF @Filetype = 'ROWS'


SET @FranmerQuery = 'ALTER DATABASE [' + @DB_Name + '] MODIFY FILE (NAME =''' + @LogicalFileName +''', FILENAME = '''+ @DataPath + @PhysicalFileName + ''')'


ELSE


SET @FranmerQuery = 'ALTER DATABASE [' + @DB_Name + '] MODIFY FILE (NAME = ''' + @LogicalFileName +''', FILENAME =''' + @LogPath + @PhysicalFileName +''')'


-- L'utilisation du PRINT sert � v�rifier la bonne syntaxe de la commande


-- Si la syntaxe est correcte, alors on remplacera PRINT par EXECUTE


PRINT (@FranmerQuery)


FETCH NEXT FROM MyCursor INTO @DB_Name, @LogicalFileName , @FileType, @FileExtension, @PhysicalFileName;


END


CLOSE MyCursor;


DEALLOCATE MyCursor;


DROP TABLE #MyDB