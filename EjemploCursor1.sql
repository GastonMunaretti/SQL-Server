use [OPERACIONES_TEST]
go

DECLARE @nombreApellido CHAR(40),
@legajo VARCHAR(100),
@poblacion VARCHAR(100)
DECLARE CurClientes CURSOR
FOR
SELECT rtrim(EMP_APELLIDOYNOMBRE) , EMP_LEGAJO
FROM [dbo].[EMPLEADO]
OPEN CurClientes
FETCH CurClientes INTO @nombreApellido, @legajo

WHILE (@@FETCH_STATUS = 0)
BEGIN
	PRINT @nombreApellido +'    '+ @legajo

	FETCH CurClientes INTO @nombreApellido, @legajo
END

CLOSE CurClientes
DEALLOCATE CurClientes 