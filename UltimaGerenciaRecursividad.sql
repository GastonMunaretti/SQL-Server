
-- Desde el nivel superior a los inferiores 



WITH
OrganigramaCTE( idUnidadOrganigrama, idPadre, Nivel)
AS
(   



	SELECT idUnidadOrganigrama, idPadre, Nivel
	
	FROM [dbo].[MOD_Organigrama] 
    
	WHERE FechaFin IS NULL AND idUnidadOrganigrama = 12
    
	UNION ALL
    -- Aquí va la recursividad
    
	SELECT A.idUnidadOrganigrama, A.idPadre, A.Nivel
          
    FROM   [dbo].[MOD_Organigrama] AS A 
           INNER JOIN OrganigramaCTE AS E -- Llamada a si misma
    ON (A.idUnidadOrganigrama = E.idPadre AND A.FechaFin IS NULL) -- Unión invertida
)
SELECT /*top 1*/ *

FROM OrganigramaCTE Z
JOIN [ModeloDeNegocio].[dbo].[MOD_UnidadOrganigrama] T
	On Z.idUnidadOrganigrama = T.idUnidadOrganigrama
JOIN [ModeloDeNegocio].[dbo].[MOD_Gerencias] W
	On T.DescripcionUnidadOrganigrama = W.DescripcionGerencia


WHERE nivel=1;
