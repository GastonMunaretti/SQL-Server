/****** Script for SelectTopNRows command from SSMS  ******/
  SELECT  IdTarea, IdCertificacion,IdOperacionItems, Count(1) As Cantidad
  FROM [ModeloDeNegocio].[dbo].[MOD_CertificacionLiquidacion]
  
  where Activo = 1 AND  IdTarea <> -2 AND Total IS NOT NULL --AND IdTarea NOT IN (72,114,111)

  group by IdTarea, IdCertificacion, IdOperacionItems

  Having  Count(1) > 1

  Order by Cantidad
  
  Select * from [ModeloDeNegocio].[dbo].[MOD_CertificacionLiquidacion] order by 3

  Select * from MOD_CertificacionItems  order by 3, 4
  select * from MOD_Certificacion Where IdCertificacion = 2049


  Select Rank() over (Partition by CodigoCertificacionLiq Order by IdCertificacion, IdTarea) as NumeroOrden,
			* 
  
  
  from [ModeloDeNegocio].[dbo].[MOD_CertificacionLiquidacion] 

  Order by 4