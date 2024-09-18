/****** Script for SelectTopNRows command from SSMS  ******/
SELECT	
		A.Etiqueta			AS Etiqueta,
		A.Momento			AS Momento, 
		A.NumeroContenedor  AS NumeroContenedor,
		A.TipoContenedor	AS TipoContenedor,
		B.CodigoContenedor	AS CodigoContenedor,
		CASE 
			WHEN B.CodigoContenedor IS NULL THEN 0
			ELSE 1
		END					AS TieneCompaniaAsignada,
		B.CodigoCompania	AS Aerolinea,
		A.Fecha				AS FechaRegistro,
		A.Hora				AS HoraRegistro


		
FROM(		SELECT	[Id]
					,[Etiqueta]
					,[Momento]
					,RANK() OVER (PARTITION BY Etiqueta ORDER BY Momento DESC ) ranking
					,dbo.udf_GetNumeric(Etiqueta) AS NumeroContenedor
					,SUBSTRING(Etiqueta,1,3) AS TipoContenedor
					,REVERSE(LEFT(REVERSE(Etiqueta), CHARINDEX(' ', REVERSE(Etiqueta))-1 )) AS EtiquetaComp
					,CONVERT(VARCHAR(10), Momento, 111) AS Fecha
					,FORMAT(Momento,'HH:mm') AS Hora

		FROM [dbo].[Contenedores] ) A
LEFT JOIN [dbo].[CodigoContenedorAerolinea] B
	ON A.EtiquetaComp = B.CodigoContenedor
WHERE A.ranking = 1
order by A.Momento desc

  
  
  --truncate table [dbo].[Contenedores] 


  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT distinct
      [Etiqueta]
      
  FROM [dbo].[Contenedores] 
  