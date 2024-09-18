/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Id_Diagnostico]
      ,[Descripcion]
      ,[Id_Especialidad]
      ,[Id_Subespecialidad]
  FROM [OPERACIONES].[RrHh].[DIAGNOSTICO]


---------------------------------------------------------------------------------------------------------
--******************************************************************************************************-
---------------------------------------------------------------------------------------------------------

SELECT * FROM [RrHh].[ESPECIALIDAD]

SELECT * FROM [RrHh].[SUBESPECIALIDAD]

SELECT * FROM[RrHh].[CtrolMedico]

SELECT * FROM [RrHh].[DIAGNOSTICO]

SELECT * FROM [RrHh].[MedicinaLab_Cab]

---------------------------------------------------------------------------------------------------------
--******************************************************************************************************-
---------------------------------------------------------------------------------------------------------

SELECT A.Id_Diagnostico,
	   A.Descripcion,
	   B.Descripcion,
	   C.Nombre

FROM [RrHh].[DIAGNOSTICO] A 
	 LEFT JOIN [RrHh].[ESPECIALIDAD] B ON
	 A.Id_Especialidad = B.Id_Especialidad
	 LEFT JOIN [RrHh].[SUBESPECIALIDAD] C ON
	 A.Id_Subespecialidad = C.Id_Subespecialidad
---------------------------------------------------------------------------------------------------------
--******************************************************************************************************-
---------------------------------------------------------------------------------------------------------

SELECT L.fecha,
	   L.diagnostico,
	   M.Descripcion,
	   M.desc2,
	   M.Nombre,
	   L.legajo
	  



FROM [RrHh].[MedicinaLab_Cab] L

		 
		 JOIN 	(SELECT A.Id_Diagnostico,
				 A.Descripcion,
				 B.Descripcion desc2,
				 C.Nombre

				FROM [RrHh].[DIAGNOSTICO] A 
				LEFT JOIN [RrHh].[ESPECIALIDAD] B ON
				A.Id_Especialidad = B.Id_Especialidad
				LEFT JOIN [RrHh].[SUBESPECIALIDAD] C ON
				A.Id_Subespecialidad = C.Id_Subespecialidad) AS M
				ON L.Id_Diagnostico = M.Id_Diagnostico

Where L.diagnostico  like '%lumb%'		 





