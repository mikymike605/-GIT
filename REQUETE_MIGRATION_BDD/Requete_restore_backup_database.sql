
										
---- Base import_comptable_test_import									
----BACKUP DATABASE [import_comptable_test_import] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_test_import_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base import_comptable_test_import'
--RESTORE DATABASE [import_comptable_test_import] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_test_import_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
											
---- Base DWH_SupervisionProjets									
----BACKUP DATABASE [DWH_SupervisionProjets] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWH_SupervisionProjets_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DWH_SupervisionProjets'
--RESTORE DATABASE [DWH_SupervisionProjets] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWH_SupervisionProjets_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwh_proudreed_2									
----BACKUP DATABASE [dwh_proudreed_2] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwh_proudreed_2_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwh_proudreed_2'
--RESTORE DATABASE [dwh_proudreed_2] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwh_proudreed_2_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PARIS_PROPERTIES_EVOLUTION									
----BACKUP DATABASE [PARIS_PROPERTIES_EVOLUTION] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PARIS_PROPERTIES_EVOLUTION_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PARIS_PROPERTIES_EVOLUTION'
--RESTORE DATABASE [PARIS_PROPERTIES_EVOLUTION] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PARIS_PROPERTIES_EVOLUTION_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SHEET_ANCHOR_EVOLUTION									
----BACKUP DATABASE [SHEET_ANCHOR_EVOLUTION] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SHEET_ANCHOR_EVOLUTION_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SHEET_ANCHOR_EVOLUTION'
--RESTORE DATABASE [SHEET_ANCHOR_EVOLUTION] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SHEET_ANCHOR_EVOLUTION_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PARIS_HEXAGONE_PROPERTIES									
----BACKUP DATABASE [PARIS_HEXAGONE_PROPERTIES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PARIS_HEXAGONE_PROPERTIES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PARIS_HEXAGONE_PROPERTIES'
--RESTORE DATABASE [PARIS_HEXAGONE_PROPERTIES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PARIS_HEXAGONE_PROPERTIES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base myreport_dwh_proudreed									
----BACKUP DATABASE [myreport_dwh_proudreed] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\myreport_dwh_proudreed_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base myreport_dwh_proudreed'
--RESTORE DATABASE [myreport_dwh_proudreed] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\myreport_dwh_proudreed_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
------ Base CitrixWEM									
------BACKUP DATABASE [CitrixWEM] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixWEM_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CitrixWEM'
----RESTORE DATABASE [CitrixWEM] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixWEM_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
------ Base Citrix_PVS_PRO									
------BACKUP DATABASE [Citrix_PVS_PRO] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\Citrix_PVS_PRO_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base Citrix_PVS_PRO'
----RESTORE DATABASE [Citrix_PVS_PRO] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\Citrix_PVS_PRO_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
------ Base CitrixProudreed715Monitoring									
------BACKUP DATABASE [CitrixProudreed715Monitoring] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixProudreed715Monitoring_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CitrixProudreed715Monitoring'
----RESTORE DATABASE [CitrixProudreed715Monitoring] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixProudreed715Monitoring_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
------ Base CitrixProudreed715Logging									
------BACKUP DATABASE [CitrixProudreed715Logging] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixProudreed715Logging_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CitrixProudreed715Logging'
----RESTORE DATABASE [CitrixProudreed715Logging] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixProudreed715Logging_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
------ Base CitrixProudreed715Site									
------BACKUP DATABASE [CitrixProudreed715Site] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixProudreed715Site_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CitrixProudreed715Site'
----RESTORE DATABASE [CitrixProudreed715Site] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CitrixProudreed715Site_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwbacsweb									
----BACKUP DATABASE [dwbacsweb] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwbacsweb_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwbacsweb'
--RESTORE DATABASE [dwbacsweb] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwbacsweb_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwworkflowengine									
----BACKUP DATABASE [a_dwworkflowengine] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwworkflowengine_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwworkflowengine'
--RESTORE DATABASE [a_dwworkflowengine] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwworkflowengine_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwthumbnail									
----BACKUP DATABASE [a_dwthumbnail] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwthumbnail_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwthumbnail'
--RESTORE DATABASE [a_dwthumbnail] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwthumbnail_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwsystem									
----BACKUP DATABASE [a_dwsystem] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwsystem_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwsystem'
--RESTORE DATABASE [a_dwsystem] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwsystem_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwref									
----BACKUP DATABASE [a_dwref] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwref_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwref'
--RESTORE DATABASE [a_dwref] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwref_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwnotification									
----BACKUP DATABASE [a_dwnotification] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwnotification_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwnotification'
--RESTORE DATABASE [a_dwnotification] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwnotification_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwlogging									
----BACKUP DATABASE [a_dwlogging] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwlogging_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwlogging'
--RESTORE DATABASE [a_dwlogging] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwlogging_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dwdata									
----BACKUP DATABASE [a_dwdata] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwdata_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dwdata'
--RESTORE DATABASE [a_dwdata] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dwdata_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base a_dtr									
----BACKUP DATABASE [a_dtr] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dtr_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base a_dtr'
--RESTORE DATABASE [a_dtr] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\a_dtr_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwdata_qua									
----BACKUP DATABASE [dwdata_qua] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwdata_qua_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwdata_qua'
--RESTORE DATABASE [dwdata_qua] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwdata_qua_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwworkflowengine_oldV7									
----BACKUP DATABASE [dwworkflowengine_oldV7] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwworkflowengine_oldV7_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwworkflowengine_oldV7'
--RESTORE DATABASE [dwworkflowengine_oldV7] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwworkflowengine_oldV7_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DD_TRAINING_TGT									
----BACKUP DATABASE [DD_TRAINING_TGT] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DD_TRAINING_TGT_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DD_TRAINING_TGT'
--RESTORE DATABASE [DD_TRAINING_TGT] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DD_TRAINING_TGT_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DD_TRAINING									
----BACKUP DATABASE [DD_TRAINING] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DD_TRAINING_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DD_TRAINING'
--RESTORE DATABASE [DD_TRAINING] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DD_TRAINING_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base Distributor									
----BACKUP DATABASE [Distributor] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\Distributor_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base Distributor'
--RESTORE DATABASE [Distributor] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\Distributor_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PP									
----BACKUP DATABASE [PP] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PP_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PP'
--RESTORE DATABASE [PP] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PP_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base enterprisevaultdirectory									
----BACKUP DATABASE [enterprisevaultdirectory] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\enterprisevaultdirectory_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base enterprisevaultdirectory'
--RESTORE DATABASE [enterprisevaultdirectory] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\enterprisevaultdirectory_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CONCOURS									
----BACKUP DATABASE [CONCOURS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CONCOURS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CONCOURS'
--RESTORE DATABASE [CONCOURS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CONCOURS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base XRT_U2_FIPAM									
----BACKUP DATABASE [XRT_U2_FIPAM] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\XRT_U2_FIPAM_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base XRT_U2_FIPAM'
--RESTORE DATABASE [XRT_U2_FIPAM] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\XRT_U2_FIPAM_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base VIRY									
----BACKUP DATABASE [VIRY] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\VIRY_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base VIRY'
--RESTORE DATABASE [VIRY] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\VIRY_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base VIGNES									
----BACKUP DATABASE [VIGNES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\VIGNES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base VIGNES'
--RESTORE DATABASE [VIGNES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\VIGNES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TURQUOISE									
----BACKUP DATABASE [TURQUOISE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TURQUOISE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TURQUOISE'
--RESTORE DATABASE [TURQUOISE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TURQUOISE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TROISGP2									
----BACKUP DATABASE [TROISGP2] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TROISGP2_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TROISGP2'
--RESTORE DATABASE [TROISGP2] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TROISGP2_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TOURS									
----BACKUP DATABASE [TOURS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TOURS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TOURS'
--RESTORE DATABASE [TOURS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TOURS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TOURMALINE									
----BACKUP DATABASE [TOURMALINE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TOURMALINE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TOURMALINE'
--RESTORE DATABASE [TOURMALINE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TOURMALINE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TORCY									
----BACKUP DATABASE [TORCY] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TORCY_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TORCY'
--RESTORE DATABASE [TORCY] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TORCY_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TOPAZE									
----BACKUP DATABASE [TOPAZE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TOPAZE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TOPAZE'
--RESTORE DATABASE [TOPAZE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TOPAZE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TESNEDA									
----BACKUP DATABASE [TESNEDA] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TESNEDA_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TESNEDA'
--RESTORE DATABASE [TESNEDA] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TESNEDA_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base TAMARIS									
----BACKUP DATABASE [TAMARIS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TAMARIS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base TAMARIS'
--RESTORE DATABASE [TAMARIS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\TAMARIS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base STQUENTIN									
----BACKUP DATABASE [STQUENTIN] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\STQUENTIN_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base STQUENTIN'
--RESTORE DATABASE [STQUENTIN] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\STQUENTIN_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base STPIERRE									
----BACKUP DATABASE [STPIERRE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\STPIERRE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base STPIERRE'
--RESTORE DATABASE [STPIERRE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\STPIERRE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base STPERAY2									
----BACKUP DATABASE [STPERAY2] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\STPERAY2_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base STPERAY2'
--RESTORE DATABASE [STPERAY2] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\STPERAY2_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SPSA									
----BACKUP DATABASE [SPSA] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SPSA_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SPSA'
--RESTORE DATABASE [SPSA] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SPSA_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SPCR									
----BACKUP DATABASE [SPCR] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SPCR_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SPCR'
--RESTORE DATABASE [SPCR] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SPCR_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SPCP									
----BACKUP DATABASE [SPCP] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SPCP_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SPCP'
--RESTORE DATABASE [SPCP] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SPCP_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SHEETPART									
----BACKUP DATABASE [SHEETPART] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SHEETPART_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SHEETPART'
--RESTORE DATABASE [SHEETPART] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SHEETPART_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SheetAnchorGamma									
----BACKUP DATABASE [SheetAnchorGamma] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorGamma_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SheetAnchorGamma'
--RESTORE DATABASE [SheetAnchorGamma] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorGamma_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SheetAnchorDelta									
----BACKUP DATABASE [SheetAnchorDelta] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorDelta_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SheetAnchorDelta'
--RESTORE DATABASE [SheetAnchorDelta] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorDelta_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SheetAnchorBeta									
----BACKUP DATABASE [SheetAnchorBeta] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorBeta_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SheetAnchorBeta'
--RESTORE DATABASE [SheetAnchorBeta] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorBeta_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SheetAnchorAlpha									
----BACKUP DATABASE [SheetAnchorAlpha] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorAlpha_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SheetAnchorAlpha'
--RESTORE DATABASE [SheetAnchorAlpha] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SheetAnchorAlpha_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SHEET									
----BACKUP DATABASE [SHEET] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SHEET_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SHEET'
--RESTORE DATABASE [SHEET] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SHEET_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SEQUOIAS									
----BACKUP DATABASE [SEQUOIAS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SEQUOIAS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SEQUOIAS'
--RESTORE DATABASE [SEQUOIAS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SEQUOIAS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SAPHIR									
----BACKUP DATABASE [SAPHIR] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAPHIR_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SAPHIR'
--RESTORE DATABASE [SAPHIR] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAPHIR_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SAF6									
----BACKUP DATABASE [SAF6] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF6_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SAF6'
--RESTORE DATABASE [SAF6] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF6_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SAF5									
----BACKUP DATABASE [SAF5] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF5_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SAF5'
--RESTORE DATABASE [SAF5] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF5_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SAF4									
----BACKUP DATABASE [SAF4] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF4_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SAF4'
--RESTORE DATABASE [SAF4] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF4_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SAF3									
----BACKUP DATABASE [SAF3] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF3_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SAF3'
--RESTORE DATABASE [SAF3] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF3_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base SAF2									
----BACKUP DATABASE [SAF2] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF2_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base SAF2'
--RESTORE DATABASE [SAF2] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\SAF2_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base RUBIS									
----BACKUP DATABASE [RUBIS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\RUBIS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base RUBIS'
--RESTORE DATABASE [RUBIS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\RUBIS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base RingmeritAlpha									
----BACKUP DATABASE [RingmeritAlpha] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\RingmeritAlpha_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base RingmeritAlpha'
--RESTORE DATABASE [RingmeritAlpha] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\RingmeritAlpha_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base Ringmerit1									
----BACKUP DATABASE [Ringmerit1] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\Ringmerit1_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base Ringmerit1'
--RESTORE DATABASE [Ringmerit1] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\Ringmerit1_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base QUARTZ									
----BACKUP DATABASE [QUARTZ] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\QUARTZ_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base QUARTZ'
--RESTORE DATABASE [QUARTZ] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\QUARTZ_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PROVILLE									
----BACKUP DATABASE [PROVILLE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PROVILLE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PROVILLE'
--RESTORE DATABASE [PROVILLE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PROVILLE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ProudreedInvestissement									
----BACKUP DATABASE [ProudreedInvestissement] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedInvestissement_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ProudreedInvestissement'
--RESTORE DATABASE [ProudreedInvestissement] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedInvestissement_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ProudreedDelta									
----BACKUP DATABASE [ProudreedDelta] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedDelta_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ProudreedDelta'
--RESTORE DATABASE [ProudreedDelta] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedDelta_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ProudreedBeta									
----BACKUP DATABASE [ProudreedBeta] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedBeta_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ProudreedBeta'
--RESTORE DATABASE [ProudreedBeta] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedBeta_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ProudreedAlpha									
----BACKUP DATABASE [ProudreedAlpha] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedAlpha_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ProudreedAlpha'
--RESTORE DATABASE [ProudreedAlpha] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ProudreedAlpha_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PROUDREED									
----BACKUP DATABASE [PROUDREED] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PROUDREED_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PROUDREED'
--RESTORE DATABASE [PROUDREED] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PROUDREED_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base premiance_actiview_synchro									
----BACKUP DATABASE [premiance_actiview_synchro] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\premiance_actiview_synchro_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base premiance_actiview_synchro'
--RESTORE DATABASE [premiance_actiview_synchro] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\premiance_actiview_synchro_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base premiance_actiview									
----BACKUP DATABASE [premiance_actiview] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\premiance_actiview_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base premiance_actiview'
--RESTORE DATABASE [premiance_actiview] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\premiance_actiview_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PREALES									
----BACKUP DATABASE [PREALES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PREALES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PREALES'
--RESTORE DATABASE [PREALES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PREALES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PRDHOLDING									
----BACKUP DATABASE [PRDHOLDING] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PRDHOLDING_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PRDHOLDING'
--RESTORE DATABASE [PRDHOLDING] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PRDHOLDING_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PPPTEST4									
----BACKUP DATABASE [PPPTEST4] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST4_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PPPTEST4'
--RESTORE DATABASE [PPPTEST4] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST4_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PPPTEST3									
----BACKUP DATABASE [PPPTEST3] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST3_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PPPTEST3'
--RESTORE DATABASE [PPPTEST3] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST3_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PPPTEST2									
----BACKUP DATABASE [PPPTEST2] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST2_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PPPTEST2'
--RESTORE DATABASE [PPPTEST2] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST2_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PPPTEST									
----BACKUP DATABASE [PPPTEST] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PPPTEST'
--RESTORE DATABASE [PPPTEST] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPPTEST_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PPP									
----BACKUP DATABASE [PPP] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPP_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PPP'
--RESTORE DATABASE [PPP] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPP_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PPMPP									
----BACKUP DATABASE [PPMPP] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPMPP_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PPMPP'
--RESTORE DATABASE [PPMPP] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PPMPP_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PIF									
----BACKUP DATABASE [PIF] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PIF_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PIF'
--RESTORE DATABASE [PIF] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PIF_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PERLE									
----BACKUP DATABASE [PERLE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PERLE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PERLE'
--RESTORE DATABASE [PERLE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PERLE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ParisPropertiesDeveloppement									
----BACKUP DATABASE [ParisPropertiesDeveloppement] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ParisPropertiesDeveloppement_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ParisPropertiesDeveloppement'
--RESTORE DATABASE [ParisPropertiesDeveloppement] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ParisPropertiesDeveloppement_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PALETUVIERS									
----BACKUP DATABASE [PALETUVIERS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PALETUVIERS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PALETUVIERS'
--RESTORE DATABASE [PALETUVIERS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PALETUVIERS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base OPALINE									
----BACKUP DATABASE [OPALINE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\OPALINE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base OPALINE'
--RESTORE DATABASE [OPALINE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\OPALINE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base OLIVIERS									
----BACKUP DATABASE [OLIVIERS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\OLIVIERS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base OLIVIERS'
--RESTORE DATABASE [OLIVIERS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\OLIVIERS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base NOYERS									
----BACKUP DATABASE [NOYERS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\NOYERS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base NOYERS'
--RESTORE DATABASE [NOYERS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\NOYERS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base MODELE_ENTP									
----BACKUP DATABASE [MODELE_ENTP] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MODELE_ENTP_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base MODELE_ENTP'
--RESTORE DATABASE [MODELE_ENTP] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MODELE_ENTP_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base METZ									
----BACKUP DATABASE [METZ] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\METZ_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base METZ'
--RESTORE DATABASE [METZ] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\METZ_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base MERIGNAC									
----BACKUP DATABASE [MERIGNAC] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MERIGNAC_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base MERIGNAC'
--RESTORE DATABASE [MERIGNAC] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MERIGNAC_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base MENELAS									
----BACKUP DATABASE [MENELAS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MENELAS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base MENELAS'
--RESTORE DATABASE [MENELAS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MENELAS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base MCM									
----BACKUP DATABASE [MCM] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MCM_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base MCM'
--RESTORE DATABASE [MCM] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MCM_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base MACON									
----BACKUP DATABASE [MACON] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MACON_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base MACON'
--RESTORE DATABASE [MACON] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MACON_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base LOUISROCHE									
----BACKUP DATABASE [LOUISROCHE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LOUISROCHE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base LOUISROCHE'
--RESTORE DATABASE [LOUISROCHE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LOUISROCHE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base LESCLES									
----BACKUP DATABASE [LESCLES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LESCLES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base LESCLES'
--RESTORE DATABASE [LESCLES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LESCLES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base LEMANET									
----BACKUP DATABASE [LEMANET] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LEMANET_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base LEMANET'
--RESTORE DATABASE [LEMANET] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LEMANET_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base LEBLANCMESNIL									
----BACKUP DATABASE [LEBLANCMESNIL] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LEBLANCMESNIL_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base LEBLANCMESNIL'
--RESTORE DATABASE [LEBLANCMESNIL] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LEBLANCMESNIL_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base LANGFELL									
----BACKUP DATABASE [LANGFELL] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LANGFELL_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base LANGFELL'
--RESTORE DATABASE [LANGFELL] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LANGFELL_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base LAFLECHE									
----BACKUP DATABASE [LAFLECHE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LAFLECHE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base LAFLECHE'
--RESTORE DATABASE [LAFLECHE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\LAFLECHE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base JOUE									
----BACKUP DATABASE [JOUE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\JOUE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base JOUE'
--RESTORE DATABASE [JOUE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\JOUE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base jeremy									
----BACKUP DATABASE [jeremy] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\jeremy_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base jeremy'
--RESTORE DATABASE [jeremy] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\jeremy_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base JEANMONNET									
----BACKUP DATABASE [JEANMONNET] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\JEANMONNET_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base JEANMONNET'
--RESTORE DATABASE [JEANMONNET] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\JEANMONNET_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base JADE									
----BACKUP DATABASE [JADE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\JADE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base JADE'
--RESTORE DATABASE [JADE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\JADE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base interface_test									
----BACKUP DATABASE [interface_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\interface_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base interface_test'
--RESTORE DATABASE [interface_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\interface_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base gagi_test1									
----BACKUP DATABASE [gagi_test1] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_test1_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base gagi_test1'
--RESTORE DATABASE [gagi_test1] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_test1_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base gagi_test									
----BACKUP DATABASE [gagi_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base gagi_test'
--RESTORE DATABASE [gagi_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ILLANGE									
----BACKUP DATABASE [ILLANGE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ILLANGE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ILLANGE'
--RESTORE DATABASE [ILLANGE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ILLANGE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base IDB_TEST									
----BACKUP DATABASE [IDB_TEST] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\IDB_TEST_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base IDB_TEST'
--RESTORE DATABASE [IDB_TEST] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\IDB_TEST_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base IDB									
----BACKUP DATABASE [IDB] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\IDB_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base IDB'
--RESTORE DATABASE [IDB] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\IDB_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base HETRES									
----BACKUP DATABASE [HETRES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\HETRES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base HETRES'
--RESTORE DATABASE [HETRES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\HETRES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base HDL									
----BACKUP DATABASE [HDL] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\HDL_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base HDL'
--RESTORE DATABASE [HDL] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\HDL_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base GRENAT									
----BACKUP DATABASE [GRENAT] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\GRENAT_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base GRENAT'
--RESTORE DATABASE [GRENAT] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\GRENAT_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base FIPAM									
----BACKUP DATABASE [FIPAM] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FIPAM_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base FIPAM'
--RESTORE DATABASE [FIPAM] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FIPAM_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base G2MODUS									
----BACKUP DATABASE [G2MODUS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\G2MODUS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base G2MODUS'
--RESTORE DATABASE [G2MODUS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\G2MODUS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base FROUARD									
----BACKUP DATABASE [FROUARD] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FROUARD_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base FROUARD'
--RESTORE DATABASE [FROUARD] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FROUARD_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base FIP									
----BACKUP DATABASE [FIP] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FIP_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base FIP'
--RESTORE DATABASE [FIP] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FIP_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base FAUGERES									
----BACKUP DATABASE [FAUGERES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FAUGERES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base FAUGERES'
--RESTORE DATABASE [FAUGERES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FAUGERES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base FAGEM									
----BACKUP DATABASE [FAGEM] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FAGEM_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base FAGEM'
--RESTORE DATABASE [FAGEM] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\FAGEM_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base evmailboxstore									
----BACKUP DATABASE [evmailboxstore] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\evmailboxstore_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base evmailboxstore'
--RESTORE DATABASE [evmailboxstore] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\evmailboxstore_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ENOVILLE									
----BACKUP DATABASE [ENOVILLE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ENOVILLE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ENOVILLE'
--RESTORE DATABASE [ENOVILLE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ENOVILLE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwworkflowengine									
----BACKUP DATABASE [dwworkflowengine] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwworkflowengine_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwworkflowengine'
--RESTORE DATABASE [dwworkflowengine] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwworkflowengine_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DataDistribution									
----BACKUP DATABASE [DataDistribution] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DataDistribution_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DataDistribution'
--RESTORE DATABASE [DataDistribution] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DataDistribution_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DEUXPI									
----BACKUP DATABASE [DEUXPI] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DEUXPI_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DEUXPI'
--RESTORE DATABASE [DEUXPI] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DEUXPI_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DEPIMMO									
----BACKUP DATABASE [DEPIMMO] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DEPIMMO_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DEPIMMO'
--RESTORE DATABASE [DEPIMMO] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DEPIMMO_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CORAIL									
----BACKUP DATABASE [CORAIL] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CORAIL_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CORAIL'
--RESTORE DATABASE [CORAIL] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CORAIL_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base clipplus_premiance_actiview_synchro									
----BACKUP DATABASE [clipplus_premiance_actiview_synchro] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_premiance_actiview_synchro_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base clipplus_premiance_actiview_synchro'
--RESTORE DATABASE [clipplus_premiance_actiview_synchro] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_premiance_actiview_synchro_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base clipplus_premiance_actiview									
----BACKUP DATABASE [clipplus_premiance_actiview] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_premiance_actiview_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base clipplus_premiance_actiview'
--RESTORE DATABASE [clipplus_premiance_actiview] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_premiance_actiview_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base clipplus_gagi_test									
----BACKUP DATABASE [clipplus_gagi_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_gagi_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base clipplus_gagi_test'
--RESTORE DATABASE [clipplus_gagi_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_gagi_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CHATELLERAULT									
----BACKUP DATABASE [CHATELLERAULT] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CHATELLERAULT_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CHATELLERAULT'
--RESTORE DATABASE [CHATELLERAULT] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CHATELLERAULT_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CHATEAUBRIANT									
----BACKUP DATABASE [CHATEAUBRIANT] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CHATEAUBRIANT_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CHATEAUBRIANT'
--RESTORE DATABASE [CHATEAUBRIANT] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CHATEAUBRIANT_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CEGID_MODEL									
----BACKUP DATABASE [CEGID_MODEL] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CEGID_MODEL_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CEGID_MODEL'
--RESTORE DATABASE [CEGID_MODEL] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CEGID_MODEL_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CEGID_COMMUN									
----BACKUP DATABASE [CEGID_COMMUN] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CEGID_COMMUN_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CEGID_COMMUN'
--RESTORE DATABASE [CEGID_COMMUN] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CEGID_COMMUN_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base CarreFeydeau									
----BACKUP DATABASE [CarreFeydeau] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CarreFeydeau_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base CarreFeydeau'
--RESTORE DATABASE [CarreFeydeau] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\CarreFeydeau_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base BEAULIEU									
----BACKUP DATABASE [BEAULIEU] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\BEAULIEU_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base BEAULIEU'
--RESTORE DATABASE [BEAULIEU] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\BEAULIEU_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base ANNAPAUL									
----BACKUP DATABASE [ANNAPAUL] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ANNAPAUL_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base ANNAPAUL'
--RESTORE DATABASE [ANNAPAUL] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\ANNAPAUL_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base AMIENS									
----BACKUP DATABASE [AMIENS] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AMIENS_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base AMIENS'
--RESTORE DATABASE [AMIENS] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AMIENS_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base AMETHYSTE									
----BACKUP DATABASE [AMETHYSTE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AMETHYSTE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base AMETHYSTE'
--RESTORE DATABASE [AMETHYSTE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AMETHYSTE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base AMBRE									
----BACKUP DATABASE [AMBRE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AMBRE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base AMBRE'
--RESTORE DATABASE [AMBRE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AMBRE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base AGATE									
----BACKUP DATABASE [AGATE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AGATE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base AGATE'
--RESTORE DATABASE [AGATE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\AGATE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base xenapp65_test									
----BACKUP DATABASE [xenapp65_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\xenapp65_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base xenapp65_test'
--RESTORE DATABASE [xenapp65_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\xenapp65_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base xenapp65_prod									
----BACKUP DATABASE [xenapp65_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\xenapp65_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base xenapp65_prod'
--RESTORE DATABASE [xenapp65_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\xenapp65_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base xenapp65_hom									
----BACKUP DATABASE [xenapp65_hom] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\xenapp65_hom_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base xenapp65_hom'
--RESTORE DATABASE [xenapp65_hom] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\xenapp65_hom_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base RESNEDA									
----BACKUP DATABASE [RESNEDA] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\RESNEDA_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base RESNEDA'
--RESTORE DATABASE [RESNEDA] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\RESNEDA_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PROASSET									
----BACKUP DATABASE [PROASSET] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PROASSET_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PROASSET'
--RESTORE DATABASE [PROASSET] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PROASSET_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base powerfuse2011_rec									
----BACKUP DATABASE [powerfuse2011_rec] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\powerfuse2011_rec_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base powerfuse2011_rec'
--RESTORE DATABASE [powerfuse2011_rec] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\powerfuse2011_rec_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base powerfuse2011_prod									
----BACKUP DATABASE [powerfuse2011_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\powerfuse2011_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base powerfuse2011_prod'
--RESTORE DATABASE [powerfuse2011_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\powerfuse2011_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PowerFuse_Xen_rec									
----BACKUP DATABASE [PowerFuse_Xen_rec] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PowerFuse_Xen_rec_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PowerFuse_Xen_rec'
--RESTORE DATABASE [PowerFuse_Xen_rec] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PowerFuse_Xen_rec_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PowerFuse_rec									
----BACKUP DATABASE [PowerFuse_rec] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PowerFuse_rec_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PowerFuse_rec'
--RESTORE DATABASE [PowerFuse_rec] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PowerFuse_rec_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base PowerFuse_prod									
----BACKUP DATABASE [PowerFuse_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PowerFuse_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base PowerFuse_prod'
--RESTORE DATABASE [PowerFuse_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\PowerFuse_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base MESNEDA									
----BACKUP DATABASE [MESNEDA] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MESNEDA_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base MESNEDA'
--RESTORE DATABASE [MESNEDA] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\MESNEDA_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base interface									
----BACKUP DATABASE [interface] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\interface_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base interface'
--RESTORE DATABASE [interface] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\interface_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base import_virement_test									
----BACKUP DATABASE [import_virement_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_virement_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base import_virement_test'
--RESTORE DATABASE [import_virement_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_virement_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base import_virement_prod									
----BACKUP DATABASE [import_virement_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_virement_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base import_virement_prod'
--RESTORE DATABASE [import_virement_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_virement_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base import_comptable_test_PCE									
----BACKUP DATABASE [import_comptable_test_PCE] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_test_PCE_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base import_comptable_test_PCE'
--RESTORE DATABASE [import_comptable_test_PCE] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_test_PCE_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base import_comptable_test									
----BACKUP DATABASE [import_comptable_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base import_comptable_test'
--RESTORE DATABASE [import_comptable_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base import_comptable_prod									
----BACKUP DATABASE [import_comptable_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base import_comptable_prod'
--RESTORE DATABASE [import_comptable_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\import_comptable_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base GOSALESDW									
----BACKUP DATABASE [GOSALESDW] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\GOSALESDW_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base GOSALESDW'
--RESTORE DATABASE [GOSALESDW] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\GOSALESDW_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base GOSALES									
----BACKUP DATABASE [GOSALES] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\GOSALES_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base GOSALES'
--RESTORE DATABASE [GOSALES] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\GOSALES_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base go_expenses_contributor									
----BACKUP DATABASE [go_expenses_contributor] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\go_expenses_contributor_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base go_expenses_contributor'
--RESTORE DATABASE [go_expenses_contributor] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\go_expenses_contributor_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base gagi_prod_dwh									
----BACKUP DATABASE [gagi_prod_dwh] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_prod_dwh_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base gagi_prod_dwh'
--RESTORE DATABASE [gagi_prod_dwh] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_prod_dwh_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base gagi_prod									
----BACKUP DATABASE [gagi_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base gagi_prod'
--RESTORE DATABASE [gagi_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gagi_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base gafinasset									
----BACKUP DATABASE [gafinasset] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gafinasset_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base gafinasset'
--RESTORE DATABASE [gafinasset] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\gafinasset_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base equilibre_test									
----BACKUP DATABASE [equilibre_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\equilibre_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base equilibre_test'
--RESTORE DATABASE [equilibre_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\equilibre_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base equilibre_prod									
----BACKUP DATABASE [equilibre_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\equilibre_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base equilibre_prod'
--RESTORE DATABASE [equilibre_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\equilibre_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base enterprisevaultmonitoring									
----BACKUP DATABASE [enterprisevaultmonitoring] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\enterprisevaultmonitoring_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base enterprisevaultmonitoring'
--RESTORE DATABASE [enterprisevaultmonitoring] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\enterprisevaultmonitoring_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base EESNEDA									
----BACKUP DATABASE [EESNEDA] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\EESNEDA_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base EESNEDA'
--RESTORE DATABASE [EESNEDA] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\EESNEDA_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwthumbnail									
----BACKUP DATABASE [dwthumbnail] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwthumbnail_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwthumbnail'
--RESTORE DATABASE [dwthumbnail] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwthumbnail_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwsystem									
----BACKUP DATABASE [dwsystem] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwsystem_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwsystem'
--RESTORE DATABASE [dwsystem] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwsystem_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DWREF_TEST									
----BACKUP DATABASE [DWREF_TEST] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWREF_TEST_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DWREF_TEST'
--RESTORE DATABASE [DWREF_TEST] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWREF_TEST_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DWREF									
----BACKUP DATABASE [DWREF] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWREF_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DWREF'
--RESTORE DATABASE [DWREF] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWREF_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DWNotificationBackup									
----BACKUP DATABASE [DWNotificationBackup] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWNotificationBackup_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DWNotificationBackup'
--RESTORE DATABASE [DWNotificationBackup] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DWNotificationBackup_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwnotification									
----BACKUP DATABASE [dwnotification] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwnotification_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwnotification'
--RESTORE DATABASE [dwnotification] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwnotification_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwlogging									
----BACKUP DATABASE [dwlogging] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwlogging_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwlogging'
--RESTORE DATABASE [dwlogging] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwlogging_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwh_proudreed_test									
----BACKUP DATABASE [dwh_proudreed_test] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwh_proudreed_test_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwh_proudreed_test'
--RESTORE DATABASE [dwh_proudreed_test] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwh_proudreed_test_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwh_proudreed									
----BACKUP DATABASE [dwh_proudreed] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwh_proudreed_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwh_proudreed'
--RESTORE DATABASE [dwh_proudreed] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwh_proudreed_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dwdata									
----BACKUP DATABASE [dwdata] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwdata_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dwdata'
--RESTORE DATABASE [dwdata] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dwdata_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dtr_tmp									
----BACKUP DATABASE [dtr_tmp] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dtr_tmp_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dtr_tmp'
--RESTORE DATABASE [dtr_tmp] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dtr_tmp_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dtr									
----BACKUP DATABASE [dtr] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dtr_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dtr'
--RESTORE DATABASE [dtr] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dtr_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base dimo									
----BACKUP DATABASE [dimo] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dimo_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base dimo'
--RESTORE DATABASE [dimo] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\dimo_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base DD_USRDATA									
----BACKUP DATABASE [DD_USRDATA] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DD_USRDATA_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base DD_USRDATA'
--RESTORE DATABASE [DD_USRDATA] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\DD_USRDATA_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base data_store_xen5									
----BACKUP DATABASE [data_store_xen5] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\data_store_xen5_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base data_store_xen5'
--RESTORE DATABASE [data_store_xen5] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\data_store_xen5_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base clipplus_gagi_prod									
----BACKUP DATABASE [clipplus_gagi_prod] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_gagi_prod_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base clipplus_gagi_prod'
--RESTORE DATABASE [clipplus_gagi_prod] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_gagi_prod_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base clipplus_gafinasset									
----BACKUP DATABASE [clipplus_gafinasset] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_gafinasset_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base clipplus_gafinasset'
--RESTORE DATABASE [clipplus_gafinasset] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\clipplus_gafinasset_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base BorrowingReport_Prev_Juin_2012									
----BACKUP DATABASE [BorrowingReport_Prev_Juin_2012] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\BorrowingReport_Prev_Juin_2012_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base BorrowingReport_Prev_Juin_2012'
--RESTORE DATABASE [BorrowingReport_Prev_Juin_2012] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\BorrowingReport_Prev_Juin_2012_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base msdb									
----BACKUP DATABASE [msdb] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\msdb_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base msdb'
--RESTORE DATABASE [msdb] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\msdb_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base model									
----BACKUP DATABASE [model] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\model_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base model'
--RESTORE DATABASE [model] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\model_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
										
---- Base master									
----BACKUP DATABASE [master] TO  DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\master_20220611085051.bak' WITH COMPRESSION,  INIT,  NAME='Sauvegarde full de la base master'
--RESTORE DATABASE [master] FROM DISK='G:\bases\mssql\Backup\Refresh_20220611_0850\master_20220611085051.bak'  WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
		