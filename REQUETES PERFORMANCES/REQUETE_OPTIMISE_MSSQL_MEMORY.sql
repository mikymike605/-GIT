/*
https://www.sqlshack.com/insight-into-the-sql-server-buffer-cache/
*/
--Les r�sultats de cette requ�te me renseignent un peu sur l'utilisation de la m�moire sur mon serveur:
SELECT
	physical_memory_kb/1024/1024 as physical_memory_Gb,
	virtual_memory_kb/1024/1024 as virtual_memory_Gb ,
	committed_kb/1024/1024 as committed_Gb ,
	committed_target_kb/1024/1024 as committed_target_Gb
FROM sys.dm_os_sys_info;

 /*
 Cette requ�te renvoie, dans l'ordre de la plupart des pages en m�moire au plus petit nombre, 
 la quantit� de m�moire consomm�e par chaque base de donn�es dans le cache de la m�moire tampon:
 */
 SELECT
    databases.name AS database_name,
    COUNT(*) * 8 / 1024 AS mb_used
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.databases
ON databases.database_id = dm_os_buffer_descriptors.database_id
GROUP BY databases.name
ORDER BY COUNT(*) DESC;

 /*
Cela retourne une seule ligne contenant le nombre de pages du cache, ainsi que la m�moire consomm�e par celles-ci:
Une page ayant une taille de 8 Ko, nous pouvons convertir le nombre de pages en m�gaoctets en multipliant par 8 pour obtenir le Ko, 
puis diviser par 1024 pour arriver � MB. 
*/
SELECT
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024/1024 AS buffer_cache_used_GB
FROM sys.dm_os_buffer_descriptors;

/*
Nous pouvons subdiviser la requete ci dessus et regarder comment le cache de m�moire tampon est utilis� par des objets sp�cifiques. 
Cela peut fournir beaucoup plus d'informations sur l'utilisation de la m�moire car nous pouvons d�terminer quelles tables sont des porcs de m�moire. 
De plus, nous pouvons v�rifier certaines m�triques int�ressantes, telles que le pourcentage de table actuellement en m�moire 
ou les tables rarement utilis�es (ou non). La requ�te suivante renverra des pages tampon et une taille par table:
Les tables syst�me sont exclues et cela extraira uniquement les donn�es pour la base de donn�es actuelle. 
Les vues index�es seront incluses car leurs index sont des entit�s distinctes des tables dont ils sont d�riv�s. 
La jointure sur sys.partitions contient deux parties afin de tenir compte des index, ainsi que des segments. 
Les donn�es pr�sent�es ici incluent tous les index d'une table, ainsi que le tas, s'il n'y en a pas de d�fini.
Un segment des r�sultats est le suivant (pour AdventureWorks2014):
*/
SELECT
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024 /1024 AS buffer_cache_used_GB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY objects.name,
		 objects.type_desc
ORDER BY COUNT(*) DESC;
 
/*
De m�me, nous pouvons s�parer ces donn�es par index, plut�t que par table, ce qui offre encore plus de pr�cision sur l�utilisation du cache tampon:
*/
  
SELECT
	indexes.name AS index_name,
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024  AS buffer_cache_used_MB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
INNER JOIN sys.indexes
ON objects.object_id = indexes.object_id
AND partitions.index_id = indexes.index_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY indexes.name,
		 objects.name,
		 objects.type_desc
ORDER BY COUNT(*) DESC;

/*
Pour collecter le pourcentage de chaque table en m�moire, nous pouvons placer cette requ�te dans un CTE et comparer 
les pages en m�moire au total de chaque table:
Cette requ�te rejoint notre jeu de donn�es pr�c�dent avec une requ�te sur sys.dm_db_partition_stats afin de comparer 
ce qui se trouve actuellement dans le cache du tampon et l�espace total utilis� par une table donn�e. 
Les diff�rentes op�rations CAST � la fin aident � �viter la troncature et rendent le r�sultat final sous une forme facile � lire. 
Les r�sultats sur mon serveur local sont les suivants:
*/
WITH CTE_BUFFER_CACHE AS (
	SELECT
		objects.name AS object_name,
		objects.type_desc AS object_type_description,
		objects.object_id,
		COUNT(*) AS buffer_cache_pages,
		COUNT(*) * 8 / 1024  AS buffer_cache_used_MB
	FROM sys.dm_os_buffer_descriptors
	INNER JOIN sys.allocation_units
	ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
	INNER JOIN sys.partitions
	ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
	OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
	INNER JOIN sys.objects
	ON partitions.object_id = objects.object_id
	WHERE allocation_units.type IN (1,2,3)
	AND objects.is_ms_shipped = 0
	AND dm_os_buffer_descriptors.database_id = DB_ID()
	GROUP BY objects.name,
			 objects.type_desc,
			 objects.object_id)

/*
Cette requ�te peut �tre modifi�e pour fournir le pourcentage d'un index utilis�, 
similaire � la mani�re dont nous avons collect� le pourcentage d'une table utilis�e:
*/
SELECT
	PARTITION_STATS.name,
	CTE_BUFFER_CACHE.object_type_description,
	CTE_BUFFER_CACHE.buffer_cache_pages,
	CTE_BUFFER_CACHE.buffer_cache_used_MB,
	PARTITION_STATS.total_number_of_used_pages,
	PARTITION_STATS.total_number_of_used_pages * 8 / 1024 AS total_mb_used_by_object,
	CAST((CAST(CTE_BUFFER_CACHE.buffer_cache_pages AS DECIMAL) / CAST(PARTITION_STATS.total_number_of_used_pages AS DECIMAL) * 100) AS DECIMAL(5,2)) AS percent_of_pages_in_memory
FROM CTE_BUFFER_CACHE
INNER JOIN (
	SELECT 
		objects.name,
		objects.object_id,
		SUM(used_page_count) AS total_number_of_used_pages
	FROM sys.dm_db_partition_stats
	INNER JOIN sys.objects
	ON objects.object_id = dm_db_partition_stats.object_id
	WHERE objects.is_ms_shipped = 0
	GROUP BY objects.name, objects.object_id) PARTITION_STATS
ON PARTITION_STATS.object_id = CTE_BUFFER_CACHE.object_id
ORDER BY CAST(CTE_BUFFER_CACHE.buffer_cache_pages AS DECIMAL) / CAST(PARTITION_STATS.total_number_of_used_pages AS DECIMAL) DESC;
 
 --EXEC DBAtools..sp_BlitzCache


/*
Cela retourne une ligne par base de donn�es indiquant l'agr�gat d'espace libre par base de donn�es, 
additionn� sur toutes les pages du cache de la m�moire tampon pour cette base de donn�es particuli�re:
*/
WITH CTE_BUFFER_CACHE AS
( SELECT
  databases.name AS database_name,
  COUNT(*) AS total_number_of_used_pages,
  CAST(COUNT(*) * 8 AS DECIMAL) / 1024 AS buffer_cache_total_MB,
  CAST(CAST(SUM(CAST(dm_os_buffer_descriptors.free_space_in_bytes AS BIGINT)) AS DECIMAL) / (1024 * 1024) AS DECIMAL(20,2))  AS buffer_cache_free_space_in_MB
 FROM sys.dm_os_buffer_descriptors
 INNER JOIN sys.databases
 ON databases.database_id = dm_os_buffer_descriptors.database_id
 GROUP BY databases.name)
SELECT
 *,
 CAST((buffer_cache_free_space_in_MB / NULLIF(buffer_cache_total_MB, 0)) * 100 AS DECIMAL(5,2)) AS buffer_cache_percent_free_space
FROM CTE_BUFFER_CACHE
ORDER BY buffer_cache_free_space_in_MB / NULLIF(buffer_cache_total_MB, 0) DESC

/*
Cela retourne une ligne par table ou vue index�e qui contient au moins une page dans le cache de la m�moire tampon, 
ordonn�e par celles qui contiennent le plus de pages en m�moire en premier.
*/

SELECT
	indexes.name AS index_name,
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_pages,
	COUNT(*) * 8 / 1024  AS buffer_cache_used_MB,
	SUM(allocation_units.used_pages) AS pages_in_index,
	SUM(allocation_units.used_pages) * 8 /1024 AS total_index_size_MB,
	CAST((CAST(COUNT(*) AS DECIMAL) / CAST(SUM(allocation_units.used_pages) AS DECIMAL) * 100) AS DECIMAL(5,2)) AS percent_of_pages_in_memory
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
INNER JOIN sys.indexes
ON objects.object_id = indexes.object_id
AND partitions.index_id = indexes.index_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY indexes.name,
		 objects.name,
		 objects.type_desc
ORDER BY CAST((CAST(COUNT(*) AS DECIMAL) / CAST(SUM(allocation_units.used_pages) AS DECIMAL) * 100) AS DECIMAL(5,2)) DESC;


/*
Cette requ�te renvoie le nombre de pages et la taille des donn�es en MB par DB :
*/

SELECT
    databases.name AS database_name,
	COUNT(*) AS buffer_cache_total_pages,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 1
				ELSE 0
		END) AS buffer_cache_dirty_pages,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 0
				ELSE 1
		END) AS buffer_cache_clean_pages,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 1
				ELSE 0
		END) * 8 / 1024 AS buffer_cache_dirty_page_MB,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 0
				ELSE 1
		END) * 8 / 1024 AS buffer_cache_clean_page_MB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.databases
ON dm_os_buffer_descriptors.database_id = databases.database_id
GROUP BY databases.name;


/*
Cette requ�te renvoie le nombre de pages et la taille des donn�es en MB par tABLES :
*/

SELECT
	indexes.name AS index_name,
	objects.name AS object_name,
	objects.type_desc AS object_type_description,
	COUNT(*) AS buffer_cache_total_pages,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 1
				ELSE 0
		END) AS buffer_cache_dirty_pages,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 0
				ELSE 1
		END) AS buffer_cache_clean_pages,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 1
				ELSE 0
		END) * 8 / 1024 AS buffer_cache_dirty_page_MB,
    SUM(CASE WHEN dm_os_buffer_descriptors.is_modified = 1
				THEN 0
				ELSE 1
		END) * 8 / 1024 AS buffer_cache_clean_page_MB
FROM sys.dm_os_buffer_descriptors
INNER JOIN sys.allocation_units
ON allocation_units.allocation_unit_id = dm_os_buffer_descriptors.allocation_unit_id
INNER JOIN sys.partitions
ON ((allocation_units.container_id = partitions.hobt_id AND type IN (1,3))
OR (allocation_units.container_id = partitions.partition_id AND type IN (2)))
INNER JOIN sys.objects
ON partitions.object_id = objects.object_id
INNER JOIN sys.indexes
ON objects.object_id = indexes.object_id
AND partitions.index_id = indexes.index_id
WHERE allocation_units.type IN (1,2,3)
AND objects.is_ms_shipped = 0
AND dm_os_buffer_descriptors.database_id = DB_ID()
GROUP BY indexes.name,
		 objects.name,
		 objects.type_desc
ORDER BY COUNT(*) DESC;