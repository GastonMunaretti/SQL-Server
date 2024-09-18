
/*

WITH
OrganigramaCTE( idUnidadOrganigrama, idPadre, Nivel, FechaFin)
AS
(   



	SELECT idUnidadOrganigrama, idPadre, Nivel, FechaFin
	
	FROM [dbo].[MOD_Organigrama] 
    
	--WHERE  idUnidadOrganigrama = 32
    
	UNION ALL
    -- Aquí va la recursividad
    
	SELECT A.idUnidadOrganigrama, A.idPadre, A.Nivel, A.FechaFin
          
    FROM   [dbo].[MOD_Organigrama] AS A 
           INNER JOIN OrganigramaCTE AS E -- Llamada a si misma
    ON (A.idUnidadOrganigrama = E.idPadre ) -- Unión invertida
)
SELECT	Z.idUnidadOrganigrama,
		T.DescripcionUnidadOrganigrama,
		T.idUnidadOrganigrama,
		T.DescripcionUnidadOrganigrama,
		Z.FechaFin,
		W.IdGerencia,
		W.DescripcionGerencia,
		Z.Nivel

FROM OrganigramaCTE Z
JOIN [ModeloDeNegocio].[dbo].[MOD_UnidadOrganigrama] T
	On Z.idUnidadOrganigrama = T.idUnidadOrganigrama
JOIN [ModeloDeNegocio].[dbo].[MOD_Gerencias] W
	On T.DescripcionUnidadOrganigrama = W.DescripcionGerencia;

--WHERE nivel=1;

*/

/****************************************************************/

/*
SELECT *
FROM [dbo].[MOD_Organigrama] 
*/





declare @Fecha date
declare @IdUnidadOrg int

set @Fecha = '2022-06-30' 
set @IdUnidadOrg =19;


WITH
OrganigramaCTE( idUnidadOrganigrama, idPadre, Nivel, FechaInicio, FechaFin)
AS
(   



	SELECT idUnidadOrganigrama, idPadre, Nivel, FechaInicio, FechaFin
	
	FROM [dbo].[MOD_Organigrama] 
    
	WHERE  idUnidadOrganigrama = @IdUnidadOrg   AND @Fecha BETWEEN FechaInicio AND ISNULL(FechaFin,'2100-01-01') /****  Facturacion ****/
    
	UNION ALL
    -- Aquí va la recursividad
    
	SELECT A.idUnidadOrganigrama, A.idPadre, A.Nivel, A.FechaInicio, A.FechaFin
          
    FROM   [dbo].[MOD_Organigrama] AS A 
           INNER JOIN OrganigramaCTE AS E -- Llamada a si misma
    ON (A.idUnidadOrganigrama = E.idPadre ) AND @Fecha BETWEEN A.FechaInicio AND ISNULL(A.FechaFin,'2100-01-01') -- Unión invertida
)
SELECT	TOP 1 
		Z.idUnidadOrganigrama,
		Z.idPadre,
		Z.Nivel,
		Z.FechaInicio,
		Z.FechaFin,
		T.DescripcionUnidadOrganigrama

FROM OrganigramaCTE Z

JOIN [ModeloDeNegocio].[dbo].[MOD_UnidadOrganigrama] T
	On Z.idUnidadOrganigrama = T.idUnidadOrganigrama

WHERE  Nivel=1;


/* 143-Finanzas  -->  137-Jefatura de finanzas --> 2019-04-09, 2020-07-13   8-Gcia Administración y Finanzas  -->   370001 Direccion Administrativa */

/* 143-Finanzas  -->  137-Jefatura de finanzas --> Hoy 435275  Gcia Administración y Finanzas y Relac.Comerciales --> 370001 Direccion Administrativa */






WITH
OrganigramaCTE( idUnidadOrganigrama, idPadre, Nivel, FechaFin)
AS
(   



	SELECT idUnidadOrganigrama, idPadre, Nivel, FechaFin
	
	FROM [dbo].[MOD_Organigrama] 
    
	--WHERE  idUnidadOrganigrama = 32
    
	UNION ALL
    -- Aquí va la recursividad
    
	SELECT A.idUnidadOrganigrama, A.idPadre, A.Nivel, A.FechaFin
          
    FROM   [dbo].[MOD_Organigrama] AS A 
           INNER JOIN OrganigramaCTE AS E -- Llamada a si misma
    ON (A.idUnidadOrganigrama = E.idPadre ) -- Unión invertida
)
SELECT	
		Z.idPadre,
		Z.idUnidadOrganigrama,
		T.DescripcionUnidadOrganigrama,
		Z.FechaFin,
		W.IdGerencia,
		W.DescripcionGerencia,
		Z.Nivel

FROM OrganigramaCTE Z
JOIN [ModeloDeNegocio].[dbo].[MOD_UnidadOrganigrama] T
	On Z.idUnidadOrganigrama = T.idUnidadOrganigrama
JOIN [ModeloDeNegocio].[dbo].[MOD_Gerencias] W
	On T.DescripcionUnidadOrganigrama = W.DescripcionGerencia;

--WHERE nivel=1;