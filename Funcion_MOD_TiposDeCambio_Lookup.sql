USE [DW]
GO
/****** Object:  UserDefinedFunction [dbo].[MOD_DEMORAS_LOOKUP]    Script Date: 25/6/2020 17:32:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[MOD_DEMORAS_LOOKUP] (

@pCodigoReal  numeric (18,0) 
)
RETURNS int AS
BEGIN
  DECLARE @nSKEY INT

  IF  (@pCodigoReal is NULL) 
  BEGIN
    SET @nSKEY = -2
  END
  ELSE
  BEGIN

    SELECT @nSKEY = IdDEMORAS
    FROM   MOD_DEMORAS
    WHERE  CodigoReal = @pCodigoReal 

    IF @nSKEY IS NULL
    BEGIN
        SET @nSKEY = -1
    END

  END

  RETURN @nSKEY
END