/*******************************************************************************************************/


SELECT  EMPLEADO.EMP_ID, EMPLEADO.EMP_LEGAJO, 
		EMPLEADO.EMP_APELLIDOYNOMBRE, 
		EMPLEADO.EMP_MAIL, EMPLEADO.EMP_GERENCIA, 
		EMPLEADO.EMP_DEPARTAMENTO, 
		EMPLEADO.EMP_SECTOR,
		EMPLEADO.Id_Funcion, 
		RrHh.Funciones.Descripcion, 
		RrHh.Habilitaciones.IdHabilitacion, 
		RrHh.Habilitaciones.Descripcion AS Expr1, 
		RrHh.Habilitaciones.IdTipoHabilitacion, 
		RrHh.Habilitaciones.ValidaProgramacion,
		RrHh.Habilitaciones.DiasAviso,
		RrHh.HabilitacionesVencimiento.FechaVto,
		RrHh.HabilitacionesVencimiento.FechaVtoProg

FROM EMPLEADO 
INNER JOIN RrHh.Funciones 
	ON EMPLEADO.Id_Funcion = RrHh.Funciones.Id_Funcion 
INNER JOIN RrHh.HabilitacionesFuncion 
	ON RrHh.Funciones.Id_Funcion = RrHh.HabilitacionesFuncion.IdFuncion 
INNER JOIN RrHh.Habilitaciones 
	ON RrHh.HabilitacionesFuncion.IdHabilitacion = RrHh.Habilitaciones.IdHabilitacion 
INNER JOIN RrHh.HabilitacionesVencimiento 
ON RrHh.Habilitaciones.IdHabilitacion = RrHh.HabilitacionesVencimiento.IdHabilitacion AND EMPLEADO.EMP_ID = RrHh.HabilitacionesVencimiento.IdEmpleado

WHERE (EMPLEADO.EMP_APELLIDOYNOMBRE LIKE '%%') AND (EMPLEADO.EMP_LEGAJO = '25918') AND IdGrupoAero = 1

order by IdHabilitacion desc





/*******************************************************************************************/
/***************** PRREGUNTAR POR HISTORICOS   *********************************************/




SELECT IdLog, TipoTrn, Tabla, PK, Campo, ValorOriginal, ValorNuevo, FechaTrn, Usuario
FROM Auditoria.logTransacciones 
--WHERE (campo like '%PSA%')

WHERE Campo IN( 'EMP_VTOINMAE','EMP_FECLICCOND','EMP_FPSAE')

order by PK



SELECT	IdLog, 
		TipoTrn, 
		Tabla, 
		PK, 
		Campo, 
		ValorOriginal, 
		ValorNuevo, 
		FechaTrn, 
		Usuario

FROM Auditoria.logTransacciones 
--WHERE (campo like '%PSA%')

WHERE Campo IN( 'EMP_VTOINMAE')

order by PK






SELECT	IdLog, 
		TipoTrn, 
		Tabla, 
		PK,
		right(substring(PK,1,len(PK)-1),len(PK)-charindex('=',PK)-1) AS IdEmpleado,
		Campo, 
		'5' AS IdHabilitacion,
		ValorOriginal, 
		ValorNuevo, 
		FechaTrn, 
		Usuario

FROM Auditoria.logTransacciones 


WHERE Campo IN( 'EMP_FECLICCOND')

order by PK


/**********************************************************************************/

SELECT IdLog,
TipoTrn,
Tabla,
PK,
right(left(PK,(patindex('%>%',PK)-1)),(len(left(PK,(patindex('%>%',PK)-1))))-8) as Id_Usuario,
Campo,
ValorOriginal,
ValorNuevo,
FechaTrn,
Usuario

FROM Auditoria.logTransacciones
--WHERE (campo like '%PSA%')

WHERE Campo IN( 'EMP_VTOINMAE')




/*************************************************************************/


SELECT IdLog,
TipoTrn,
Tabla,
PK,
right(left(PK,(patindex('%>%',PK)-1)),(len(left(PK,(patindex('%>%',PK)-1))))-8) as Id_Usuario,
Campo,
ValorOriginal,
ValorNuevo,
FechaTrn,
Usuario

FROM Auditoria.logTransacciones
--WHERE (campo like '%PSA%')

WHERE Campo IN( 'EMP_VTOINMAE')







/**********************************************************************************************/
--Tablas importantes

select * from Operaciones.dbo.[Aeropuerto]                              select * from [ModeloDeNegocio].dbo.[MOD_Sedes]

select * from RrHh.HabilitacionesFuncion                                select * from ModeloDeNegocio.dbo.MOD_HabilitacionesFuncion

select * from RrHh.HabilitacionesGruposAero                             select * from ModeloDeNegocio.dbo.MOD_HabilitacionesGruposAero

select * from RrHh.HabilitacionesItemGrupoAero                          select * from ModeloDeNegocio.dbo.MOD_HabilitacionesItemGrupoAero   --
 
select * from RrHh.Habilitaciones										select * from ModeloDeNegocio.dbo.MOD_Habilitaciones  

select * from RrHh.HabilitacionesVencimiento							select * from ModeloDeNegocio.dbo.MOD_HabilitacionesVencimiento

select * from [RrHh].[TipoHabilitacion]									select * from ModeloDeNegocio.dbo.MOD_TipoHabilitacion

select * from [RrHh].[Funciones]										select * from [ModeloDeNegocio].dbo.[MOD_Puestos]

select * from [dbo].[CURSOEMPLEADO]										select * from [ModeloDeNegocio].dbo.[MOD_EmpleadoCursos]
										
																		select * from ModeloDeNegocio.dbo.MOD_Usuarios




/*========================================================================================*/
/* Cursos faltantes                                                                       */
/*========================================================================================*/





select * from [ModeloDeNegocio].dbo.[MOD_EmpleadoCursos]
















 



/***********************************************************************************************/
SELECT	A.EMP_ID,
		B.Id_Funcion
		--C.IdFuncion,
		--D.IdHabilitacion,
		--E.IdHabilitacion

FROM EMPLEADO A

JOIN RrHh.Funciones B
	ON A.Id_Funcion = B.Id_Funcion 

JOIN RrHh.HabilitacionesFuncion C 
	ON B.Id_Funcion = C.IdFuncion 

JOIN RrHh.Habilitaciones D
	ON C.IdHabilitacion = D.IdHabilitacion 


JOIN RrHh.HabilitacionesVencimiento E
	ON D.IdHabilitacion = E.IdHabilitacion AND A.EMP_ID = E.IdEmpleado

WHERE (A.EMP_APELLIDOYNOMBRE LIKE '%gandolfo%') AND (A.EMP_LEGAJO = '25918') 

order by D.IdHabilitacion desc




/*********************** Prueba 1 **********************************************/


/**********************************************************************************************/
SELECT	A.EMP_ID,
		B.Id_Funcion
		--C.IdFuncion,
		--D.IdHabilitacion,
		--E.IdHabilitacion

FROM EMPLEADO A

JOIN RrHh.Funciones B
	ON A.Id_Funcion = B.Id_Funcion 



WHERE (A.EMP_APELLIDOYNOMBRE LIKE '%gandolfo%') AND (A.EMP_LEGAJO = '25918') 



/**********************************  Prueba 2  ***********************************************/

/**********************************************************************************************/
SELECT	A.EMP_ID,
		B.Id_Funcion,
		C.IdFuncion,
		C.IdHabilitacion,
		C.IdGrupoAero
		--D.IdHabilitacion,
		--E.IdHabilitacion

FROM EMPLEADO A

JOIN RrHh.Funciones B
	ON A.Id_Funcion = B.Id_Funcion 

JOIN RrHh.HabilitacionesFuncion C 
	ON B.Id_Funcion = C.IdFuncion 



WHERE (A.EMP_APELLIDOYNOMBRE LIKE '%gandolfo%') AND (A.EMP_LEGAJO = '25918')





/*******************************************************************************************************/
/*******************************************************************************************************/
/*******************************************************************************************************/
/*******************************************************************************************************/


SELECT  
		EMPLEADO.EMP_ID, EMPLEADO.EMP_LEGAJO, 
		EMPLEADO.EMP_APELLIDOYNOMBRE, 
		EMPLEADO.EMP_MAIL, EMPLEADO.EMP_GERENCIA, 
		EMPLEADO.EMP_DEPARTAMENTO, 
		EMPLEADO.EMP_SECTOR,
		EMPLEADO.Id_Funcion, 
		RrHh.Funciones.Descripcion, 
		RrHh.Habilitaciones.IdHabilitacion, 
		RrHh.Habilitaciones.Descripcion AS Expr1, 
		RrHh.Habilitaciones.IdTipoHabilitacion, 
		RrHh.Habilitaciones.ValidaProgramacion,
		RrHh.Habilitaciones.DiasAviso, 
		RrHh.HabilitacionesVencimiento.FechaVtoProg

FROM EMPLEADO 
INNER JOIN RrHh.Funciones 
	ON EMPLEADO.Id_Funcion = RrHh.Funciones.Id_Funcion 
INNER JOIN RrHh.HabilitacionesFuncion  
	ON RrHh.Funciones.Id_Funcion = RrHh.HabilitacionesFuncion.IdFuncion 
INNER JOIN RrHh.Habilitaciones 
	ON RrHh.HabilitacionesFuncion.IdHabilitacion = RrHh.Habilitaciones.IdHabilitacion 
INNER JOIN RrHh.HabilitacionesVencimiento 
ON RrHh.Habilitaciones.IdHabilitacion = RrHh.HabilitacionesVencimiento.IdHabilitacion AND EMPLEADO.EMP_ID = RrHh.HabilitacionesVencimiento.IdEmpleado

WHERE (EMPLEADO.EMP_APELLIDOYNOMBRE LIKE '%%') AND (EMPLEADO.EMP_LEGAJO = '25916') AND IdGrupoAero = 1

order by IdHabilitacion desc


select * from EMPLEADO

select * from ModeloDeNegocio.dbo.MOD_usuarios




/*======================================================================================*/

select * from ModeloDeNegocio.dbo.MOD_HabilitacionesFuncion   WHERE IdHabilitacion = 20 order by 4,5



select * from ModeloDeNegocio.dbo.MOD_Habilitaciones  

select * from ModeloDeNegocio.dbo.MOD_Cursos





select * from ModeloDeNegocio.dbo.MOD_EmpleadoCursos A
left join ModeloDeNegocio.dbo.MOD_Usuarios C
	On A.LegajoEmpleado = C.Legajo


where A.IdCurso = 53 and A.FechaVencimiento >= GETDATE() AND C.Activo = 1 




select  A.LegajoEmpleado,
		A.IdCurso

from ModeloDeNegocio.dbo.MOD_EmpleadoCursos A
left join ModeloDeNegocio.dbo.MOD_Usuarios C
	On A.LegajoEmpleado = C.Legajo


where A.IdCurso = 53 and A.FechaVencimiento >= GETDATE() AND C.Activo = 1 



select *
from ModeloDeNegocio.dbo.MOD_EmpleadoCursos A
left join ModeloDeNegocio.dbo.MOD_Usuarios C
	On A.LegajoEmpleado = C.Legajo


WHERE A.IdEmpleadoCursos IN (       select L.IdEmpleadoCursos 
								    from               (	select 	L1.IdEmpleadoCursos,
																	L1.LegajoEmpleado,
																	L2.IdHabilitacion,
																	L1.FechaVencimiento,
																	RANK() OVER (PARTITION BY L1.LegajoEmpleado,L2.IdHabilitacion  ORDER BY L1.LegajoEmpleado,L2.IdHabilitacion,L1.FechaVencimiento desc) AS xRank
							              					from ModeloDeNegocio.dbo.MOD_EmpleadoCursos L1
															LEFT JOIN ModeloDeNegocio.dbo.MOD_Cursos L2
																On L1.IdCurso = L2.IdCurso) L
									where L.xRank =1)
							
AND A.IdCurso=6 and A.FechaVencimiento >= GETDATE() and C.Activo = 1







select * from OPERACIONES.dbo.CURSOEMPLEADO B
left join OPERACIONES.dbo.EMPLEADO L
On B.CEM_LEGAJO = L.EMP_LEGAJO

where B.CEM_IDCURSO IN(  select K.CEM_IDCURSO
						 from	  	(select  B.CEM_IDCURSO,
												B.CEM_LEGAJO,
												B.CEM_CODIGO,
												B.CEM_FECHAVTO,
												RANK() OVER (PARTITION BY B.CEM_LEGAJO,B.CEM_CODIGO  ORDER BY B.CEM_LEGAJO,B.CEM_CODIGO,B.CEM_FECHAVTO desc) AS xRank


										from OPERACIONES.dbo.CURSOEMPLEADO B
										left join OPERACIONES.dbo.EMPLEADO L
										On B.CEM_LEGAJO = L.EMP_LEGAJO) K
						where K.xRank =1

)

AND B.CEM_CODIGO = 6 AND B.CEM_FECHAVTO >= GETDATE() and L.EMP_ESTADO = '0'








select * from ModeloDeNegocio.dbo.MOD_Cursos







select  B.CEM_IDCURSO,
		B.CEM_LEGAJO,
		B.CEM_CODIGO,
		B.CEM_FECHAVTO,
		RANK() OVER (PARTITION BY B.CEM_LEGAJO,B.CEM_CODIGO  ORDER BY B.CEM_LEGAJO,B.CEM_CODIGO,B.CEM_FECHAVTO desc) AS xRank


from OPERACIONES.dbo.CURSOEMPLEADO B
left join OPERACIONES.dbo.EMPLEADO L
On B.CEM_LEGAJO = L.EMP_LEGAJO

where B.CEM_CODIGO = 55 AND B.CEM_FECHAVTO  >= GETDATE() AND L.EMP_ESTADO = '0' 




/*----------------------------------------    consulta por tabla vencimiento   -----------------------------------------------------*/

select 
		A.IdEmpleado,
		A.IdHabilitacion,
		A.FechaVto

from [RrHh].[HabilitacionesVencimiento] A

where A.IdHabilitacion = 6 and A.FechaVto >= GETDATE()


group by  A.IdEmpleado,
		A.IdHabilitacion,
		A.FechaVto


order by  A.IdEmpleado,
		A.IdHabilitacion,
		A.FechaVto


/************************************************/
select *
from				(select 
							A.IdEmpleado,
							A.IdHabilitacion,
							A.FechaVto,
							RANK() OVER (PARTITION BY A.IdEmpleado,A.IdHabilitacion ORDER BY  A.IdEmpleado,A.IdHabilitacion,A.FechaVto desc) AS xRank
					
					from [RrHh].[HabilitacionesVencimiento] A) L
where L.xRank =1




/*************************************/

select *
		

from [RrHh].[HabilitacionesVencimiento] A 


select * from ModeloDeNegocio.dbo.MOD_HabilitacionesVencimiento












select * from [RrHh].[Habilitaciones]










select		B.IdUsuario									AS IdUsuario, 
			B.Legajo									AS LegajoEmpleado,
			B.ApellidoyNombre,
			A.IdHabilitacion							AS IdHabilitacion,
			C.Descripcion								AS Descripcion,
			B.Activo									AS UsuarioActivo,
			B.IdPuestoActual							AS IdPuestoActual,
			B.IdGerenciaActual							AS IdGerenciaActual,
			B.IdAreaActual								AS IdAreaActual,
			B.IdSectorActual							AS IdSectorActual,
			B.idSedeActual								AS IdSede,
			A.FechaVencimiento							AS FechaVencimiento,
			D.NombrePuesto,
			E.Sede
				
from ModeloDeNegocio.dbo.MOD_HabilitacionesVencimiento A

left join ModeloDeNegocio.dbo.MOD_Usuarios B
	On A.IdUsuario = B.idUsuario

left join ModeloDeNegocio.dbo.MOD_Habilitaciones C
	On A.IdHabilitacion = C.IdHabilitacion

left join  ModeloDeNegocio.dbo.MOD_Puestos D
	On b.idPuestoActual = D.idPuesto

left join ModeloDeNegocio.dbo.MOD_Sedes E
	On B.idSedeActual = E.Idsede
						
			
WHERE		A.FechaVencimiento < getdate()  /*HABILTACION VENCIDA*/  
		and A.IdHabilitacion = 29			/*FACTORES HUMANOS*/          
		and B.idPuestoActual = 7			/*TRACTORISTA*/  
		and B.idSedeActual = 9				/*EZEIZA*/