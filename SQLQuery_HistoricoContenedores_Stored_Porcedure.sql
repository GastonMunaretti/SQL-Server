-- =======================================================
-- Create Stored Procedure Template for Azure SQL Database
-- =======================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author: Gaston Marcelo Munaretti
-- Create Date: 08/03/2022
-- Description: Carga HistoricoContenedores a partir de la tabla Contenedores
-- =============================================
ALTER PROCEDURE [dbo].[MAP_HistoricoContenedores]

    

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

	
		MERGE INTO [dbo].[HistoricoContenedores] AS dest

		USING(	
				SELECT	
						A.Etiqueta									AS Etiqueta,
						A.Momento									AS Momento, 
						A.NumeroContenedor							AS NumeroContenedor,
						A.TipoContenedor							AS TipoContenedor,
						ISNULL(B.CodigoContenedor,'')				AS CodigoContenedor,
						CASE 
							WHEN B.CodigoContenedor IS NULL THEN 0
							ELSE 1
						END											AS TieneCompaniaAsignada,
						ISNULL(B.CodigoCompania,'')				AS Aerolinea,
						A.Fecha										AS FechaRegistro,
						A.Hora										AS HoraRegistro


		
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
					
		
			) source 
		
		
		ON  source.Etiqueta			= dest.Etiqueta			AND 
			source.NumeroContenedor = dest.NumeroContenedor AND
			source.TipoContenedor   = dest.TipoContenedor   AND
			source.FechaRegistro	= dest.FechaRegistro
		

		WHEN NOT MATCHED THEN 

			INSERT(	   Etiqueta,
					   Momento, 
					   NumeroContenedor,
					   TipoContenedor,
					   CodigoContenedor,
					   TieneCompaniaAsignada,
					   Aerolinea,
					   FechaRegistro,
					   HoraRegistro
									   
					)

			VALUES(	  
						  source.Etiqueta,
						  source.Momento, 
						  source.NumeroContenedor,
						  source.TipoContenedor,
						  source.CodigoContenedor,
						  source.TieneCompaniaAsignada,
						  source.Aerolinea,
						  source.FechaRegistro,
						  source.HoraRegistro
									  	   					  									 				 				
					
					);

	TRUNCATE TABLE [dbo].[Contenedores]

END
GO
