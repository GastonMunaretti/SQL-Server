SELECT              A.ET_IMEI,
                           A.ET_ESTADO,
                           A.ET_NROINT,
                           A.ET_SERIE,
                           D.MC_MARCA,
                           F.PF_APELLIDO, 
                F.PF_NOMBRES,
                           RTRIM(G.EMP_SUCURSAL) EMP_SUCURSAL,
                           G.EMP_LEGAJO,
                           G.EMP_DNI

FROM            DTI.EQTELEFONICO  A
                           JOIN DTI.MODELOTEL B ON
                                  A.MD_ID = B.MD_ID
                           JOIN DTI.TIPOMARCAS C ON 
                                  B.Id_TipoMarcas = C.Id_TipoMarcas
                           JOIN DTI.MARCATEL D ON
                                  C.MC_ID = D.MC_ID
                           JOIN DTI.USUARIOEQUIPO E ON
                                  A.ET_ID = E.ET_ID
                           JOIN DTI.PERSONASFISICAS F ON
                                  E.PF_ID = F.PF_ID
                           JOIN EMPLEADO G ON
                                  F.PF_TIPODOC = G.EMP_TIPODOC AND
                                  F.PF_NUMERODOC = G.EMP_DNI

WHERE       (D.MC_MARCA = 'CATERPILAR') AND
            (RTRIM(G.EMP_SUCURSAL) = 'AEP AEROPARQUE') AND
            (A.ET_ESTADO = 'ACTIVO')AND
            (A.ET_ALTA > '2019-09-01')


ORDER BY     ET_NROINT, E.UST_HASTA


--SELECT * FROM DTI.USUARIOEQUIPO WHERE UST_ID = 4848 

--PARA BORRAR EL REGISTRO DE ARRIBA
--DELETE DTI.USUARIOEQUIPO WHERE UST_ID = 4848
