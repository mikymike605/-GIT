-------Pour effectuer une sauvegarde compl�te dans le m�me 
-------dossier de toutes les bases de donn�es utilisateur en mode simple. 
-------C'est un cas o� vous voudrez utiliser le param�tre @suppress_quotename, 
-------sinon vous vous retrouverez avec des fichiers nomm�s [database_name] .bak.

EXEC sp_foreachdb
@command = N'BACKUP DATABASE [?]
TO DISK = ''\\AUBFRM83T040\Share_SQL\?.bak''
WITH INIT, COMPRESSION;',
@user_only = 1,
@recovery_model_desc = N'SIMPLE',
@suppress_quotename = 1;

-------Pour rechercher toutes les bases de donn�es correspondant 
-------au motif de nom 'Company%' pour les objets correspondant au 
-------motif de nom '% foo%'. Placer dans une table #temp de sorte 
-------que le r�sultat est un ensemble de r�sultats unique au lieu 
-------du nombre de bases de donn�es qui correspondent au mod�le de nommage.
CREATE TABLE #x(n SYSNAME);
EXEC sp_foreachdb
@command = N'INSERT #x SELECT name
FROM ?.sys.objects
WHERE name LIKE N''%foo%'';',
@name_pattern = N'Company%';

-------Pour d�sactiver auto_shrink pour toutes les bases de donn�es o� il est activ�:
SELECT * FROM #x;
DROP TABLE #x;
EXEC sp_foreachdb
@command = N'ALTER DATABASE ? SET AUTO_SHRINK OFF;',
@is_auto_shrink_on = 1;

-------Pour trouver la derni�re date / heure de 
-------l'objet cr�� pour chaque base de donn�es dans 
-------un ensemble d�fini (dans ce cas, trois bases de donn�es 
-------que je connais existent).
EXEC sp_foreachdb
@command = N'SELECT N''?'', MAX(create_date) FROM ?.sys.objects;',
@database_list = 'master,model,msdb';

-------Pour r�initialiser le service broker 
-------pour chaque base de donn�es 
-------apr�s avoir test� une application, par exemple:
EXEC sp_foreachdb
@command = N'ALTER DATABASE ? SET NEW_BROKER;',
@is_broker_enabled = 1;