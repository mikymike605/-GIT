/*Afficher les Index non utilis�s*/

select object_name(i.object_id) as NomTable,isnull( i.name,'HEAP') as IndexName

from sys.objects o inner join sys.indexes i

ON i.[object_id] = o.[object_id] left join

sys.dm_db_index_usage_stats s

on i.index_id = s.index_id and s.object_id = i.object_id

where object_name(o.object_id) is not null

and object_name(s.object_id)

is null

and o.[type] = 'U'

and isnull( i.name,'HEAP') <>'HEAP'

union all

select object_name(i.object_id) as NomTable,isnull( i.name,'HEAP') as IndexName

from sys.objects o inner join sys.indexes i

ON i.[object_id] = o.[object_id] left join

sys.dm_db_index_usage_stats s

on i.index_id = s.index_id and s.object_id = i.object_id

where user_seeks= 0

and user_scans=0

and user_lookups= 0

and o.[type] = 'U'

and isnull( i.name,'HEAP') <>'HEAP'

order by NomTable asc

 

/*G�n�rer le script de suppression pour les Index non utilis�s*/

select

 'drop index ' + stats.table_name + '.' + i.name as DropIndexStatement,

 stats.table_name as TableName,

 i.name as IndexName,

 i.type_desc as IndexType,

 stats.seeks + stats.scans + stats.lookups as TotalAccesses,

 stats.seeks as Seeks,

 stats.scans as Scans,

 stats.lookups as Lookups

 from

 (select

 i.object_id,

 object_name(i.object_id) as table_name,

 i.index_id,

 sum(i.user_seeks) as seeks,

 sum(i.user_scans) as scans,

 sum(i.user_lookups) as lookups

 from

 sys.tables t

 inner join sys.dm_db_index_usage_stats i

 on t.object_id = i.object_id

 group by

 i.object_id,

 i.index_id

 ) as stats

 inner join sys.indexes i

 on stats.object_id = i.object_id

 and stats.index_id = i.index_id

 where stats.seeks + stats.scans + stats.lookups = 0 --Finds indexes not being used

 and i.type_desc = 'NONCLUSTERED' --Only NONCLUSTERED indexes

 and i.is_primary_key = 0 --Not a Primary Key

 and i.is_unique = 0 --Not a unique index

 and stats.table_name not like 'sys%'

 order by stats.table_name, i.name
