use OPERACIONES
go

BEGIN TRANSACTION
CREATE TABLE #tempGlobalB  
    (  
        Usuario   NVARCHAR(50) ,
		Nombre    NVARCHAR(100),
		Departamento NVARCHAR(100),
		Oficina NVARCHAR(100),
		Tarjeta NVARCHAR(100),
		Color NVARCHAR(100),
		Grises NVARCHAR(100),
		Doble NVARCHAR(100),
		Simples NVARCHAR(100),
		Paginas NVARCHAR(100),
		Trabajos NVARCHAR(100),
		Promedio NVARCHAR(100),
		Costo NVARCHAR(100),
		CostoPromedio NVARCHAR(100)
    );  

	

DECLARE @dia varchar(10)=convert(varchar(10),getdate()-1,120)

DECLARE @datefile varchar(10)=convert(varchar(10),getdate(),120) 

DECLARE @path varchar(50)='\\SPOOLPRINTER\inf_imp\IMP-'+@datefile+'.csv'
DECLARE @patherror VARCHAR(50)='\\SPOOLPRINTER\inf_imp\importados\Error.csv'
DECLARE @SQL_BULK VARCHAR(MAX)


  
SET @SQL_BULK='BULK INSERT #tempGlobalB  
    FROM ''' + @path + '''
	WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = '';'',  --CSV field delimiter
    ROWTERMINATOR = ''\n'',   --Use to shift the control to next row    
	ERRORFILE = ''+@patherror+'',
    TABLOCK
    )'

EXEC (@SQL_BULK)
--select * from #tempGlobalB 

INSERT INTO [DTI].[DetalleImpresion] ( Fecha,NombreUsuario,Paginas )
SELECT  @dia,Usuario,Paginas
FROM     #tempGlobalB

UPDATE       DTI.DetalleImpresion
SET                Gerencia = dbo.EMPLEADO.EMP_GERENCIA, Area = dbo.EMPLEADO.EMP_AREA, Departamento = dbo.EMPLEADO.EMP_DEPARTAMENTO, Sector = dbo.EMPLEADO.EMP_SECTOR
FROM            DTI.DetalleImpresion INNER JOIN
                         dbo.UsuariosAD ON DTI.DetalleImpresion.NombreUsuario = dbo.UsuariosAD.SamAccountName INNER JOIN
                         dbo.EMPLEADO ON dbo.UsuariosAD.Pager = dbo.EMPLEADO.EMP_LEGAJO 
WHERE        (DTI.DetalleImpresion.Gerencia IS NULL)


DROP TABLE #tempGlobalB  
COMMIT
