/****** Script for SelectTopNRows command from SSMS  ******/
select distinct(A.[Código de artículo]),
				A.[Fecha física],
				A.Cantidad,
				A.[Precio Calculado],
				A.[Albarán],
				A.[Fecha financiera],
				A.[Factura],
				A.[Importe de coste físico],
				A.[Importe de coste financiero],
				A.[Ajuste]

	from(

		SELECT [Código de artículo]
			  ,[Fecha física]
			  ,[Cantidad]
			  ,[Precio Calculado]
			  ,[Albarán]
			  ,[Fecha financiera]
			  ,[Factura]
			  ,[Importe de coste físico]
			  ,[Importe de coste financiero]
			  ,[Ajuste]
			  ,RANK () OVER ( Partition BY [Código de artículo] Order by [Fecha física] desc) rank_nro

		FROM [Pruebas].[dbo].[dbo.TransaccionesInventario] ) A
WHERE A.rank_nro = 1 AND A.[Fecha física] IS NOT NULL







  group by [Código de artículo],[Fecha física],[Cantidad],[Precio Calculado]

  order by [Código de artículo], [Fecha física] desc
  
  


SELECT DISTINCT(idEmpleado),FechaMovimiento,Area 
FROM bd_secjo.tblmovimientos
GROUP BY idEmpleado,FechaMovimiento,Area
ORDER BY FechaMovimiento
  
  
  
  
  
  
  
