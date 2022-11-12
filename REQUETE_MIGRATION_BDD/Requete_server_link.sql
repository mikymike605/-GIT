USE [master]
GO

--/****** Object:  LinkedServer [DATADISTRIBUTION]    Script Date: 11/06/2022 10:22:32 ******/
--EXEC master.dbo.sp_addlinkedserver @server = N'DATADISTRIBUTION', @srvproduct=N'SQL Server'
-- /* For security reasons the linked server remote logins password is changed with ######## */
--EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'DATADISTRIBUTION',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'collation compatible', @optvalue=N'false'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'data access', @optvalue=N'false'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'dist', @optvalue=N'false'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'pub', @optvalue=N'false'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'rpc', @optvalue=N'true'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'rpc out', @optvalue=N'true'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'sub', @optvalue=N'true'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'connect timeout', @optvalue=N'0'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'collation name', @optvalue=null
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'lazy schema validation', @optvalue=N'false'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'query timeout', @optvalue=N'0'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'use remote collation', @optvalue=N'true'
--GO

--EXEC master.dbo.sp_serveroption @server=N'DATADISTRIBUTION', @optname=N'remote proc transaction promotion', @optvalue=N'false'
--GO

/****** Object:  LinkedServer [GESPROJET]    Script Date: 11/06/2022 10:22:32 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GESPROJET', @srvproduct=N'', @provider=N'MSDASQL', @datasrc=N'GESPROJET'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GESPROJET',@useself=N'False',@locallogin=NULL,@rmtuser=N'admin',@rmtpassword='ProudAdmin'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'connect timeout', @optvalue=N'120'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'collation name', @optvalue=N'French_100_CI_AS'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'query timeout', @optvalue=N'120'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [GESPROJET(_distant_)]    Script Date: 11/06/2022 10:22:32 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GESPROJET(_distant_)', @srvproduct=N'GESPROJET-4D', @provider=N'MSDASQL', @datasrc=N'GESPROJET'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GESPROJET(_distant_)',@useself=N'False',@locallogin=NULL,@rmtuser=N'admin',@rmtpassword='ProudAdmin'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(_distant_)', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [GESPROJET(51.91.152.8)]    Script Date: 11/06/2022 10:22:32 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'GESPROJET(51.91.152.8)', @srvproduct=N'GESPROJET-4D', @provider=N'MSDASQL', @datasrc=N'GESPROJET'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'GESPROJET(51.91.152.8)',@useself=N'False',@locallogin=NULL,@rmtuser=N'admin',@rmtpassword='ProudAdmin'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'GESPROJET(51.91.152.8)', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO

/****** Object:  LinkedServer [repl_distributor]    Script Date: 11/06/2022 10:22:32 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'repl_distributor', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'repl_distributor',@useself=N'False',@locallogin=NULL,@rmtuser=N'distributor_admin',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'data access', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'dist', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'repl_distributor', @optname=N'remote proc transaction promotion', @optvalue=N'false'
GO


