USE [ModeloDeNegocio]


Select       T.ET_ID,
			 T.ET_IMEI,
			 T.ET_SERIE,
			 T.ET_ALTA,
			 T.ET_NROINT,
			 C.DescripcionGerencia,
			 T.EMP_DEPARTAMENTO,
			 T.EMP_LEGAJO,
			 A.ApellidoyNombre,
			 T.EMP_SUCURSAL,
			 T.MC_MARCA,
			 T.MD_NOMBRE


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
             Right Join [OPERACIONES].[dbo].[V_TELEFONOS] T On
					A.Legajo = T.EMP_LEGAJO
              
                    
Where        
			  T.MC_MARCA = 'CATERPILAR'
              
              --A.Usuario IS NULL
