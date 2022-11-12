------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
---- https://stackoverflow.com/questions/53423036/how-to-get-server-roles-and-database-roles-in-a-same-query-script ----
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
select @@SERVERNAME AS 'ServerName',
       logins.default_database_name AS DatabaseSchemaName,
       logins.name As LoginName,
       logins.type As Type,
    logins.type_desc As Type_Desc,
       sr.[name] COLLATE DATABASE_DEFAULT AS 'Roles&Permissions'                 
from  sys.server_principals logins 
inner join sys.server_role_members srm on logins.principal_id = srm. member_principal_id
Inner join sys.server_principals sr ON role_principal_id = sr.principal_id 
where logins.is_fixed_role <>1


/* SELECT @@SERVERNAME as 'Server Name',
       logins.default_schema_name AS SchemaName,
       logins.name AS Name,
    logins.type As Type,
    logins.type_desc AS Type_Desc,
       db.[name] COLLATE DATABASE_DEFAULT AS 'Roles&Permissions'                 
FROM  sys.database_principals logins 
inner join sys.database_role_members drm on logins.principal_id = drm.member_principal_id
Inner join sys.database_principals db ON role_principal_id = db.principal_id
 */

------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
---- https://www.kodyaz.com/sql-server-tools/list-database-user-role-memberships-for-all-databases.aspx ----
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
CREATE TABLE EY_DatabaseRoles (
 dbname sysname,
 principle sysname,
 roles varchar(max)
)

select
 db_name() dbname,
 dp.name principle,
 rp.name role
from [sys].[database_role_members] drm
inner join [sys].[database_principals] rp on rp.principal_id = drm.role_principal_id
inner join [sys].[database_principals] dp on dp.principal_id = drm.member_principal_id
order by 2 

EXEC sp_MSForEachDB '
 Use [?];
 INSERT INTO master..EY_DatabaseRoles
  select
   db_name() dbname,
   dp.name principle,
   rp.name role
  from [sys].[database_role_members] drm
  inner join [sys].[database_principals] rp on rp.principal_id = drm.role_principal_id
  inner join [sys].[database_principals] dp on dp.principal_id = drm.member_principal_id;'
  
  SELECT distinct
 e.dbname,
 e.principle,
 STUFF(
 (
  SELECT
   ',' + ISNULL(c.roles,'')
  FROM EY_DatabaseRoles c
  WHERE c.dbname = e.dbname and c.principle = e.principle
  FOR XML PATH('')
  ,TYPE
  ).value('.','VARCHAR(MAX)'
 ), 1, 1, ''
 ) As database_roles
FROM master..EY_DatabaseRoles e
order by 2