/****** Script for SelectTopNRows command from SSMS  ******/

set dateformat ymd


SELECT sum(A.CantidadAltas) -sum(A.CantidadBajas)

FROM [DW].[dbo].[F_DOTACION] A

Where A.IdFecha <= '2021-07-30 23:59'  


SELECT *

FROM [DW].[dbo].[F_DOTACION] A



/****** Script for SelectTopNRows command from SSMS  ******/

set dateformat ymd


SELECT sum(A.CantidadAltas) AS 'ALTAS'--sum(A.CantidadBajas)

FROM [DW].[dbo].[F_DOTACION] A

Where A.IdFecha between '2021-07-01 00:00'  and '2021-07-30 23:59'



SELECT sum(A.CantidadBajas) AS 'BAJAS'

FROM [DW].[dbo].[F_DOTACION] A

Where A.IdFecha between '2021-07-01 00:00'  and '2021-07-30 23:59'






SELECT *

FROM [DW].[dbo].[F_DOTACION] A
