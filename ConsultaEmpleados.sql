SELECT        EMP_LEGAJO, EMP_APELLIDOYNOMBRE, EMP_GRUPO, EMP_GERENCIA, EMP_DEPARTAMENTO, EMP_SECTOR, EMP_NOMBRE, EMP_USUARIO, EMP_APELLIDO, EMP_ESTADO
FROM            EMPLEADO
WHERE        (EMP_ESTADO = '0') AND (EMP_GERENCIA = 'Gcia Operaciones y Escalas')