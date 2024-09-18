SELECT * 

FROM [dbo].[MOD_Certificacion] A

INNER JOIN [dbo].[MOD_CertificacionLiquidacion] B
	ON A.IdCertificacion = B.IdCertificacion
INNER JOIN  [dbo].[MOD_CertificacionLiquidacionObs] C
	ON B.IdCertificacionLiq = C.Id_CertificacionLiq

WHERE A.IdCertificacion = 33




/*

if exists (select * from  [dbo].[table] where id= [the id you want to check] ) 
select 'True'  
else 
select 'False' 
return*/

if exists (

SELECT * 

FROM [dbo].[MOD_Certificacion] A

INNER JOIN [dbo].[MOD_CertificacionLiquidacion] B
	ON A.IdCertificacion = B.IdCertificacion
INNER JOIN  [dbo].[MOD_CertificacionLiquidacionObs] C
	ON B.IdCertificacionLiq = C.Id_CertificacionLiq

WHERE A.IdCertificacion = 710

) 

select 'True'  
else 
select 'False' 
return

