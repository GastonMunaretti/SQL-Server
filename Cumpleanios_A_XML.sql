
Set	DateFormat ymd

Select	Legajo, ApellidoYNombre, Right( '0' + Convert(VarChar(2),Day(FechaNacimiento)),2) 'Día', Right( '0' + Convert(VarChar(2),Month(FechaNacimiento)),2) 'Mes'


FROM    dbo.Mod_Usuarios

Where	Activo = 1 And
		Convert(Datetime,
		Convert(Varchar(4), Year(GetDate())) + '-' +
		Right( '0' + Convert(varchar(2),Month(FechaNacimiento)),2) + '-' +
		Right( '0' + Convert(varchar(2),Day(FechaNacimiento)),2)) Between Getdate() - 4 And GetDate() + 3			  
		
FOR XML PATH('row'), elements , root('root')
go   
