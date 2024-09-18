SELECT
						T.RECID											AS  'CodigoSolicitudCompraCabecera',
						T.PARTITION										AS  'Particion',
						T.PURCHREQID									AS  'IdSolicitudCompraAX',
						T.SUBMITTEDDATETIME								AS  'FechaEmision',
						T.REQUISITIONSTATUS								AS	'IdEstadoSolicitudCompra', --Tabla MOD_EstadoSolicitudCompra
						T.CREATEDDATETIME								AS  'FechaCreacionSolicitudCompra',
						PURCHREQBUSINESSJUSTIFICATIONCODES.DESCRIPTION	AS	'SolicitudCompraTipo',
						T.REQUIREDDATE									AS	'FechaDeRequerimiento',
						T.PURCHREQNAME									AS	'DescripcionSolicitudCompraCabecera',
						T.TRANSDATE										AS	'FechaEntregaEstimada',
						T.CREATEDDATETIME								AS	'FechaCreacionSolicitudCompraCab',
						T.CREATEDBY										AS	'IdUsuarioCreacionSolicitudCompraCab',
						T.MODIFIEDDATETIME								AS  'FechaModificacionSolicitudCompraCab',
						T.MODIFIEDBY									AS	'IdUsuarioModificacionSolicitudCompraCab',
						upper(Z.NAME)									AS  'Comprador'
					
FROM PURCHREQTABLE T WITH(NOLOCK)

LEFT JOIN PURCHREQBUSINESSJUSTIFICATIONCODES WITH(NOLOCK)
	ON PURCHREQBUSINESSJUSTIFICATIONCODES.RECID = T.BUSINESSJUSTIFICATION

LEFT JOIN (Select 	B.NAME,
					C.PURCHREQID

			from [dbo].[HCMWORKER] A
			
			join [dbo].[DIRPARTYTABLE] B
				ON A.PERSON = B.RECID
			join [dbo].[PURCHREQTABLE] C
				ON A.RECID = C.ITCPURCHREQUESTER

			) Z
	ON T.PURCHREQID = Z.PURCHREQID
