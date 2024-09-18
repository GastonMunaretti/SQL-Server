
			-- COUNT(T.MC_MARCA) AS 'CANT-CYRUS'
		


USE [ModeloDeNegocio]


Select       A.Usuario AS 'USUARIO',
             A.ApellidoyNombre AS 'APELLIDO Y NOMBRE',
                  
             T.MC_MARCA AS 'MODELO',
			 T.ET_IMEI AS 'IMEI',
			 T.ET_SERIE AS 'N° SERIE',
			 T.ET_ALTA AS 'FECHA DE ALTA'

			 --COUNT(A.Usuario) AS 'CANT_CAT'

From          Mod_Usuarios A
             Join MOD_Sedes B On
                    A.IdSedeActual = B.IdSede
             Join MOD_Gerencias C On
                    A.IdGerenciaActual = C.IdGerencia
             Join MOD_Areas D On
                    A.IdAreaActual = D.IdArea
             Join MOD_Departamentos E On
                    A.IdDepartamentoActual = E.IdDepartamento
             Join MOD_Sectores F On
                    A.IdSectorActual = F.IdSector
             Join MOD_Subsectores G On
                    A.IdSubsectorActual = G.IdSubsector
             Join MOD_Puestos H On
                    A.IdPuestoActual = H.IdPuesto
             Join MOD_UnidadOrganigrama I On
                    A.IdUnidadOrganigramaActual = I.IdUnidadOrganigrama
             Join [OPERACIONES].[dbo].[V_TELEFONOS] T On
					A.Legajo = T.EMP_LEGAJO
              
                    
Where        
			  T.MC_MARCA = 'Caterpilar'	AND
			  B.Sede = 'EZEIZA' AND
			  T.ET_ALTA > '2019-10-01' 
              
              

GROUP BY A.Usuario, A.ApellidoyNombre,T.MC_MARCA,  T.ET_IMEI, T.ET_SERIE,  T.ET_ALTA 

HAVING (COUNT(A.Usuario)>0)
order by ET_ALTA

