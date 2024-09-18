/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [IdOperacionItems]
      ,[CodigoOperacionItems]
      ,[IdOperacion]
      ,[IdProgramacionVuelos]
      ,[IdTipoMovimiento]
      ,[TiempoProgramado]
      ,[TiempoEstimado]
      ,[TiempoReal]
      ,[TiempoRealTams]
      ,[IdPosicion]
      ,[MovimientoCarga]
      ,[InformaCarga]
      ,[KgCarga]
      ,[AperturaBodega]
      ,[CierreBodega]
      ,[HoraInicio]
      ,[HoraLiberado]
      ,[IdRelacionCategoriaDemora]
      ,[PrimerEquipaje]
      ,[UltimoEquipaje]
      ,[UbicLat]
      ,[UbicLong]
      ,[IdTipoServicio]
      ,[TiempoInicioDespacho]
      ,[TiempoAvisoDemoraCancelacion]
      ,[IdEstadoOperacionItems]
      ,[HoraInicioProgramada]
      ,[HoraLiberadoProgramada]
      ,[TiempoInicioDespachoCarga]
      ,[IdTipoDemora]
      ,[Programado]
      ,[FecUltAct]
      ,[UsuUltAct]
  FROM [ModeloDeNegocio].[dbo].[MOD_OperacionVuelosItems]

  select * from [dbo].[MOD_CertificacionItems]



  /**************************************************************/

  select A.*,
		 B.*,
		 C.*
  
  
  from [dbo].[MOD_CertificacionItems] A
  LEFT JOIN [dbo].[MOD_OperacionVuelosItems] B
		ON A.IdOperacionItems = B.IdOperacionItems
  LEFT JOIN [dbo].[MOD_CertificacionItemDatos] C
		ON A.IdCertificacionItem = C.IdCertificacionItem
  LEFT JOIN [dbo].[MOD_Certificacion] D 
	ON A.IdCertificacion = D.IdCertificacion

/********************************************************************/

select A.*
  
from [dbo].[MOD_CertificacionItems] A

--------------------------------------

select C.IdCertificacionItem ,Count(*)
  
  
from  [dbo].[MOD_CertificacionItemDatos] C 

Where C.Cantidad > 0 AND C.Id_Reversa IS NULL

Group by C.IdCertificacionItem

Having Count(*) > 1

-----------------------------------
select  C.*,
		Rank() over (Partition by C.IdCertificacionItem Order by C.desde) as ranks
  
  
from  [dbo].[MOD_CertificacionItemDatos] C 

Where C.Cantidad > 0 AND C.Id_Reversa IS NULL

Order By C.IdCertificacionItem


/*****************************************************/



  select A.*,
		 B.*
		
  
  
  from [dbo].[MOD_CertificacionItems] A
  LEFT JOIN [dbo].[MOD_OperacionVuelosItems] B
		ON A.IdOperacionItems = B.IdOperacionItems





/*****************************************************/

Select * from MOD_OperacionVuelosItems


Select * from MOD_CertificacionItems 


Select * from MOD_Certificacion
Select * from MOD_OperacionVuelos
Select * from MOD_OperacionVuelosItems

Select * from MOD_CertificacionItemDatos





