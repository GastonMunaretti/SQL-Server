select 	A.Categ_Desde,
		A.Categ_Hasta,
		A.Fecha_Cambio,
		A.Observaciones,
		B.EMP_APELLIDOYNOMBRE

from operaciones.rrhh.EMPLEADOS_CATEG A
join dbo.empleado B
	on A.legajo = b.EMP_LEGAJO
where A.Categ_Desde IN ('C','D') and YEAR(A.Fecha_Cambio) IN (2021,2022)
order by A.fecha_cambio desc