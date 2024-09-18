/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [IdSubCategoria]
      ,[CodigoSubCategoria]
      ,[Codigo]
      ,[Descripcion]
      ,[Habilitado]
      ,[FecUltAct]
      ,[UsuUltAct]
  FROM [ModeloDeNegocio].[dbo].[MOD_SubCategoriaDemora]


select * from [dbo].[MOD_CategoriaDemora]
select * from [dbo].[MOD_TipoDemora]