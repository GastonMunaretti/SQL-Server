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
	  ,[Rea_detSubCat1] + ' - ' + [Rea_detSubCat2] AS MotivoCausaDemora
	  ,CASE WHEN RTRIM(LTRIM([Rea_codSubCat1])) IS NOT NULL AND [Rea_codSubCat1] IN (001,002,003,004,005,006,007,008,009,010,011,012,013,014,015,016) THEN '1'  --OR [Rea_codSubCat1] <> '' THEN '1'
			WHEN RTRIM(LTRIM([Rea_codSubCat2])) IS NOT NULL AND [Rea_codSubCat2] IN (100,101,102,103,104,105,106,107) THEN '1'--OR [Rea_codSubCat2] <> '' THEN '1'
			ELSE '0'
			END AS Demorado
  FROM [OPERACIONES].[Operaciones].[Real] A 
  
  LEFT JOIN [OPERACIONES].[Comercial].[AERONAVE] B
  ON A.Rea_aeronave = B.aer_codigo

  LEFT JOIN [OPERACIONES].[Operaciones].[SubCategoria1] C
  ON RTRIM(LTRIM(A.Rea_codSubCat1)) = C.Codigo
  
  LEFT JOIN [OPERACIONES].[Operaciones].[SubCategoria2] D
  ON RTRIM(LTRIM(A.Rea_codSubCat2)) = D.Codigo

  Where A.Rea_aeropuerto = 'EZE' And A.Rea_fechaLl between '2020-01-01' And '2020-01-31' And  A.Rea_ata IS NOT NULL


