Select * from [araxtstsql].[ITCAXTEST].[dbo].[ACCOUNTANT_BR]



SELECT net_transport, auth_scheme FROM sys.dm_exec_connections WHERE session_id= @@spid 