Set Dateformat ymd

Select	PK_Date As IdFecha,
		Date_Name As FechaNombre,
		Year As 'Calendario',
		Year_Name As NombreCalendario,
		Half_Year As Semestre,
		Half_Year_Name as SemestreNombre,
		Quarter As Trimestre,
		Quarter_Name As TrimestreNombre,
		Trimester As Cuatrimestre, 
		Trimester_Name As CuatrimestreNombre, 
		Month As Mes,
		Month_Name As MesNombre, 
		Week As Semana, 
		Week_Name As SemanaNombre, 
		Day_Of_Year As DiaCalendario,
		Day_Of_Year_Name As DiaCalendarioNombre,
		Day_Of_Half_Year As DiaSemestre,
		Day_Of_Half_Year_Name As DiaSemestreNombre,
		Day_Of_Quarter As DiaTrimestre,
		Day_Of_Quarter_Name As DiaTrimestreNombre,
		Day_Of_Trimester As DiaCuatrimestre,
		Day_Of_Trimester_Name As DiaCuatrimestreNombre,
		Day_Of_Month As DiaMes,
		Day_Of_Month_Name DiaMesNombre,
		Day_Of_Week As DiaSemana,
		Day_Of_Week_Name As DiaSemanaNombre,
		Week_Of_Year SemanaCalendario,
		Week_Of_Year_Name SemanaCalendarioNombre,
		Month_Of_Year As MesCalendario,
		Month_Of_Year_Name MesCalendarioNombre, 
		Month_Of_Half_Year As MesMedioCalendario,
		Month_Of_Half_Year_Name As MesMedioCalendarioNombre,
		Month_Of_Trimester As MesCuatrimestre,
		Month_Of_Trimester_Name As MesCuatrimestreNombre,
		Month_Of_Quarter As MesTrimestre,
		Month_Of_Quarter_Name MesTrimestreNombre,
		Quarter_Of_Year As TrimestreCalendario,
		Quarter_Of_Year_Name As TrimestreCalendarioNombre,
		Quarter_Of_Half_Year As TrimestreSemestre,
		Quarter_Of_Half_Year_Name As TrimestreSemestreNombre,
		Trimester_Of_Year As CuatrimestreCalendario,
		Trimester_Of_Year_Name As CuatrimestreCalendarioNombre,
		Half_Year_Of_Year As SemestreCalendario,
		Half_Year_Of_Year_Name As SemestreCalendarioNombre,
		Case When Month(PK_Date) =  12 And Day(PK_Date) <  21 Then Convert(Varchar(4),Year(PK_Date)) + '-12-01' 
			 When Month(PK_Date) =  12 And Day(PK_Date) >=  21 Then Convert(Varchar(4),Year(PK_Date) + 1) + '-01-01'
			 When Month(PK_Date) <> 12 And Day(PK_Date) <  21 Then Convert(Varchar(4),Year(PK_Date)) + '-' + Right('0' + Convert(Varchar(4),Month(PK_Date)),2) + '-01'
			 When Month(PK_Date) <> 12 And Day(PK_Date) >=  21 Then Convert(Varchar(4),Year(PK_Date)) + '-' + Convert(Varchar(4),Month(PK_Date) +1) + '-01'
		End As Periodo,
		GETDATE() As FecUltAct,
		SUSER_NAME() As UsuUltAct

--Into	D_TIEMPO
From	ModeloDeNegocio.dbo.MOD_Fecha
--set datefirst 1
--select datepart(dw,getdate())
--set datefirst 7
--select datepart(dw,getdate())
--select * from mod_fecha

