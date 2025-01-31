USE [ModeloDeNegocio]
GO
/****** Object:  UserDefinedFunction [dbo].[GET_IdGerenciaFromIdCuadroFecha]    Script Date: 30/06/2022 13:11:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER FUNCTION [dbo].[GET_IdGerenciaFromIdCuadroFecha] (
@pIdCuadro int,
@pFecha date 
)
RETURNS int AS
BEGIN
  DECLARE @idGerencia int
  
  IF @pIdCuadro Is Null
  BEGIN
	SET @pIdCuadro = -2
  END
   
  

  ELSE
  BEGIN
			IF @pFecha Is Null
			BEGIN
				SET @pFecha = CONVERT(DATE,GETDATE())
			END;
			

			WITH
			OrganigramaCTE( idUnidadOrganigrama, idPadre, Nivel, FechaInicio, FechaFin)
			AS
			(   
					   
				SELECT idUnidadOrganigrama, idPadre, Nivel, FechaInicio, FechaFin
	
				FROM [dbo].[MOD_Organigrama] 
    
				WHERE  idUnidadOrganigrama = @pIdCuadro   AND @pFecha BETWEEN FechaInicio AND ISNULL(FechaFin,'2100-01-01') /****  Facturacion ****/
    
				UNION ALL
				-- Aquí va la recursividad
    
				SELECT A.idUnidadOrganigrama, A.idPadre, A.Nivel, A.FechaInicio, A.FechaFin
          
				FROM   [dbo].[MOD_Organigrama] AS A 
					   INNER JOIN OrganigramaCTE AS E -- Llamada a si misma
				ON (A.idUnidadOrganigrama = E.idPadre ) AND @pFecha BETWEEN A.FechaInicio AND ISNULL(A.FechaFin,'2100-01-01') -- Unión invertida
			
			)

					   			 		  		  		 	   			   	 		
			SELECT TOP 1 @idGerencia =  W.IdGerencia

			FROM OrganigramaCTE Z
			JOIN [ModeloDeNegocio].[dbo].[MOD_UnidadOrganigrama] T
				On Z.idUnidadOrganigrama = T.idUnidadOrganigrama
			JOIN [ModeloDeNegocio].[dbo].[MOD_Gerencias] W
				On T.DescripcionUnidadOrganigrama = W.DescripcionGerencia


			WHERE Nivel=1

			  
   
   If @idGerencia Is Null
     BEGIN
		SET @idGerencia = -1
	 END
   
  END    
  RETURN  @idGerencia  
END


