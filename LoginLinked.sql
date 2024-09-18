select * from sys.servers  -- Consulta de servidores



EXEC sp_helplinkedsrvlogin;  -- se muestran todas las asignaciones de inicio de sesi�n para todos los servidores vinculados definidos en la m�quina local
GO							 -- Muy util para ver el Login

EXEC sp_helplinkedsrvlogin
   @rmtsrvname = N'ARAXTSTSQL',
   @locallogin = N'local login'



EXEC sp_helplinkedsrvlogin
   @rmtsrvname = N'ARAXTSTSQL'; --Ver todas las asignaciones de login


EXEC sp_helplinkedsrvlogin
   @rmtsrvname = NULL,
   @locallogin = N'Ben';  --mostrar todas las asignaciones de inicio de sesi�n para un inicio de sesi�n local





 
EXEC sp_linkedservers --este procedimiento devuelve una lista de servidores vinculados definidos en el servidor local


EXEC sp_dropserver 'ARAXTSTSQL' -- eliminar LinkedServer