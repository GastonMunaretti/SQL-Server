USE [DW]
GO
/****** Object:  StoredProcedure [dbo].[MAP_D_RESPUESTASOLICITUDCOTIZACION]    Script Date: 30/06/2020 14:32:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MAP_F_SOLICITUDCOMPRA] --90 --procesos

@pDiasDefault INT  = NULL
/*
@pFRECUENCIA_COMMIT :  esta variable es opcional e indica cada tantas operaciones debe hacer un commit, el valor por defaul es 100
@pMAX_ERRORS : esta variable es opcional e indica la maxima cantidad de errores que puede permitir el proceso, si las supera el proceso cancela por Demasiados errores el valor por default depende del proceso
@pNIVEL_AUDITORIA : esta varible en este momento no se esta utilizando y es para definir el nivel de detalle con el que debe  loguear el proceso
*/
AS
BEGIN

	SET ANSI_DEFAULTS ON
	/* 
	Cuando se habilita (ON), esta opción habilita las opciones siguientes de ISO:

	SET ANSI_NULLS
	SET CURSOR_CLOSE_ON_COMMIT

	SET ANSI_NULL_DFLT_ON
	SET IMPLICIT_TRANSACTIONS

	SET ANSI_PADDING
	SET QUOTED_IDENTIFIER

	SET ANSI_WARNINGS


	*/
	
	SET CONCAT_NULL_YIELDS_NULL OFF
	/*
	Cuando SET CONCAT_NULL_YIELDS_NULL es ON, al concatenar un valor NULL con una cadena se produce como resultado NULL. Por ejemplo, SELECT 'abc' + NULL produce NULL. Cuando SET CONCAT_NULL_YIELDS_NULL es OFF, al concatenar un valor NULL con una cadena se obtiene la propia cadena (el valor NULL se trata como una cadena vacía). Por ejemplo, SELECT 'abc' + NULL produce abc.
	*/
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	/*
	Especifica que las instrucciones no pueden leer datos que hayan sido modificados, pero no confirmados, por otras transacciones. Esto evita las lecturas de datos sucios. Otras transacciones pueden cambiar datos entre cada una de las instrucciones de la transacción actual, dando como resultado lecturas no repetibles o datos ficticios. 
	*/
	SET NOCOUNT ON
	 /*
	SET NOCOUNT ON impide el envío al cliente de mensajes DONE_IN_PROC por cada instrucción de un procedimiento almacenado. 
	*/

	SET DATEFORMAT ymd

	DECLARE @cPROC_NAME          varchar(100),
			  @cFILE_NAME          varchar(30),
			  @vTIPO_ACTUALIZACION varchar(20),
			  @v_CantReg           int,
			  @v_CantIns           int,
			  @v_CantUpd           int,
			  @v_CantErrors        int,
			  @vFRECUENCIA_COMMIT  int,
			  @vMAX_ERRORS         int,
			  @vNIVEL_AUDITORIA    varchar(20),
			  @v_sqlcode           int,
			  @v_sqlerrm           varchar(4000),
			  @vRUN_ID             int,
			  @v_shortsqlerrm      varchar(100),
			  @vValues             varchar(4000)

	/* 
	  definicion de varibles generales del stored procedure
	*/

	SET @cFILE_NAME ='SinonimoTablaNueva'
	SET @cPROC_NAME = 'MAP_F_SOLICITUDCOMPRA'
	SET @v_sqlcode = 50000
	SET @v_shortsqlerrm = ''

	SET @v_CantReg = 0
	SET @v_CantIns = 0
	SET @v_CantUpd = 0
	SET @v_CantErrors = 0
	/* 
	  seteo de varibles generales del stored procedure
	*/
	
    -- asginacion de los default en caso de no haber enviado los parametros al stored procedure

    EXECUTE AU_MAP_RT_MAP_START @vRUN_ID OUTPUT, 
                                @cPROC_NAME,
                                @vMAX_ERRORS,
                                @vFRECUENCIA_COMMIT,
                                'Suministros'  

    COMMIT  

	

	
	
	DECLARE @r_DWH_IdArticulo                       int,
			@r_DWH_CodigoArticulo					nvarchar(40),
			@FechaDesde						datetime
			


 BEGIN TRY
		
		IF(@pDiasDefault is not null)
		BEGIN

			SET @FechaDesde = GetDate() - @pDiasDefault
		END
		ELSE
		BEGIN
			SET @FechaDesde = convert(datetime, '2010-01-01',103) 
		END
		
		--DELETE
		

		DECLARE @C TABLE (act TINYINT)
		--MERGE

		MERGE INTO [DW].[dbo].[F_SOLICITUDCOMPRA] AS dest

		USING(SELECT	
					E.idSede, 
					B.IdGerencia, 
					C.IdArea, 
					D.IdDepartamento, 
					B1.FechaCreacionSolicitudCompra,
					A.FechaModoficacionSolicitudCompra, 
					A.IdAlmacences, 
					B2.IdSitio, 
					A.idProveedor,
					B1.FechaDeRequerimiento, 
					A.IdArticulo, 
					A.NumeroDeLinea, 
					A.CantidadPedidaUnidadCompra,
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
					case when A.IdOrdenCompraCabecera <> -2 then 0 else 1 end As 'TieneOC',
					A.LuegarDeEntrega,
					A.IdSolicitudCompraCabecera,
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


			  WHERE	B1.FechaCreacionSolicitudCompra between @FechaDesde And  (GetDate() + 30) OR 
					A.FechaModoficacionSolicitudCompra between @FechaDesde And  (GetDate() + 30) OR
					B1.FechaDeRequerimiento between @FechaDesde And  (GetDate() + 30)
			
			)source 
		
		
		ON source.IdSolicitudCompraCabecera  = dest.CodigoSolicitudCompraCab
		WHEN MATCHED THEN 
			UPDATE
			SET 
				    
					dest.IdSede = source.idSede,
					dest.IdGerencia = source.IdGerencia,
					dest.IdArea = source.IdArea,
					dest.IdDepartamento = source.IdDepartamento,
					dest.IdFechaCreacion = source.FechaCreacionSolicitudCompra,
					dest.IdFechaModificaicon = source.FechaModoficacionSolicitudCompra,
					dest.IdAlmacen = source.IdAlmacences,
					dest.IdSitio = source.IdSitio,
					dest.IdProveedor = source.idProveedor,
					dest.IdFechaRequerimiento = source.FechaDeRequerimiento,
					dest.IdArticulo = source.IdArticulo,
					dest.NroLinea = source.NumeroDeLinea,
					dest.Cantidad = source.CantidadPedidaUnidadCompra,
					dest.Moneda = source.MonedaSolicitudCompra,
					dest.TipoDeCambio = source.TipoDeCambio,
					dest.PrecioUnitarioMonedaLocal = source.PrecioUnitarioMonedaLocal,
					dest.PrecioUnitarioDolar = source.PrecioUnitarioDolar,
					dest.ImporteMonedaLocal = source.ImporteMonedaLocal,
					dest.ImporteDolar = source.ImporteDolar,
					dest.Estado = source.DescripcionEstadoSolicitudDeCompra,
					dest.TipoSolicitudCompra = source.SolicitudCompraTipo,
					dest.DescripcionSolicitudCompraCabecera = source.DescripcionSolicitudCompraCabecera,
					dest.IdFechaEntregaEstimada = source.FechaEntregaEstimada,
					dest.IdUsuarioCreacion = source.IdUsuarioCreacionSolicitudCompraCab,
					dest.IdUsuarioModificacion = source.IdUsuarioModificacionSolicitudCompraCab,
					dest.TieneOC = source.TieneOC,
					dest.LugarDeEntrega = source.LuegarDeEntrega,
					dest.FecUltAct = source.FecUltAct,
					dest.UsuUltAct = source.UsuUltAct
			
		WHEN NOT MATCHED THEN 
			INSERT(	
						IdSede,
						IdGerencia,
						IdArea,
						IdDepartamento,
						IdFechaCreacion,
						IdFechaModificaicon,
						IdAlmacen,
						IdSitio,
						IdProveedor,
						IdFechaRequerimiento,
						IdArticulo,
						NroLinea,
						Cantidad,
						Moneda,
						TipoDeCambio,
						PrecioUnitarioMonedaLocal,
						PrecioUnitarioDolar,
						ImporteMonedaLocal,
						ImporteDolar,
						Estado,
						TipoSolicitudCompra,
						DescripcionSolicitudCompraCabecera,
						IdFechaEntregaEstimada,
						IdUsuarioCreacion,
						IdUsuarioModificacion,
						TieneOC,
						LugarDeEntrega,
						FecUltAct,
						UsuUltAct
					)

			VALUES(	
						source.idSede,
						source.IdGerencia,
						source.IdArea,
						source.IdDepartamento,
						source.FechaCreacionSolicitudCompra,
						source.FechaModoficacionSolicitudCompra,
						source.IdAlmacences,
						source.IdSitio,
						source.idProveedor,
						source.FechaDeRequerimiento,
						source.IdArticulo,
						source.NumeroDeLinea,
						source.CantidadPedidaUnidadCompra,
						source.MonedaSolicitudCompra,
						source.TipoDeCambio,
						source.PrecioUnitarioMonedaLocal,
						source.PrecioUnitarioDolar,
						source.ImporteMonedaLocal,
						source.ImporteDolar,
						source.DescripcionEstadoSolicitudDeCompra,
						source.SolicitudCompraTipo,
						source.DescripcionSolicitudCompraCabecera,
						source.FechaEntregaEstimada,
						source.IdUsuarioCreacionSolicitudCompraCab,
						source.IdUsuarioModificacionSolicitudCompraCab,
						source.TieneOC,
						source.LuegarDeEntrega,
						source.FecUltAct,
						source.UsuUltAct
			
					)
		
		OUTPUT
		
        CASE
		    WHEN $ACTION = N'UPDATE' THEN CONVERT(TINYINT, 1)

            WHEN $ACTION = N'DELETE' THEN CONVERT(TINYINT, 3)

            WHEN $ACTION = N'INSERT' THEN CONVERT(TINYINT, 4)
		END
		INTO @C;


--##########################################
-- Ver los resultados en forma de tabla
		--SELECT    act =

		--	CASE c.act
			   
		--		WHEN 1 THEN 'Update'
					   
		--		WHEN 3 THEN 'Delete'
					   
		--		WHEN 4 THEN 'Insert'
					   
		--	END,

		--cnt = COUNT_BIG(*)

		--FROM @C AS c

		--GROUP BY c.act
--###########################################
			   
		SET @v_CantUpd  = (Select COUNT(c.act) from @C AS c where c.act = 1)
		SET @v_CantIns  = (Select COUNT(c.act) from @C AS c where c.act = 4)
		SET @v_CantReg = @v_CantUpd + @v_CantIns

		EXECUTE AU_MAP_RT_PROC_UPD_STATS @vRUN_ID,
                                           @v_CantReg,
                                           0,
                                           @v_CantIns,
                                           @v_CantUpd,
                                           0,
                                           @v_CantErrors


		 EXECUTE AU_MAP_RT_MAP_END_OK @vRUN_ID		 
		 COMMIT 
--####################################################
  --      print(@v_CantUpd)
		--print(@v_CantIns)
		--print(@v_CantReg)
--####################################################
						
		END TRY
		BEGIN CATCH

			BEGIN TRANSACTION

       
			SET @v_sqlcode = ERROR_NUMBER()
			SET @v_sqlerrm = ERROR_MESSAGE()

			
			/*
				Guarda los valores de ERROR_NUMBER() y ERROR_MESSAGE()
				ERROR_NUMBER(): Devuelve el número de error del error que ha provocado la ejecución del bloque CATCH de una construcción TRY…CATCH.

				ERROR_MESSAGE(): Devuelve el texto del mensaje del error que ha provocado la ejecución del bloque CATCH de una construcción TRY…CATCH.

			*/
        
        
			SET @v_CantErrors = @v_CantErrors + 1;
			-- se incrementa en uno la cantidad de errores

			SET @vValues = 'Codigo' + CAST(@r_DWH_CodigoArticulo as VARCHAR(50))  
			EXECUTE AU_MAP_RT_MAP_ERROR @vRUN_ID, @v_CantReg, @v_sqlcode, @v_sqlerrm, @vValues
			EXECUTE MAP_ERROR @vRUN_ID , @v_CantReg,0,
                      @v_CantIns,@v_CantUpd,0,
                      @v_CantErrors,@v_shortsqlerrm,@v_sqlerrm
			
			COMMIT 
			
			
       -- loguea el error en la tabla au_errors
      END CATCH  	  	   	
END		