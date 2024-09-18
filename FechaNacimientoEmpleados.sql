
Use [ModeloDeNegocio]

Set	DateFormat ymd

Select	Legajo, ApellidoYNombre, FechaNacimiento

FROM    dbo.Mod_Usuarios

Where	Activo = 1 And
		Convert(Datetime,
		Convert(Varchar(4), Year(GetDate())) + '-' +
		Right( '0' + Convert(varchar(2),Month(FechaNacimiento)),2) + '-' +
		Right( '0' + Convert(varchar(2),Day(FechaNacimiento)),2)) Between Getdate() - 7 And GetDate() 
Use [ModeloDeNegocio]

Set	DateFormat ymd

Select	Legajo, ApellidoYNombre, FechaNacimiento

FROM    dbo.Mod_Usuarios

Where	Activo = 1 And
		Convert(Datetime,
		Convert(Varchar(4), Year(GetDate())) + '-' +
		Right( '0' + Convert(varchar(2),Month(FechaNacimiento)),2) + '-' +
		Right( '0' + Convert(varchar(2),Day(FechaNacimiento)),2)) Between Getdate() - 7 And GetDate()			  


FOR XML RAW, elements, root

go  


