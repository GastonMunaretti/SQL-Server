SELECT  
      A.Legajo,
      A.ApellidoyNombre,
	  A.Usuario + '@intercargo.com.ar',
	  B.NombrePuesto,
	  C.Sede


FROM [ModeloDeNegocio].[dbo].[MOD_Usuarios] A
	 join [dbo].[MOD_Puestos] B  ON A.idPuestoActual = B.idPuesto
	 join [dbo].[MOD_Sedes] C ON A.idSedeActual = C.idSede

WHERE A.Activo = 1 AND
	  C.CodigoSedeIntercargo = 'AEP' AND
	  B.NombrePuesto Like '%SUPERVISOR%'



--sp_helptext 'map_mod_usuarios' 