USE [Pruebas]
GO
/****** Object:  Trigger [dbo].[TX_IMP]    Script Date: 21/10/2019 15:59:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[TX_IMP]
ON [dbo].[IMPRESIONES]
FOR INSERT, UPDATE, DELETE
AS

begin

	SET NOCOUNT ON;
    INSERT INTO [dbo].[Empleados] Values('Gaston', '25024025', 250000)
	

	--PRINT 'Actualizacion de los registros de Productos'

end

