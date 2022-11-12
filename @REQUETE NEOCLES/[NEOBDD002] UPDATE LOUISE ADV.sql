/*SE CONNECTER AU SERVEUR FACTURATION "NEOBDD002" - SE CONNECTER A LA BASE DE PROD "FACTURATION" 

-	Mettre fin au contrat de Geodis (en masse) au 15/12/2021 sauf  Geodis réversibilité qui  reste facturable jusqu’en avril 2022 ;
-	Mettre fin au contrat de Click and Transfert au 17/12/2021
-	Mettre en masse à jour le compte SAFT, date de fin 01/08/2022


*/

SELECT * FROM comptes
WHERE CODE = 'SFT'

SELECT * FROM comptes
WHERE CODE =  'SFT'
and resilie is null

SELECT * FROM clients
where code = ''

UPDATE comptes
set fin=convert(datetime, '01-08-2022',105)--, resilie=1
WHERE code like 'SFT'
and resilie is null


--update comptes
--set fin=convert(datetime, '15-12-2021',105), resilie=1
--where code='GDS' and resilie is null and compte <> 'GEODISDMS REVERSIBILTE'