use facturation_dev
go

--Renommage d'un compte client 

declare @old_compte as varchar(50)
declare @new_compte as varchar(50)
set @old_compte='XXXXX'
set @new_compte='YYYYY'

insert into comptes 
	select @new_compte,intitule --ou @new_compte
		,code,offre,commentaire,fin,echu,periodicite,resilie,debut,bascule,duree,indice_ref
		,id_fusion,id_fusion2,id_comptable,modefac,commfac,indiceFige
	from comptes 
	where compte = @old_compte

update contrats set compte_client=@new_compte where compte_client=@old_compte
update factures set compte_client=@new_compte where compte_client=@old_compte

delete from comptes where compte = @old_compte

--option
--update comptes set intitule=@new_compte where compte=@new_compte
