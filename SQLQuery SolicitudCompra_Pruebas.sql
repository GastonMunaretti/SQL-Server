
--select distinct codigomonedalocal from d_tiposdecambio
--select MonedaOrdenesCompra, count(1) from ModeloDeNegocio.dbo.MOD_OrdenesCompraDetalle group by MonedaOrdenesCompra
	
--Select * from Modelodenegocio.dbo.MOD_SolicitudCompraCabecera

--Select * from Modelodenegocio.dbo.MOD_SolicitudCompraDetalle





SELECT	
		E.idSede, 
		B.IdGerencia, 
		C.IdArea, 
		D.IdDepartamento, 
		B1.FechaCreacionSolicitudCompra,
		A.FechaModoficacionSolicitudCompra, 
		A.IdAlmacences, 
		B2.IdSitio, 
		A.idProveedor,
		B1.FechaDeRequerimiento, A.IdArticulo, A.NumeroDeLinea, A.CantidadPedidaUnidadCompra,
		A.MonedaSolicitudCompra, 
		case when left(A.MonedaSolicitudCompra,1) = 'U' then 1 else dbo.GET_COTIZACION(B1.FechaCreacionSolicitudCompra,'ARS') end AS 'TipoDeCambio',

		case when left(A.MonedaSolicitudCompra,1) = 'U' then A.PrecioUnitario * dbo.GET_COTIZACION(B1.FechaCreacionSolicitudCompra,'ARS') 
		else A.PrecioUnitario end As 'PrecioUnitarioMonedaLocal',
		
		case when left(A.MonedaSolicitudCompra,1) = 'U' then A.PrecioUnitario
		Else dbo.GET_COTIZACION(B1.FechaCreacionSolicitudCompra,'ARS') * A.PrecioUnitario end As 'PrecioUnitarioDolar',
		
		case when left(A.MonedaSolicitudCompra,1) = 'U' then A.PrecioCompra  * dbo.GET_COTIZACION(B1.FechaCreacionSolicitudCompra,'ARS') 
		else A.PrecioCompra end As 'ImporteMonedaLocal',

		case when left(A.MonedaSolicitudCompra,1) = 'U' then A.PrecioCompra   
		else A.PrecioCompra  / dbo.GET_COTIZACION(B1.FechaCreacionSolicitudCompra,'ARS') end As 'ImporteDolar',

		F.DescripcionEstadoSolicitudDeCompra,
		B1.SolicitudCompraTipo,
		B1.DescripcionSolicitudCompraCabecera,
		B1.FechaEntregaEstimada,
		B1.IdUsuarioCreacionSolicitudCompraCab,
		B1.IdUsuarioModificacionSolicitudCompraCab,
		case when A.IdOrdenCompraCabecera <> -2 then 0 else 1 end,
		A.LuegarDeEntrega,
		B1.FecUltAct,
		B1.UsuUltAct


FROM	ModeloDenegocio.Dbo.MOD_SolicitudCompraDetalle AS A
		LEFT JOIN ModeloDenegocio.Dbo.MOD_SolicitudCompraCabecera AS B1 ON
			A.IdSolicitudCompraCabecera = B1.IdSolicitudCompraCabecera
		LEFT JOIN ModeloDeNegocio.Dbo.MOD_CasoSolicitudCotizacionCabecera B2 On
			A.IdCasoSolicitudCotizacionCabecera = B2.IdCasoSolicitudCotizacionCabecera
			
		LEFT JOIN ModeloDenegocio.Dbo.MOD_HistoricoUsuarioGerencias B On
				B1.IdUsuarioCreacionSolicitudCompraCab = B.IdUsuario And
				B1.FechaCreacionSolicitudCompraCab Between B.FechaInicio And IsNull(B.FechaFin,'2100-01-01')			
		LEFT Join ModeloDeNegocio.dbo.MOD_HistoricoUsuarioAreas C On
				B1.IdUsuarioCreacionSolicitudCompraCab = C.IdUsuario And
				B1.FechaCreacionSolicitudCompraCab Between C.FechaInicio And IsNull(C.FechaFin,'2100-01-01')			
		LEFT Join ModeloDeNegocio.dbo.MOD_HistoricoUsuarioDepartamentos D On
				B1.IdUsuarioCreacionSolicitudCompraCab = D.IdUsuario And
				B1.FechaCreacionSolicitudCompraCab Between D.FechaInicio And IsNull(D.FechaFin,'2100-01-01')			
		LEFT Join ModeloDeNegocio.dbo.MOD_HistoricoUsuarioSedes E On
				B1.IdUsuarioCreacionSolicitudCompraCab = E.IdUsuario And
				B1.FechaCreacionSolicitudCompraCab Between E.FechaInicio And IsNull(E.FechaFin,'2100-01-01')			
		LEFT Join 	ModeloDeNegocio.dbo.MOD_EstadoSolicitudCompra F On 
				B1.IdEstadoSolicitudCompra = F.IdEstadoSolicitudDeCompra



--select * 

--FROM	ModeloDenegocio.Dbo.MOD_SolicitudCompraDetalle AS A
--		JOIN ModeloDenegocio.Dbo.MOD_SolicitudCompraCabecera AS B1 ON
--			A.IdSolicitudCompraCabecera = B1.IdSolicitudCompraCabecera


--		LEFT JOIN ModeloDeNegocio.Dbo.MOD_CasoSolicitudCotizacionCabecera B2 On
--			A.IdCasoSolicitudCotizacionCabecera = B2.IdCasoSolicitudCotizacionCabecera
			