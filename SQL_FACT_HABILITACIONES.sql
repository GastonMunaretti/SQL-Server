/*


SELECT A.IdEmpleadoCursos															as IdEmpleadoCursos, 
						  A.CodigoCEM_IDCURSO															as CodigoCEM_IDCURSO,
						  A.LegajoEmpleado																as LegajoEmpleado,
						  
						  A.Fecha																		as Fecha,
						  DATEADD(DAY,-G.DiasAviso,A.FechaVencimiento)									as FechaAviso,
						  A.FechaVencimiento															as FechaVencimiento,
						  A.EstadoAprobacion															as EstadoAprobacion,
						  B.IdUsuario																	as IdUsuario,
						  B.Usuario																		as Usuario,
						  B.IdPuestoActual																as IdPuestoActual,
						  B.IdGerenciaActual															as IdGerenciaActual,
						  B.IdAreaActual																as IdAreaActual,
						  B.IdSectorActual																as IdSectorActual,
						  B.IdSubsectorActual															as IdSubsectorActual,
						  B.IdUnidadOrganigramaActual													as IdUnidadOrganigramaActual,
						  B.IdTipoDeUsuario																as IdTipoDeUsuario,
						  B.IdTipoRRHH																	as IdTipoRRHH,
						  B.IdFuncionDePuesto															as IdFuncionDePuesto,
						  B.IdGrupoProgramable															as IdGrupoProgramable,
						  C.IdCurso																		as IdCurso,
						  C.CodigoCurCodigo																as CodigoCurCodigo,
						  C.IdHabilitacion																as IdHabilitacion,
						  D.IdItemGrupoAero																as IdItemGrupoAero,
						  D.CodigoItemGrupoAero															as CodigoItemGrupoAero,
						  
						  D.IdSede																		as IdSede,
						  E.IdHabilitacionesGrupoAero													as IdHabilitacionesGrupoAero,
						  E.CodigoGrupoAero																as CodigoGrupoAero,
						  F.IdHabilitacionFuncion														as IdHabilitacionFuncion,
						  F.CodigoHabilitacionFuncion													as CodigoHabilitacionFuncion,
						  F.IdGrupoAero																	as IdGrupoAero,
						  F.IdFuncion																	as IdFuncion
						  

				  FROM [ModeloDeNegocio].[dbo].[MOD_EmpleadoCursos] A 



				  join [ModeloDeNegocio].dbo.[MOD_Usuarios] B on 
				  a.LegajoEmpleado = b.Legajo		
				  
				  join [ModeloDeNegocio].dbo.[MOD_Cursos] C on 
				  A.IdCurso = C.IdCurso

				  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesItemGrupoAero] D 
				  on B.idSedeActual = D.IdSede

                  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesGruposAero] E 
				  on D.IdGrupoAero =  E.IdHabilitacionesGrupoAero

                  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesFuncion] F on 
                  f.IdGrupoAero = E.IdHabilitacionesGrupoAero and f.IdFuncion = B.idPuestoActual and f.IdHabilitacion = C.IdHabilitacion

                  join [ModeloDeNegocio].dbo.[MOD_Habilitaciones] G on 
                  G.IdHabilitacion = C.IdHabilitacion


				 WHERE	 C.TieneHabilitacionAsociada = 1 and a.fecha is not null


				 */


/************************************************************************************************************/
/*==========================================================================================================*/
/*		 Cursos que ya tiene, no vencidos																									*/
/*==========================================================================================================*/




select * from (        SELECT A.IdEmpleadoCursos														as IdEmpleadoCursos, 
							  A.CodigoCEM_IDCURSO															as CodigoCEM_IDCURSO,
							  A.LegajoEmpleado																as LegajoEmpleado,
							  G.Descripcion,
						  
							  A.Fecha																		as Fecha,
							  DATEADD(DAY,-G.DiasAviso,A.FechaVencimiento)									as FechaAviso,
							  A.FechaVencimiento															as FechaVencimiento,
							  -DATEDIFF(DAY, A.FechaVencimiento, GETDATE())									as DiasVencidos,
							  A.EstadoAprobacion															as EstadoAprobacion,
							  B.IdUsuario																	as IdUsuario,
							  B.Usuario																		as Usuario,
							  B.IdPuestoActual																as IdPuestoActual,
							  B.IdGerenciaActual															as IdGerenciaActual,
							  B.IdAreaActual																as IdAreaActual,
							  B.IdSectorActual																as IdSectorActual,
							  B.IdSubsectorActual															as IdSubsectorActual,
							  B.IdUnidadOrganigramaActual													as IdUnidadOrganigramaActual,
							  B.IdTipoDeUsuario																as IdTipoDeUsuario,
							  B.IdTipoRRHH																	as IdTipoRRHH,
							  B.IdFuncionDePuesto															as IdFuncionDePuesto,
							  B.IdGrupoProgramable															as IdGrupoProgramable,
							  C.IdCurso																		as IdCurso,
							  C.CodigoCurCodigo																as CodigoCurCodigo,
							  C.IdHabilitacion																as IdHabilitacion,
							  D.IdItemGrupoAero																as IdItemGrupoAero,
							  D.CodigoItemGrupoAero															as CodigoItemGrupoAero,
						  
							  D.IdSede																		as IdSede,
							  E.IdHabilitacionesGrupoAero													as IdHabilitacionesGrupoAero,
							  E.CodigoGrupoAero																as CodigoGrupoAero,
							  F.IdHabilitacionFuncion														as IdHabilitacionFuncion,
							  F.CodigoHabilitacionFuncion													as CodigoHabilitacionFuncion,
							  F.IdGrupoAero																	as IdGrupoAero,
							  F.IdFuncion																	as IdFuncion
						  

					  FROM [ModeloDeNegocio].[dbo].[MOD_EmpleadoCursos] A 



					  join [ModeloDeNegocio].dbo.[MOD_Usuarios] B on 
					  a.LegajoEmpleado = b.Legajo		
				  
					  join [ModeloDeNegocio].dbo.[MOD_Cursos] C on 
					  A.IdCurso = C.IdCurso

					  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesItemGrupoAero] D 
					  on B.idSedeActual = D.IdSede

					  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesGruposAero] E 
					  on D.IdGrupoAero =  E.IdHabilitacionesGrupoAero

					  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesFuncion] F on 
					  f.IdGrupoAero = E.IdHabilitacionesGrupoAero and f.IdFuncion = B.idPuestoActual and f.IdHabilitacion = C.IdHabilitacion

					  join [ModeloDeNegocio].dbo.[MOD_Habilitaciones] G on 
					  G.IdHabilitacion = C.IdHabilitacion

					union 


					SELECT  
								B.IdHabilitacion								as IdEmpleadosCursos,
								B.CodigoEmpleado								as CodigoCEM_IDCURSO,
								C.Legajo										as LegajoEmpleado,
								A.Descripcion,
								''												as Fecha,---ver
								dateadd(day,-A.DiasAviso,B.FechaVencimiento)	as FechaAviso,
								B.FechaVencimiento								as FechaVencimiento	,
								 -DATEDIFF(DAY, B.FechaVencimiento, GETDATE())	as DiasVencidos,
								A.Descripcion									as EstadoAprobacion,
								B.IdUsuario										as IdUsuario,
								C.Usuario										as Usuario,
								C.idPuestoActual,
								C.IdGerenciaActual,
								C.IdAreaActual,
								C.IdSectorActual,
								C.IdSubSectorActual,
								C.IdUnidadOrganigramaActual,
								C.IdTipoDeUsuario,
								C.IdTipoRRHH,
								C.IdFuncionDePuesto,
								C.IdGrupoProgramable,
								E.IdCurso										as IdCurso,
								E.CodigoCurCodigo								as CodigoCurCodigo,
								B.IdHabilitacion                                as IdHabilitacion,
								F.IdItemGrupoAero								as IdItemGrupoAero,
								F.CodigoItemGrupoAero							as CodigoIdItemGrupoAero,
								C.IdSedeActual as IdSede,
								F.IdGrupoAero	as IdHabilitacionesGrupoAero,
								F.IdGrupoAero	as CodigoGrupoAero,
								G.IdHabilitacionFuncion,
								G.CodigoHabilitacionFuncion,
								F.IdGrupoAero,
								G.IdFuncion
		
		


					FROM [ModeloDeNegocio].[dbo].[MOD_HabilitacionesVencimiento] B

					join MOD_Usuarios C
								On C.Idusuario = B.IdUsuario

					join MOD_Habilitaciones A
								On A.Idhabilitacion = B.Idhabilitacion


					left join ModeloDeNegocio.dbo.MOD_HabilitacionesItemGrupoAero F
								On  F.IdSede = C.idSedeActual
		

					left Join [ModeloDeNegocio].[dbo].[MOD_Cursos] E
								On B.IdHabilitacion = E.IdHabilitacion


					left Join ModeloDeNegocio.dbo.MOD_HabilitacionesFuncion G
							On  G.IdFuncion      = C.idPuestoActual AND
								G.IdHabilitacion = A.IdHabilitacion AND
								G.IdGrupoAero	 = F.IdGrupoAero

					where B.CodigoHabilitacion = 15 or B.CodigoHabilitacion = 23 or B.CodigoHabilitacion = 36) M

WHERE	(M.LegajoEmpleado = '25918' ) AND( M.FechaVencimiento >= getdate())






























/* Cursos que ya tiene */

SELECT		A.IdEmpleadoCursos															as IdEmpleadoCursos, 
			A.CodigoCEM_IDCURSO															as CodigoCEM_IDCURSO,
			A.LegajoEmpleado																as LegajoEmpleado,
						  
			A.Fecha																		as Fecha,
			DATEADD(DAY,-G.DiasAviso,A.FechaVencimiento)									as FechaAviso,
			A.FechaVencimiento															as FechaVencimiento,
			A.EstadoAprobacion															as EstadoAprobacion,
			B.IdUsuario																	as IdUsuario,
			B.Usuario																		as Usuario,
			B.IdPuestoActual																as IdPuestoActual,
			B.IdGerenciaActual															as IdGerenciaActual,
			B.IdAreaActual																as IdAreaActual,
			B.IdSectorActual																as IdSectorActual,
			B.IdSubsectorActual															as IdSubsectorActual,
			B.IdUnidadOrganigramaActual													as IdUnidadOrganigramaActual,
			B.IdTipoDeUsuario																as IdTipoDeUsuario,
			B.IdTipoRRHH																	as IdTipoRRHH,
			B.IdFuncionDePuesto															as IdFuncionDePuesto,
			B.IdGrupoProgramable															as IdGrupoProgramable,
			C.IdCurso																		as IdCurso,
			C.CodigoCurCodigo																as CodigoCurCodigo,
			C.IdHabilitacion																as IdHabilitacion,
			D.IdItemGrupoAero																as IdItemGrupoAero,
			D.CodigoItemGrupoAero															as CodigoItemGrupoAero,
						  
			D.IdSede																		as IdSede,
			E.IdHabilitacionesGrupoAero													as IdHabilitacionesGrupoAero,
			E.CodigoGrupoAero																as CodigoGrupoAero,
			F.IdHabilitacionFuncion														as IdHabilitacionFuncion,
			F.CodigoHabilitacionFuncion													as CodigoHabilitacionFuncion,
			F.IdGrupoAero																	as IdGrupoAero,
			F.IdFuncion																	as IdFuncion,
			G.TieneVencimiento

						  

FROM [ModeloDeNegocio].[dbo].[MOD_EmpleadoCursos] A 



join [ModeloDeNegocio].dbo.[MOD_Usuarios] B on 
a.LegajoEmpleado = b.Legajo		
				  
join [ModeloDeNegocio].dbo.[MOD_Cursos] C on 
A.IdCurso = C.IdCurso

join [ModeloDeNegocio].dbo.[MOD_HabilitacionesItemGrupoAero] D 
on B.idSedeActual = D.IdSede

join [ModeloDeNegocio].dbo.[MOD_HabilitacionesGruposAero] E 
on D.IdGrupoAero =  E.IdHabilitacionesGrupoAero

join [ModeloDeNegocio].dbo.[MOD_HabilitacionesFuncion] F on 
f.IdGrupoAero = E.IdHabilitacionesGrupoAero and f.IdFuncion = B.idPuestoActual and f.IdHabilitacion = C.IdHabilitacion

join [ModeloDeNegocio].dbo.[MOD_Habilitaciones] G on 
G.IdHabilitacion = C.IdHabilitacion


WHERE	 (A.LegajoEmpleado = '25918' and A.Fecha is not null) AND (G.TieneVencimiento = 1 AND A.FechaVencimiento >= getdate())




GO


/* Los que deberia tener */




SELECT 
						  B.IdUsuario																	as IdUsuario,
						  B.Usuario																		as Usuario,
						  B.IdPuestoActual																as IdPuestoActual,
						  B.IdGerenciaActual															as IdGerenciaActual,
						  B.IdAreaActual																as IdAreaActual,
						  B.IdSectorActual																as IdSectorActual,
						  B.IdSubsectorActual															as IdSubsectorActual,
						  B.IdUnidadOrganigramaActual													as IdUnidadOrganigramaActual,
						  B.IdTipoDeUsuario																as IdTipoDeUsuario,
						  B.IdTipoRRHH																	as IdTipoRRHH,
						  B.IdFuncionDePuesto															as IdFuncionDePuesto,
						  B.IdGrupoProgramable															as IdGrupoProgramable,
						  
						  
						  D.IdItemGrupoAero																as IdItemGrupoAero,
						  D.CodigoItemGrupoAero															as CodigoItemGrupoAero,
						  
						  D.IdSede																		as IdSede,
						  E.IdHabilitacionesGrupoAero													as IdHabilitacionesGrupoAero,
						  E.CodigoGrupoAero																as CodigoGrupoAero,
						  F.IdHabilitacionFuncion														as IdHabilitacionFuncion,
						  F.CodigoHabilitacionFuncion													as CodigoHabilitacionFuncion,
						  F.IdGrupoAero																	as IdGrupoAero,
						  F.IdFuncion																	as IdFuncion,

						  G.IdHabilitacion,
						  G.Descripcion,
						  G.TieneVencimiento

						  

				  FROM [ModeloDeNegocio].dbo.[MOD_Usuarios] B 			  
				  

				  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesItemGrupoAero] D 
				  on B.idSedeActual = D.IdSede

                  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesGruposAero] E 
				  on D.IdGrupoAero =  E.IdHabilitacionesGrupoAero

                  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesFuncion] F on 
                  f.IdGrupoAero = E.IdHabilitacionesGrupoAero and F.IdFuncion = B.idPuestoActual 

                  join [ModeloDeNegocio].dbo.[MOD_Habilitaciones] G on 
                  G.IdHabilitacion = F.IdHabilitacion


WHERE	 (B.Legajo = '25918' ) AND F.Habilitado = 1


GO



/*=================================================================================================================*/
/*		Los Cursos que faltan																					   */
/*=================================================================================================================*/



select  Z.Legajo,
		L.LegajoEmpleado,
		L.IdHabilitacion,
		Z.IdHabilitacion,
		Z.Descripcion



from

         (select * from   (
					      SELECT       A.IdEmpleadoCursos														as IdEmpleadoCursos, 
										  A.CodigoCEM_IDCURSO															as CodigoCEM_IDCURSO,
										  A.LegajoEmpleado																as LegajoEmpleado,
						  
										  A.Fecha																		as Fecha,
										  DATEADD(DAY,-G.DiasAviso,A.FechaVencimiento)									as FechaAviso,
										  A.FechaVencimiento															as FechaVencimiento,
										  -DATEDIFF(DAY, A.FechaVencimiento, GETDATE())									as DiasVencidos,
										  A.EstadoAprobacion															as EstadoAprobacion,
										  B.IdUsuario																	as IdUsuario,
										  B.Usuario																		as Usuario,
										  B.IdPuestoActual																as IdPuestoActual,
										  B.IdGerenciaActual															as IdGerenciaActual,
										  B.IdAreaActual																as IdAreaActual,
										  B.IdSectorActual																as IdSectorActual,
										  B.IdSubsectorActual															as IdSubsectorActual,
										  B.IdUnidadOrganigramaActual													as IdUnidadOrganigramaActual,
										  B.IdTipoDeUsuario																as IdTipoDeUsuario,
										  B.IdTipoRRHH																	as IdTipoRRHH,
										  B.IdFuncionDePuesto															as IdFuncionDePuesto,
										  B.IdGrupoProgramable															as IdGrupoProgramable,
										  C.IdCurso																		as IdCurso,
										  C.CodigoCurCodigo																as CodigoCurCodigo,
										  C.IdHabilitacion																as IdHabilitacion,
										  D.IdItemGrupoAero																as IdItemGrupoAero,
										  D.CodigoItemGrupoAero															as CodigoItemGrupoAero,
						  
										  D.IdSede																		as IdSede,
										  E.IdHabilitacionesGrupoAero													as IdHabilitacionesGrupoAero,
										  E.CodigoGrupoAero																as CodigoGrupoAero,
										  F.IdHabilitacionFuncion														as IdHabilitacionFuncion,
										  F.CodigoHabilitacionFuncion													as CodigoHabilitacionFuncion,
										  F.IdGrupoAero																	as IdGrupoAero,
										  F.IdFuncion																	as IdFuncion
						  

								  FROM [ModeloDeNegocio].[dbo].[MOD_EmpleadoCursos] A 



								  join [ModeloDeNegocio].dbo.[MOD_Usuarios] B on 
								  a.LegajoEmpleado = b.Legajo		
				  
								  join [ModeloDeNegocio].dbo.[MOD_Cursos] C on 
								  A.IdCurso = C.IdCurso

								  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesItemGrupoAero] D 
								  on B.idSedeActual = D.IdSede

								  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesGruposAero] E 
								  on D.IdGrupoAero =  E.IdHabilitacionesGrupoAero

								  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesFuncion] F on 
								  f.IdGrupoAero = E.IdHabilitacionesGrupoAero and f.IdFuncion = B.idPuestoActual and f.IdHabilitacion = C.IdHabilitacion

								  join [ModeloDeNegocio].dbo.[MOD_Habilitaciones] G on 
								  G.IdHabilitacion = C.IdHabilitacion

				union 


				SELECT  
						B.IdHabilitacion as IdEmpleadosCursos,
						B.CodigoEmpleado as CodigoCEM_IDCURSO,
						C.Legajo as LegajoEmpleado,
						'' as Fecha,---ver
						dateadd(day,-A.DiasAviso,B.FechaVencimiento) as FechaAviso,
						B.FechaVencimiento,
						 -DATEDIFF(DAY, B.FechaVencimiento, GETDATE())	as DiasVencidos,
						A.Descripcion as EstadoAprobacion,
						B.IdUsuario as IdUsuario,
						c.Usuario,
						C.idPuestoActual,
						C.IdGerenciaActual,
						C.IdAreaActual,
						C.IdSectorActual,
						C.IdSubSectorActual,
						C.IdUnidadOrganigramaActual,
						C.IdTipoDeUsuario,
						C.IdTipoRRHH,
						C.IdFuncionDePuesto,
						C.IdGrupoProgramable,
						E.IdCurso as IdCurso,
						E.CodigoCurCodigo as CodigoCurCodigo,
						B.IdHabilitacion,
						F.IdItemGrupoAero as IdItemGrupoAero,
						F.CodigoItemGrupoAero as CodigoIdItemGrupoAero,
						C.IdSedeActual as IdSede,
						F.IdGrupoAero	as IdHabilitacionesGrupoAero,
						F.IdGrupoAero	as CodigoGrupoAero,
						G.IdHabilitacionFuncion,
						G.CodigoHabilitacionFuncion,
						F.IdGrupoAero,
						G.IdFuncion
		
		


				FROM [ModeloDeNegocio].[dbo].[MOD_HabilitacionesVencimiento] B

				join MOD_Usuarios C
						On C.Idusuario = B.IdUsuario

				join MOD_Habilitaciones A
						On A.Idhabilitacion = B.Idhabilitacion


				left join ModeloDeNegocio.dbo.MOD_HabilitacionesItemGrupoAero F
						On  F.IdSede = C.idSedeActual
		

				left Join [ModeloDeNegocio].[dbo].[MOD_Cursos] E
						On B.IdHabilitacion = E.IdHabilitacion



				left Join ModeloDeNegocio.dbo.MOD_HabilitacionesFuncion G
					On  G.IdFuncion      = C.idPuestoActual AND
						G.IdHabilitacion = A.IdHabilitacion AND
						G.IdGrupoAero	 = F.IdGrupoAero

				where B.CodigoHabilitacion = 15 or B.CodigoHabilitacion = 23 or B.CodigoHabilitacion = 36) M





				) L

Right Join

			
			
			(SELECT  B.Legajo,
					 G.IdHabilitacion,
					 G.Descripcion
						  

							  FROM [ModeloDeNegocio].dbo.[MOD_Usuarios] B 			  
				  

							  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesItemGrupoAero] D 
							  on B.idSedeActual = D.IdSede

							  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesGruposAero] E 
							  on D.IdGrupoAero =  E.IdHabilitacionesGrupoAero

							  join [ModeloDeNegocio].dbo.[MOD_HabilitacionesFuncion] F on 
							  f.IdGrupoAero = E.IdHabilitacionesGrupoAero and F.IdFuncion = B.idPuestoActual 

							  join [ModeloDeNegocio].dbo.[MOD_Habilitaciones] G on 
							  G.IdHabilitacion = F.IdHabilitacion
			 WHERE F.Habilitado = 1	
			 
			 ) Z

		On Z.Legajo = L.LegajoEmpleado AND L.IdHabilitacion = Z.IdHabilitacion

WHERE	/* L.IdHabilitacion IS NULL  AND*/ (L.LegajoEmpleado = '25918' )




