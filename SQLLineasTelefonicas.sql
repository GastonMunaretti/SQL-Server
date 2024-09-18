USE [ModeloDeNegocio]


SELECT T1.IdFacturacion,
       T1.LineaCelular As 'LINEA EN LA FACTURA',
	   T2.CS_LINEA AS 'LINEA EN LA BASE DE DATOS',
	   T2.Legajo,
	   T2.ApellidoyNombre

FROM [Pruebas].[dbo].[FacturacionLineas] T1

LEFT JOIN 


(Select       A.Usuario,
             A.Legajo,
             A.ApellidoyNombre,
             B.CodigoSede,
             C.DescripcionGerencia,
             D.DescripcionArea,
             H.NombrePuesto,
             T.MC_MARCA AS 'Modelo_de_TEL',
			 T.ET_IMEI,
			 T.CS_LINEA

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

		WHERE T.ET_ESTADO ='ACTIVO' AND  T.Tipo = 'CELULAR' ) T2

	On T1.LineaCelular = T2.CS_LINEA

Order by 3




