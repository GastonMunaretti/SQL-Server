select  C.IdCertificacionItemsDatos,
		C.CodigoCertificacionItemsDatos,
		A.IdCertificacionItem,
		A.IdCertificacion,
		D.IdEstadoCertificacion,
		D.IdCia,
		D.IdAeropuerto,
		D.IdTipoCbte,
		D.NroCertificacion,
		D.Id_Firmante,
		D.TipoLiq,
		E.IdAeronave,
		E.IdMatricula,
		E.NroVuelo,
		E.FechaLlegada,
		E.HoraProgramadaLlegada,
		E.IdIataAeropuertoLlegada,
		E.FechaSalida,
		E.HoraProgramadaSalida,
		E.IdIataAeropuertoSalida,
		E.IdTipoVuelo,
		E.IdEstadoVuelo,
		E.CodigoPlanificacionVuelos,
		E.IdVueloSalida,
		A.IdOperacionItems,
		B.IdOperacion,
		B.IdEstadoOperacionItems,
		A.IdTarea,
		C.Cantidad,
		C.Id_Reversa,
		A.TieneObservacion,
		Case 
			When C.Id_Reversa IS NOT NULL THEN 1 
			ELSE 0
		END AS Cancelado,
		Case 
			When C.Cantidad < 0  THEN 1 
			ELSE 0
		END AS Ajustado,
		C.NumeroOrden,
		C.Desde,
		C.Hasta,
		C.Momento,
		B.IdTipoServicio,
		B.IdProgramacionVuelos,
		B.IdTipoMovimiento,
		D.Fecha AS FechaCertificacion,
		B.TiempoProgramado,
		B.TiempoReal,
		Convert(varchar(5),B.TiempoReal,105) AS HoraReal,
		Convert(varchar,B.TiempoReal,23) AS FechaReal,
		B.TiempoInicioDespacho,
		B.TiempoInicioDespachoCarga,
		B.IdPosicion,
		B.MovimientoCarga,
		B.InformaCarga,
		B.KgCarga,
		B.AperturaBodega,
		B.CierreBodega,
		B.HoraInicio,
		B.HoraLiberado,
		B.IdRelacionCategoriaDemora,
		B.PrimerEquipaje,
		B.UltimoEquipaje,
		B.UbicLat,
		B.UbicLong,
		B.IdTipoDemora,
		B.Programado,
		CASE
			WHEN B.IdTipoMovimiento = 1 THEN ISNULL(DATEDIFF(minute,B.HoraInicio,B.AperturaBodega),0)
			ELSE 0
		END AS AperturaBodega_Calzado_min,
		
		CASE
			WHEN B.IdTipoMovimiento = 1 AND A.IdTarea= 69  THEN ISNULL(DATEDIFF(minute,B.HoraInicio,C.Desde),0)
			ELSE 0
		END AS CintaInicio_Calzado_min,
		
		CASE
			WHEN B.IdTipoMovimiento = 1 AND A.IdTarea= 69  THEN ISNULL(DATEDIFF(minute,B.HoraInicio,C.Hasta),0)
			ELSE 0
		END AS CintaFin_Calzado_min,

		CASE
			WHEN B.IdTipoMovimiento = 1 AND A.IdTarea= 89  THEN ISNULL(DATEDIFF(minute,B.HoraInicio,C.Desde),0)
			ELSE 0
		END AS PasarelaTelescopica_Calzado_min,

		CASE
			WHEN A.IdTarea= 89  THEN 1
			ELSE 0
		END AS PasarelaTelescopica_b,

		CASE
			WHEN B.IdTipoMovimiento = 1 AND A.IdTarea= 114  THEN ISNULL(DATEDIFF(minute,B.HoraInicio,C.Desde),0)
			ELSE 0
		END AS Escalera_Calzado_min,

		CASE
			WHEN A.IdTarea= 94  THEN 1
			ELSE 0
		END AS Bus_b,

		CASE
			WHEN  A.IdTarea IN(111,86,72)  THEN ISNULL(DATEDIFF(minute,C.Desde,C.Hasta),0)
			ELSE 0
		END AS GPU_min,
		
		CASE
			WHEN  A.IdTarea= 74  THEN ISNULL(DATEDIFF(minute,C.Desde,C.Hasta),0)
			ELSE 0
		END AS AireAcondicionado_min,

		CASE
			WHEN A.IdTarea IN(96,106,108,110,112,113,119,120,123,131)  THEN 1
			ELSE 0
		END AS HuboLimpieza_b,

		CASE
			WHEN F.IdFirmante > 0  THEN 1
			ELSE 0
		END AS TieneFirma_b,
		
		F.IdFirmante,
		G.Usuario AS UsuarioPortal,

		CASE
			WHEN G.Usuario NOT IN(NULL,'Implementación','TiempoAgotado')  THEN 1
			ELSE 0
		END AS FirmaPortal_b,

		ISNULL(C.Ajuste,0) AS CertificacionesConAjuste,
		I.Id_CertificacionLiq,
		I.IdCertificacionLiqObs,
		I.Observacion,
		D.FecUltAct,
		D.UsuUltAct



  
  from [ModeloDeNegocio].[dbo].[MOD_CertificacionItems] A
  LEFT JOIN  [ModeloDeNegocio].[dbo].[MOD_OperacionVuelosItems] B
		ON A.IdOperacionItems = B.IdOperacionItems
  LEFT JOIN  [ModeloDeNegocio].[dbo].[MOD_CertificacionItemDatos] C
		ON A.IdCertificacionItem = C.IdCertificacionItem
  LEFT JOIN  [ModeloDeNegocio].[dbo].[MOD_Certificacion] D 
	ON A.IdCertificacion = D.IdCertificacion
  LEFT JOIN  [ModeloDeNegocio].[dbo].[MOD_PlanificacionVuelos] E
	ON B.IdProgramacionVuelos = E.IdProgramacionVuelos
  LEFT JOIN  [ModeloDeNegocio].[dbo].[MOD_CertificacionImagenes] F
	ON B.IdOperacionItems = F.IdOperacionItems
  LEFT JOIN (	select *
	        	from  [ModeloDeNegocio].[dbo].[MOD_CertificacionAprobPortal]
				Where Usuario <> 'SinUsuario' AND IdCertificacion <> -1) G
	ON D.IdCertificacion = G.IdCertificacion
LEFT JOIN (SELECT * FROM  [ModeloDeNegocio].[dbo].[MOD_CertificacionLiquidacion] WHERE Activo = 1 AND Total IS NOT NULL AND IdTarea NOT IN (72,114,111)) H
	ON A.IdCertificacion = H.IdCertificacion AND A.IdTarea = H.IdTarea  AND A.IdOperacionItems = H.IdOperacionItems
LEFT JOIN  [ModeloDeNegocio].[dbo].[MOD_CertificacionLiquidacionObs] I
	ON H.IdCertificacionLiq = I.Id_CertificacionLiq


	