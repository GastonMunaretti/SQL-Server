(SELECT	        A.CodigoReal,
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
										A.Demorado,
										A.FecUltAct,
										A.UsuUltAct



								FROM  ModeloDenegocio.dbo.MOD_DEMORAS A
								LEFT JOIN  ModeloDenegocio.dbo.MOD_TipoDemora B 
									ON RTRIM(LTRIM(A.CodObservacion)) = B.CodigoTipoDemora

								LEFT JOIN  ModeloDenegocio.dbo.MOD_CategoriaDemora C
								  ON RTRIM(LTRIM(A.CodMotivoDemora)) = C.Codigo

								LEFT JOIN  ModeloDenegocio.dbo.MOD_SubCategoriaDemora D
								  ON RTRIM(LTRIM(A.CodCausaDemora)) = D.Codigo
 
								 WHERE (A.Escala <> 'EZE' OR A.Fecha < '2020-12-1' )



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
		
										RTRIM(LTRIM(J.Codigo))									AS CodMotivoDemora,
										RTRIM(LTRIM(K.Codigo))									AS CodCausaDemora,
										''											AS ObservacionDemora,
										(F.Codigo + '' + J.Descripcion + ' - ' +  K.Descripcion) AS MotivoCausaDemora,
		
										CASE WHEN RTRIM(LTRIM(J.Codigo)) IS NOT NULL AND J.Codigo IN (001,002,003,004,005,006,007,008,009,010,011,012,013,014,015,016,017,018,019) THEN '1'  --OR [Rea_codSubCat1] <> '' THEN '1'
											WHEN RTRIM(LTRIM(K.Codigo)) IS NOT NULL AND K.Codigo IN (100,101,102,103,104,105,106,107,108,109) THEN '1'--OR [Rea_codSubCat2] <> '' THEN '1'
											ELSE '0'
											END AS Demorado,
										A.FecUltAct,
										A.UsuUltAct




								FROM   ModeloDenegocio.dbo.MOD_OperacionVuelosItems A

								JOIN   ModeloDenegocio.dbo.MOD_Certificacion B
									ON A.IdOperacion = B.IdOperacion

								LEFT JOIN  ModeloDenegocio.dbo.MOD_PlanificacionVuelos C
									ON A.IdProgramacionVuelos = C.IdProgramacionVuelos

								LEFT JOIN  ModeloDenegocio.dbo.MOD_Compañias D
									ON C.IdCia = D.IdCompañia

								LEFT JOIN  ModeloDenegocio.dbo.MOD_Aeronaves E
									ON C.IdAeronave = E.IdAeronave

								LEFT JOIN  ModeloDenegocio.dbo.MOD_TipoDemora F
									ON A.IdTipoDemora = F.IdTipoDemora

								LEFT JOIN  ModeloDenegocio.dbo.MOD_TipoServicio G
									ON A.IdTipoServicio = G.IdTipoServicio

								LEFT JOIN  ModeloDenegocio.dbo.MOD_Sedes H
									ON B.IdSede = H.IdSede

								LEFT JOIN  ModeloDenegocio.dbo.MOD_RelacionCategoriaDemora I
									ON A.IdRelacionCategoriaDemora = I.IdRelacionCategoriaDemora

								LEFT JOIN  ModeloDenegocio.dbo.MOD_CategoriaDemora J
									ON I.IdCategoria = J.IdCategoria

								LEFT JOIN  ModeloDenegocio.dbo.MOD_SubCategoriaDemora K
									ON I.IdSubCategoria = K.IdSubCategoria

								LEFT JOIN  ModeloDenegocio.dbo.MOD_TipoMovimiento L
									ON A.IdTipoMovimiento = L.IdTipoMovimiento

								LEFT JOIN ( SELECT	A.IdOperacion AS IdOperacion,
													Convert(TIME,A.TiempoReal) AS  HorarioProgramadoLlegada,
													A.TiempoEstimado AS TiempoEstimado,
													A.TiempoReal AS TiempoReal
											FROM  ModeloDenegocio.dbo.MOD_OperacionVuelosItems A
											LEFT JOIN  ModeloDenegocio.dbo.MOD_TipoMovimiento L
												ON A.IdTipoMovimiento = L.IdTipoMovimiento
											WHERE L.IdTipoMovimiento= 1) M
									ON A.IdOperacion = M.IdOperacion

								LEFT JOIN  ModeloDenegocio.dbo.MOD_Aeropuertos N
									ON B.IdSede = N.IdAeropuerto

								LEFT JOIN  ModeloDenegocio.dbo.MOD_IataAeropuertos O
									ON N.Id_Iata_Codigo = O.IdIataAeropuerto

								LEFT JOIN  ModeloDenegocio.dbo.MOD_OperacionVuelos P
									ON A.IdOperacion = P.IdOperacion

								LEFT JOIN  ModeloDenegocio.dbo.MOD_TipoTramo Q
									ON P.IdTramo = Q.IdTramo


								WHERE L.IdTipoMovimiento= 3 AND Convert(DATE,A.TiempoProgramado) >= '2020-12-1' AND M.HorarioProgramadoLlegada IS NOT NULL) )	

								Order by Demorado








/************************************************************/

SELECT [Rea_IdReal] AS CodigoReal
	  ,[Rea_Fecha] AS Fecha
      ,[Rea_grupoLl] AS GrupoAtencionLLegada
      ,[Rea_sta] AS HorarioProgramadoLlegada	-- horario programado llegada
      ,B.aer_descripcion AS Aeronave			-- codigo aeronave join comercial.aeronave
      ,[Rea_fechaLl] AS FechaLlegada			-- fecha llegada
      ,[Rea_ata] AS HorarioRealLlegada			-- Horario Real llegada
      ,[Rea_eta] AS HorarioEstimadoLlegada		-- Horario estimado de llegada esto se cambia
      ,[Rea_grupoSal] AS GrupoAtencionSalida
      ,[Rea_std] AS HorarioProgramadoSalida		-- horario programado salida
      ,[Rea_fechaSal] AS FechaSalida			-- fecha salida
      ,[Rea_atd] AS HorarioRealSalida			-- Horario real de salida
      ,[Rea_codigoObs] AS CodObservacion
      ,[Rea_detalleObs] AS DetalleObservacion
      ,[Rea_etd] AS HorarioEstimadoSalida		-- horario estimado de salida podria cambiar
      ,[Cli_Codigo] AS CodCliente				-- Codigo de compañia join [dbo].[ICAICLI] on CLI_CODIGO
      ,E.cia_nombre AS NombreCliente			-- Nombre de la compañia 
	  ,[Rea_estado] AS Estado					-- A o C (Autorizado o Cancelado)
      ,[Rea_MotCancelado] AS MotivoCancelado
      ,[Rea_tipoServicio] AS TipoServicio
      ,[Rea_tipoVuelo] AS TipoVuelo				--Cabotaje o Internacional
      ,[Rea_aeropuerto] AS Escala				--SEDE
      ,CASE WHEN C.Descripcion IS NULL THEN ' ' ELSE C.Descripcion END AS MotivoDemora         --join Operaciones.Subcategoria1 - 2
      ,CASE WHEN D.Descripcion IS NULL THEN ' ' ELSE D.Descripcion END AS CausaDemora
	  ,RTRIM(LTRIM([Rea_codSubCat1])) AS CodMotivoDemora		-- codigo de demora subcategoria 1
      ,RTRIM(LTRIM([Rea_codSubCat2])) AS CodCausaDemora		--
      ,[Rea_obsSubCat] AS ObservacionDemora
	  ,[Rea_codigoObs] + ' ' + [Rea_detSubCat1] + ' - ' + [Rea_detSubCat2] AS MotivoCausaDemora
	  ,CASE WHEN RTRIM(LTRIM([Rea_codSubCat1])) IS NOT NULL AND [Rea_codSubCat1] IN (001,002,003,004,005,006,007,008,009,010,011,012,013,014,015,016,017,018,019) THEN '1'  --OR [Rea_codSubCat1] <> '' THEN '1'
			WHEN RTRIM(LTRIM([Rea_codSubCat2])) IS NOT NULL AND [Rea_codSubCat2] IN (100,101,102,103,104,105,106,107,108,109) THEN '1'--OR [Rea_codSubCat2] <> '' THEN '1'
			ELSE '0'
			END AS Demorado
  FROM [OPERACIONES].[Operaciones].[Real] A 
  
  LEFT JOIN [OPERACIONES].[Comercial].[AERONAVE] B
  ON A.Rea_aeronave = B.aer_codigo

  LEFT JOIN [OPERACIONES].[Operaciones].[SubCategoria1] C
  ON RTRIM(LTRIM(A.Rea_codSubCat1)) = C.Codigo
  
  LEFT JOIN [OPERACIONES].[Operaciones].[SubCategoria2] D
  ON RTRIM(LTRIM(A.Rea_codSubCat2)) = D.Codigo

  LEFT JOIN [OPERACIONES].[dbo].[COMPAÑIA] E
  ON A.Cli_Codigo = E.cia_codigo

  Order by Demorado




