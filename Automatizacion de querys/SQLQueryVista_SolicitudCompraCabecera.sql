Exec sp_columns LOGISTICSPOSTALADDRESSVIEW

Exec sp_columns SolicitudCompraCabecera


USE [ITCAXDEV]
GO

create view SolicitudCompraCabecera
AS
select T.PURCHREQID as 'CodigoSolicitudCompraCabecera',
	T.PARTITION as 'CodigoParticion',
	T.RECID as 'CodigoRecid',
	T.REQUISITIONSTATUS as 'IdEstadoSolicitudDeCompra_LOOKUP',
	T.CREATEDBY as 'IdUsuarioCreacion_LOOKUP',
	T.MODIFIEDBY as 'IdUsuarioModificacion_LOOKUP',
	T.BUSINESSJUSTIFICATION as 'IdSolicitudCompraMotivo_LOOKUP',
	T.PURCHREQNAME as 'DescripcionSolicitudCompraCabecera',
	T.TRANSDATE as 'FechaEntregaEstimada',
	T.CREATEDDATETIME as 'FechaCreacionSolicitudCabecera',
	T.REQUIREDDATE as 'FechaDeRequerimiento',
	T.MODIFIEDDATETIME as 'FechaModificacionCabecera'
from PURCHREQTABLE T

select * from SolicitudCompraCabecera