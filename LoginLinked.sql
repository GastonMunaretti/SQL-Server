select * from sys.servers  -- Consulta de servidores



EXEC sp_helplinkedsrvlogin;  -- se muestran todas las asignaciones de inicio de sesión para todos los servidores vinculados definidos en la máquina local
GO							 -- Muy util para ver el Login

EXEC sp_helplinkedsrvlogin
   @rmtsrvname = N'ARAXTSTSQL',
   @locallogin = N'local login'



EXEC sp_helplinkedsrvlogin
   @rmtsrvname = N'ARAXTSTSQL'; --Ver todas las asignaciones de login


EXEC sp_helplinkedsrvlogin
   @rmtsrvname = NULL,
   @locallogin = N'Ben';  --mostrar todas las asignaciones de inicio de sesión para un inicio de sesión local





 
EXEC sp_linkedservers --este procedimiento devuelve una lista de servidores vinculados definidos en el servidor local


EXEC sp_dropserver 'ARAXTSTSQL' -- eliminar LinkedServer