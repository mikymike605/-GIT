--script a passer sur le serveur 1 pour récupérer les base par defaut d'un login 

select name, default_database_name, 'ALTER LOGIN ['+name+'] WITH DEFAULT_DATABASE = ['+default_database_name+']' 
from sys.server_principals
where default_database_name <> 'master'
