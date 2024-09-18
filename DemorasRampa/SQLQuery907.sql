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

  LEFT JOIN MOD_CategoriaDemora C
  ON A.Rea_codSubCat1 = C.Codigo
  
  LEFT JOIN MOD_SubCategoriaDemora D
  ON A.Rea_codSubCat2 = D.Codigo

  LEFT JOIN [OPERACIONES].[dbo].[COMPAÑIA] E
  ON A.Cli_Codigo = E.cia_codigo



  order by CodObservacion


  select * from [OPERACIONES].[Operaciones].[Real]





  SELECT * FROM [ModeloDeNegocio].[dbo].[MOD_DEMORAS]


  
  
  -- query

SELECT	A.IdDEMORAS,
		A.CodigoReal,
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
		A.CodObservacion + ' ' + C.Descripcion + ' - ' + D.Descripcion AS MotivoCausaDemora,
		A.Demorado,
		A.FecUltAct,
		A.UsuUltAct



FROM MOD_DEMORAS A
LEFT JOIN MOD_TipoDemora B 
	ON A.CodObservacion = B.CodigoTipoDemora

LEFT JOIN MOD_CategoriaDemora C
  ON A.CodMotivoDemora = C.Codigo

LEFT JOIN MOD_SubCategoriaDemora D
  ON A.CodCausaDemora = D.Codigo








