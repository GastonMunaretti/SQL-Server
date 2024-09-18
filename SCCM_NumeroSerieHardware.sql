
			-- COUNT(T.MC_MARCA) AS 'CANT-CYRUS'
		


USE [ModeloDeNegocio]


Select       A.Usuario,
		     A.ApellidoyNombre,
			 A.Nombre,
			 A.Apellido,
			 B.Sede
                   
             --T.MC_MARCA AS 'Modelo_de_TEL',
		

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
          
                    
Where        
			  A.Apellido = 'san martin'			  	 
              
              
