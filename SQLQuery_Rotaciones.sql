/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  B.Rotacion,
		count(distinct A.IdUsuario)*100.00   / 1611
		
		--(select count(distinct IdUsuario) from [DW].[dbo].[F_GESTIONDELTIEMPO] where Periodo = 202002 and IdRotacion > 0)
		
		

FROM [DW].[dbo].[F_GESTIONDELTIEMPO]  A
Join [dbo].[D_ROTACION] B
On A.IdRotacion = B.IdRotacion

where A.Periodo = 202002 and A.IdRotacion > 0 

group by B.Rotacion


/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  B.Rotacion,
		A.Periodo,
		count(distinct A.IdUsuario)

FROM [DW].[dbo].[F_GESTIONDELTIEMPO]  A
Join [dbo].[D_ROTACION] B
	On A.IdRotacion = B.IdRotacion
where A.IdRotacion > 0

group by B.Rotacion,A.Periodo

Order by A.Periodo desc





/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  B.Rotacion,
		count(distinct A.IdUsuario)
		
		

FROM [DW].[dbo].[F_GESTIONDELTIEMPO]  A
Join [dbo].[D_ROTACION] B
On A.IdRotacion = B.IdRotacion
where A.Periodo = 202002 and A.IdRotacion > 0 

group by B.Rotacion








--**************************************************
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT  A.Periodo,
		count(distinct A.IdUsuario)

FROM [DW].[dbo].[F_GESTIONDELTIEMPO]  A
Join [DW].[dbo].[D_ROTACION] B
	On A.IdRotacion = B.IdRotacion
where A.IdRotacion > 0

group by A.Periodo


/***********************************************************************************/


SELECT  *

FROM [DW].[dbo].[F_GESTIONDELTIEMPO]  A
Join [DW].[dbo].[D_ROTACION] B
	On A.IdRotacion = B.IdRotacion

where   A.IdRotacion > 0 
		AND A.Periodo = 202001
		AND A.Ausentismo NOT IN(930,144,410,997,994) 
		AND A.HorasProgramadas > 0 
		--AND A.IdSede=9
Order by 4



SELECT	A.NA_ESCALA, 
		A.NA_LEGAJO, 
		B.EMP_APELLIDOYNOMBRE, 
		A.NA_FECHA, 
		A.NA_PERIODO,
        A.NA_PROGRAMADAS , 
		A.NA_TRABAJADAS, 
		A.NA_AUSENTISMO, 
		C.LIC_DESCRIPCION
        
FROM	Operaciones.RrHh.NOV_ASISTENCIA A 
		INNER JOIN Operaciones.dbo.EMPLEADO B
			ON A.NA_LEGAJO = B.EMP_LEGAJO
        
		LEFT OUTER JOIN Operaciones.RrHh.LICENCIAS C
			ON A.NA_AUSENTISMO = C.LIC_CODIGO

WHERE A.NA_PERIODO = 202001











/********************************************************************************/
SELECT *

FROM	[DW].[dbo].[F_GESTIONDELTIEMPO]  A
		JOIN [DW].[dbo].[D_ROTACION] B
			On A.IdRotacion = B.IdRotacion
		LEFT JOIN [DW].[dbo].[D_LICENCIAS] C
			On A.IdLicencia = C.IdLicencia
		LEFT JOIN [DW].[dbo].[D_USUARIOS] D
			On A.IdUsuario = D.idUsuario

where   A.IdRotacion > 0 
		AND A.Periodo = 202102
		AND A.Ausentismo NOT IN(930,144,410,997,994) 
		AND A.HorasProgramadas > 0 
		--AND C.Licencia = 'ENFERMEDAD'
		--AND A.IdSede=9
		--AND A.LiquidadoCuando IS NOT NULL
Order by 4

------

SELECT	A.NA_ESCALA, 
		A.NA_LEGAJO, 
		B.EMP_APELLIDOYNOMBRE, 
		A.NA_FECHA, 
		A.NA_PERIODO,
        A.NA_PROGRAMADAS , 
		A.NA_TRABAJADAS, 
		A.NA_AUSENTISMO, 
		C.LIC_DESCRIPCION
        
FROM	Operaciones.RrHh.NOV_ASISTENCIA A 
		INNER JOIN Operaciones.dbo.EMPLEADO B
			ON A.NA_LEGAJO = B.EMP_LEGAJO
        
		LEFT OUTER JOIN Operaciones.RrHh.LICENCIAS C
			ON A.NA_AUSENTISMO = C.LIC_CODIGO

WHERE   A.NA_PERIODO = 202102
		AND A.NA_AUSENTISMO NOT IN(930,144,410,997,994) 
		AND A.NA_PROGRAMADAS > 0
		--AND C.LIC_DESCRIPCION = 'ENFERMEDAD'



/*************************************************************************************/
SELECT  D.Legajo,
		C.Licencia,
		Count(*) AS N

FROM	[DW].[dbo].[F_GESTIONDELTIEMPO]  A
		JOIN [DW].[dbo].[D_ROTACION] B
			On A.IdRotacion = B.IdRotacion
		LEFT JOIN [DW].[dbo].[D_LICENCIAS] C
			On A.IdLicencia = C.IdLicencia
		LEFT JOIN [DW].[dbo].[D_USUARIOS] D
			On A.IdUsuario = D.idUsuario



where   --A.IdRotacion > 0 
		A.Periodo = 201912
		AND A.Ausentismo NOT IN(930,144,410,997,994) 
		AND A.HorasProgramadas > 0
		AND C.Licencia = 'ENFERMEDAD'
		
		--AND A.IdSede=9

GROUP BY D.Legajo, C.Licencia

ORDER BY 3



SELECT	A.NA_LEGAJO,
		C.LIC_DESCRIPCION,
		Count(*) AS N
	
        
FROM	Operaciones.RrHh.NOV_ASISTENCIA A 
		INNER JOIN Operaciones.dbo.EMPLEADO B
			ON A.NA_LEGAJO = B.EMP_LEGAJO
        
		LEFT OUTER JOIN Operaciones.RrHh.LICENCIAS C
			ON A.NA_AUSENTISMO = C.LIC_CODIGO

WHERE   A.NA_PERIODO = 201912
		AND A.NA_AUSENTISMO NOT IN(930,144,410,997,994) 
		AND A.NA_PROGRAMADAS > 0
		AND C.LIC_DESCRIPCION = 'ENFERMEDAD'

GROUP BY A.NA_LEGAJO, C.LIC_DESCRIPCION

ORDER BY 3


/****************************   Join arriesgado  ***************************************/

SELECT *
FROM

(SELECT  D.Legajo,
		C.Licencia,
		Count(*) AS N

FROM	[DW].[dbo].[F_GESTIONDELTIEMPO]  A
		JOIN [DW].[dbo].[D_ROTACION] B
			On A.IdRotacion = B.IdRotacion
		LEFT JOIN [DW].[dbo].[D_LICENCIAS] C
			On A.IdLicencia = C.IdLicencia
		LEFT JOIN [DW].[dbo].[D_USUARIOS] D
			On A.IdUsuario = D.idUsuario



where   --A.IdRotacion > 0 
		A.Periodo = 201912
		AND A.Ausentismo NOT IN(930,144,410,997,994) 
		AND A.HorasProgramadas > 0
		AND C.Licencia = 'ENFERMEDAD'
		AND A.LiquidadoCuando IS NOT NULL
		
		--AND A.IdSede=9

GROUP BY D.Legajo, C.Licencia

) L

join

(SELECT	A.NA_LEGAJO,
		C.LIC_DESCRIPCION,
		Count(*) AS N
	
        
FROM	Operaciones.RrHh.NOV_ASISTENCIA A 
		INNER JOIN Operaciones.dbo.EMPLEADO B
			ON A.NA_LEGAJO = B.EMP_LEGAJO
        
		LEFT OUTER JOIN Operaciones.RrHh.LICENCIAS C
			ON A.NA_AUSENTISMO = C.LIC_CODIGO

WHERE   A.NA_PERIODO = 201912
		AND A.NA_AUSENTISMO NOT IN(930,144,410,997,994) 
		AND A.NA_PROGRAMADAS > 0
		AND C.LIC_DESCRIPCION = 'ENFERMEDAD'

GROUP BY A.NA_LEGAJO, C.LIC_DESCRIPCION

) M

On L.Legajo=M.NA_LEGAJO AND L.N <> M.N





/***********************************************************************/
SELECT  D.Legajo,
		C.Licencia,
		*
		--Count(*) AS N

FROM	[DW].[dbo].[F_GESTIONDELTIEMPO]  A
		JOIN [DW].[dbo].[D_ROTACION] B
			On A.IdRotacion = B.IdRotacion
		LEFT JOIN [DW].[dbo].[D_LICENCIAS] C
			On A.IdLicencia = C.IdLicencia
		LEFT JOIN [DW].[dbo].[D_USUARIOS] D
			On A.IdUsuario = D.idUsuario



where   --A.IdRotacion > 0 
		A.Periodo = 201912
		AND A.Ausentismo NOT IN(930,144,410,997,994) 
		AND A.HorasProgramadas > 0
		AND C.Licencia = 'ENFERMEDAD'
		AND D.Legajo = '26984'
		
		--AND A.IdSede=9

--GROUP BY D.Legajo, C.Licencia

ORDER BY 3



SELECT	A.NA_LEGAJO,
		C.LIC_DESCRIPCION,
		*
		--Count(*) AS N
	
        
FROM	Operaciones.RrHh.NOV_ASISTENCIA A 
		INNER JOIN Operaciones.dbo.EMPLEADO B
			ON A.NA_LEGAJO = B.EMP_LEGAJO
        
		LEFT OUTER JOIN Operaciones.RrHh.LICENCIAS C
			ON A.NA_AUSENTISMO = C.LIC_CODIGO

WHERE   A.NA_PERIODO = 201912
		AND A.NA_AUSENTISMO NOT IN(930,144,410,997,994) 
		AND A.NA_PROGRAMADAS > 0
		AND C.LIC_DESCRIPCION = 'ENFERMEDAD'
		AND A.NA_LEGAJO = '26984'

--GROUP BY A.NA_LEGAJO, C.LIC_DESCRIPCION

ORDER BY 3




set dateformat ymd
/********************************************************/
select A.*,C.HorasTeoricas, C.*	
from ModeloDeNegocio.dbo.MOD_Programacion A
join ModeloDeNegocio.dbo.MOD_Usuarios B
 on A.IdUsuario=B.idUsuario
join ModeloDeNegocio.dbo.MOD_BandaHoraria C On
A.IdBandaHoraria = C.IdBandaHoraria

where B.Legajo = '26984' AND idfecha between '2019-11-21' and '2019-12-20'
--YEAR(A.IdFecha) = 2019 AND MONTH(A.IdFecha) = 12 and 
and EsLaboral = 1
order by idfecha

select *
from ModeloDeNegocio.dbo.MOD_GestionDelTiempo A
join ModeloDeNegocio.dbo.MOD_Usuarios B
 on A.IdUsuario=B.idUsuario

where B.Legajo = '26984' AND idfecha between '2019-11-21' and '2019-12-20'
order by idfecha

SELECT	A.*
		--C.LIC_DESCRIPCION,
		--*
		--Count(*) AS N
	        
FROM	Operaciones.RrHh.NOV_ASISTENCIA A 
		INNER JOIN Operaciones.dbo.EMPLEADO B
			ON A.NA_LEGAJO = B.EMP_LEGAJO
        
	--	LEFT OUTER JOIN Operaciones.RrHh.LICENCIAS C
	--		ON A.NA_AUSENTISMO = C.LIC_CODIGO

WHERE   A.NA_FECHA between '2019-11-21' and '2019-12-20'
		--AND A.NA_AUSENTISMO NOT IN(930,144,410,997,994) 
		--AND A.NA_PROGRAMADAS > 0
		--AND C.LIC_DESCRIPCION = 'ENFERMEDAD'
		AND A.NA_LEGAJO = '26984'


SELECT  A.*
		--C.Licencia,		
		--Count(*) AS N

FROM	[DW].[dbo].[F_GESTIONDELTIEMPO]  A
		--JOIN [DW].[dbo].[D_ROTACION] B
		--	On A.IdRotacion = B.IdRotacion
		--LEFT JOIN [DW].[dbo].[D_LICENCIAS] C
			--On A.IdLicencia = C.IdLicencia
		LEFT JOIN [DW].[dbo].[D_USUARIOS] D
			On A.IdUsuario = D.idUsuario



where   --A.IdRotacion > 0 
		A.IdFecha between '2019-11-21' and '2019-12-20'
		--AND A.Ausentismo NOT IN(930,144,410,997,994) 
		--AND A.HorasProgramadas > 0
		--AND C.Licencia = 'ENFERMEDAD'
		AND D.Legajo = '26984'
		
		--AND A.IdSede=9

--GROUP BY D.Legajo, C.Licencia

ORDER BY 3

select * from ModeloDeNegocio.dbo.MOD_BandaHoraria where IdBandaHoraria = 371484
select * from TURNOS where codigo = 503









/************/


SELECT  *

FROM [DW].[dbo].[F_GESTIONDELTIEMPO]  A


where    A.Periodo = 202103
