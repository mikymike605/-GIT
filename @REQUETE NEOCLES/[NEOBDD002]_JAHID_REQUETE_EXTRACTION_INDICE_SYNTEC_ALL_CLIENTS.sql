/************************************************************************************************************/
/****************** JAHID-----EXTRACTION PAR CLIENTS DES INDICES SYNTEC SUR 1AN ******************/
/************************************************************************************************************/
SELECT b.date, b.indice,compte_client
  FROM [facturation].[dbo].[factures] a
  inner join [facturation].[dbo].[indices]b
  on LEFT(CONVERT(varchar, a.date,20),7)+'-01 00:00:00.000'=b.date -------------LEFT(CONVERT(varchar, a.date,20),7)+'-01 00:00:00.000' convertir la date pour la jointure avec les clients dont la date est différentes au 20210101 ex 20210115
  --where [compte_client] like 'VIA%'
  and  year ( b.date )>= '2021'
  group by b.indice,b.date,compte_client
  order by 3,1-- desc 

/************************************************************************************************************/
/****************** Script for SelectTopNRows command from SSMS  ******************/
/************************************************************************************************************/
SELECT *--b.date, b.indice,compte_client
  FROM [facturation].[dbo].[factures] a
  inner join [facturation].[dbo].[indices]b
  on a.date=b.date
  where [compte_client] like 'VIA%'
  --and year ( b.date )>= '2020'
  --group by b.indice,b.date,compte_client
  order by 2--3,1-- desc 
  
/************************************************************************************************************/ 
/****************** CONTROLE DES INDICES SYNTEC PAR DATE ******************/
/************************************************************************************************************/
SELECT [date]
      ,[indice]
  FROM [facturation].[dbo].[indices]
  where date ='2021-03-01 00:00:00.000'
  order by 1 desc 

  SELECT * FROM comptes
  where resilie is null
  order by 3