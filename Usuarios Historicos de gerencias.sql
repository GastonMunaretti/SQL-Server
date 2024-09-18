
Use ModeloDeNegocio

DECLARE @dias int= 100

Select A.Idusuario,

             B.Legajo,
             B.ApellidoyNombre,
             C.Sede,
             D.NombrePuesto Puesto,
             E.DescripcionGerencia Gerencia,
             F.DescripcionArea DescripcionArea,
			 Case When F.idArea = -2 Then '' Else F.DescripcionArea End Area,
             
             G.DescripcionDepartamento Departamento,
             H.DescripcionSector Sector,
             I.DescripcionSubSector SubSector

From   (      Select idUsuario
                    From   MOD_HistoricoUsuarioSedes
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                           GETDATE() And
                           FechaFin Is Null
                    Union all
                    Select idUsuario
                    From   MOD_HistoricoUsuarioPuestos
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                                  GETDATE() And
                                  FechaFin Is Null
                    Union all
                    Select idUsuario
                    From   MOD_HistoricoUsuarioGerencias
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                                  GETDATE() And
                                  FechaFin Is Null
                    Union  all
                    Select idUsuario
                    From   MOD_HistoricoUsuarioAreas
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                                  GETDATE() And
                                  FechaFin Is Null
                    Union  all
                    Select IdUsuario
                    From   MOD_HistoricoUsuarioDepartamentos
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                                  GETDATE() And
                                  FechaFin Is Null
                    Union  all
                    Select IdUsuario
                    From   MOD_HistoricoUsuarioSectores
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                                  GETDATE() And
                                  FechaFin Is Null
                    union all
                    Select IdUsuario
                    From   MOD_HistoricoUsuarioSubSectores
                    Where  FechaInicio Between dbo.trunc(GETDATE()) - @dias And
                                  GETDATE() And
                                  FechaFin Is Null) A 
             Join MOD_Usuarios B On
                    A.idUsuario = B.idUsuario
             Join MOD_Sedes C On
                    B.idSedeActual = C.idSede
             Join MOD_Puestos D On
                    B.idPuestoActual = D.idPuesto
             Join MOD_Gerencias E On
                    B.IdGerenciaActual = E.IdGerencia
             Join MOD_Areas F On
                    B.IdAreaActual = F.idArea
             Join MOD_Departamentos G On
                    B.idDepartamentoActual = G.idDepartamento
             Join MOD_Sectores H On
                    B.IdSectorActual = H.IdSector
             Join MOD_SubSectores I On
                    B.IdSubSectorActual = I.idSubSector

--Where a.idUsuario in (281,329,585,717,1162,2246,2332,2333,2460,2624,2875,2933)

Group By	 
			 A.Idusuario,
             B.Legajo,
             B.ApellidoyNombre,
             C.Sede,
             D.NombrePuesto,
             E.DescripcionGerencia,
             F.DescripcionArea,
             F.idArea,
             G.DescripcionDepartamento,
             H.DescripcionSector,
             I.DescripcionSubSector  






Select		 A.Idusuario,
             B.Legajo,
             B.ApellidoyNombre,
             C.Sede,
             D.NombrePuesto Puesto,
             E.DescripcionGerencia Gerencia,
             F.DescripcionArea DescripcionArea,
			 Case When F.idArea = -2 Then '' Else F.DescripcionArea End Area,
    
             G.DescripcionDepartamento Departamento,
             H.DescripcionSector Sector,
             I.DescripcionSubSector SubSector

From	MOD_Usuarios A


		Join MOD_Usuarios B On
                    A.idUsuario = B.idUsuario
        Join MOD_Sedes C On
                    B.idSedeActual = C.idSede
        Join MOD_Puestos D On
                    B.idPuestoActual = D.idPuesto
        Join MOD_Gerencias E On
                    B.IdGerenciaActual = E.IdGerencia
             Join MOD_Areas F On
                    B.IdAreaActual = F.idArea
             Join MOD_Departamentos G On
                    B.idDepartamentoActual = G.idDepartamento
             Join MOD_Sectores H On
                    B.IdSectorActual = H.IdSector
             Join MOD_SubSectores I On
                    B.IdSubSectorActual = I.idSubSector


Where	A.Idgerenciaactual = 9