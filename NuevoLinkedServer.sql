EXEC sp_addlinkedserver @server='ARAXTSTSQL',

                        @srvproduct='',
						@provider='SQLNCLI',
						@datasrc='SQLB',--the data source
						@provstr='Integrated Security=SSPI' ;


--EXEC sp_addlinkedserver @server='ARAXTSTSQL', @srvproduct='', @provider='SQLNCLI', @datasrc='np:ARAXTSTSQL', @provstr='Integrated Security=SSPI'


EXEC sp_testlinkedserver N'ARAXTSTSQL'



SELECT *
FROM OPENROWSET(
      'Microsoft.Jet.OLEDB.4.0', 
      'Data Source=hydrogen;User ID=scratch;Password=scratch;',
      'select * from users')
