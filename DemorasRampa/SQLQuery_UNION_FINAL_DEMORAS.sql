
(SELECT	A.CodigoReal,
		A.Fecha,
		A.GrupoAtencionLLegada,
		A.HorarioProgramadoLlegada,
		A.Aeronave,
		A.FechaLlegada,
		A.HorarioRealLlegada,
		A.HorarioEstimadoLlegada,
		A.GrupoAtencionSalida,
		A.HorarioProgramadoSalida,
		A.FechaSalida,
		A.HorarioRealSalida,
		A.CodObservacion,
		B.Descripcion AS DetalleObservacion,
		A.HorarioEstimadoSalida,
		A.CodCliente,
		A.NombreCliente,
		A.Estado,
		A.MotivoCancelado,
		A.TipoServicio,
		A.TipoVuelo,
		A.Escala,
		C.Descripcion AS MotivoDemora,
		D.Descripcion AS CausaDemora,
		A.CodMotivoDemora,
		A.CodCausaDemora,
		A.ObservacionDemora,
		A.CodObservacion + ' ' + C.Descripcion + ' - ' + D.Descripcion AS MotivoCausaDemora,
		A.Demorado



FROM MOD_DEMORAS A
LEFT JOIN MOD_TipoDemora B 
	ON A.CodObservacion = B.CodigoTipoDemora

LEFT JOIN MOD_CategoriaDemora C
  ON A.CodMotivoDemora = C.Codigo

LEFT JOIN MOD_SubCategoriaDemora D
  ON A.CodCausaDemora = D.Codigo
 
 WHERE A.Escala <> 'EZE' OR A.Fecha < '2020-12-1' )



UNION



(SELECT	A.CodigoOperacionItems + 6000000			AS CodigoReal,
		Convert(DATE,A.TiempoProgramado)			AS Fecha,
		'Grupo'										AS GrupoAtencionLlegada,
		Convert(TIME,M.HorarioProgramadoLlegada)	AS HorarioProgramadoLlegada,
		E.Denominacion								AS Aeronave,
		Convert(DATE,M.TiempoReal)					AS FechaLlegada,
		Convert(TIME,M.TiempoReal)					AS HorarioRealLlegada,
		Convert(TIME,M.TiempoEstimado)				AS HorarioEstimadoLlegada,
		'Grupo'										AS GrupoAtencionSalida,
		Convert(TIME,A.TiempoProgramado)			AS HorarioProgramadoSalida,
		Convert(DATE,A.TiempoReal)					AS FechaSalida,
		Convert(TIME,A.TiempoReal)					AS HorarioRealSalida,
		F.Codigo									AS CodObservacion,
		F.Descripcion								AS DetalleObservacion,
		Convert(TIME,A.TiempoEstimado)				AS HorarioEstimadoSalida, 
		D.Codigo									AS CodCliente,
		D.Denominacion								AS NombreCliente,
		'A'											AS Estado, --ver
		''											AS MotivoCancelado,
		G.Codigo									AS TipoServicio,
		UPPER(Q.Nombre)								AS TipoVuelo,
		O.CodigoAeropuerto							AS Escala,
		
		CASE WHEN J.Descripcion IS NULL THEN ' ' ELSE J.Descripcion END AS MotivoDemora,         
        CASE WHEN K.Descripcion IS NULL THEN ' ' ELSE K.Descripcion END AS CausaDemora,
		
		J.Codigo									AS CodMotivoDemora,
		K.Codigo									AS CodCausaDemora,
		''											AS ObservacionDemora,
		CASE WHEN (F.Codigo + '' + J.Descripcion + ' - ' +  K.Descripcion) IS NULL THEN ' - ' ELSE (F.Codigo + '' + J.Descripcion + ' - ' +  K.Descripcion) END AS MotivoCausaDemora,
		
		CASE WHEN RTRIM(LTRIM(J.Codigo)) IS NOT NULL AND J.Codigo IN (001,002,003,004,005,006,007,008,009,010,011,012,013,014,015,016,017,018,019) THEN '1'  --OR [Rea_codSubCat1] <> '' THEN '1'
			WHEN RTRIM(LTRIM(K.Codigo)) IS NOT NULL AND K.Codigo IN (100,101,102,103,104,105,106,107,108,109) THEN '1'--OR [Rea_codSubCat2] <> '' THEN '1'
			ELSE '0'
			END AS Demorado




FROM  MOD_OperacionVuelosItems A

JOIN  MOD_Certificacion B
	ON A.IdOperacion = B.IdOperacion

LEFT JOIN MOD_PlanificacionVuelos C
	ON A.IdProgramacionVuelos = C.IdProgramacionVuelos

LEFT JOIN MOD_Compañias D
	ON C.IdCia = D.IdCompañia

LEFT JOIN MOD_Aeronaves E
	ON C.IdAeronave = E.IdAeronave

LEFT JOIN MOD_TipoDemora F
	ON A.IdTipoDemora = F.IdTipoDemora

LEFT JOIN MOD_TipoServicio G
	ON A.IdTipoServicio = G.IdTipoServicio

LEFT JOIN MOD_Sedes H
	ON B.IdSede = H.IdSede

LEFT JOIN MOD_RelacionCategoriaDemora I
	ON A.IdRelacionCategoriaDemora = I.IdRelacionCategoriaDemora

LEFT JOIN MOD_CategoriaDemora J
	ON I.IdCategoria = J.IdCategoria

LEFT JOIN MOD_SubCategoriaDemora K
	ON I.IdSubCategoria = K.IdSubCategoria

LEFT JOIN MOD_TipoMovimiento L
	ON A.IdTipoMovimiento = L.IdTipoMovimiento

LEFT JOIN ( SELECT	A.IdOperacion AS IdOperacion,
					Convert(TIME,A.TiempoReal) AS  HorarioProgramadoLlegada,
					A.TiempoEstimado AS TiempoEstimado,
					A.TiempoReal AS TiempoReal
			FROM MOD_OperacionVuelosItems A
			LEFT JOIN MOD_TipoMovimiento L
				ON A.IdTipoMovimiento = L.IdTipoMovimiento
			WHERE L.IdTipoMovimiento= 1) M
	ON A.IdOperacion = M.IdOperacion

LEFT JOIN MOD_Aeropuertos N
	ON B.IdSede = N.IdAeropuerto

LEFT JOIN MOD_IataAeropuertos O
	ON N.Id_Iata_Codigo = O.IdIataAeropuerto

LEFT JOIN MOD_OperacionVuelos P
	ON A.IdOperacion = P.IdOperacion

LEFT JOIN MOD_TipoTramo Q
	ON P.IdTramo = Q.IdTramo


WHERE L.IdTipoMovimiento= 3 AND Convert(DATE,A.TiempoProgramado) >=  '2020-12-1')