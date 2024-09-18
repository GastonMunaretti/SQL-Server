
select  A.[Dia de Semana] ,
		A.HoraProgramadaLlegadaAgrupada,
		a.*



from

(select	fechallegada, 
		IdTipoMovimiento, 
		IdAeropuerto, 
		IdCompañia, 
		IdTipoVuelo, 
		IdTramo, 
		HoraProgramadaLlegadaAgrupada, 
		count(distinct IdCertificacion) QProg, 
		0 QReal,
		CASE DATEPART(weekday, fechallegada)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miercoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sabado'
		END 'Dia de Semana'
from F_GESTIONRAMPA
where FechaLlegada is not null
group by fechallegada, IdTipoMovimiento, IdAeropuerto, IdCompañia, IdTipoVuelo, IdTramo, HoraProgramadaLlegadaAgrupada

union

Select	fechallegada, 
		IdTipoMovimiento, 
		IdAeropuerto, 
		IdCompañia, 
		IdTipoVuelo, 
		IdTramo, 
		HoraRealAgrupada, 
		0 ,
		count(distinct IdCertificacion) QReal,
		CASE DATEPART(weekday, fechallegada)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miercoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sabado'
		END 'Dia de Semana'
From F_GESTIONRAMPA
where FechaLlegada is not null

group by fechallegada, IdTipoMovimiento, IdAeropuerto, IdCompañia, IdTipoVuelo, IdTramo, HoraRealAgrupada) A

where  A.FechaLlegada between '2020-09-22' AND '2021-01-11' AND A.HoraProgramadaLlegadaAgrupada = '14:10' AND A.[Dia de Semana] = 'Lunes'


-----------------------------
------------------------------


select  --A.[Dia de Semana] ,
		--A.HoraProgramadaLlegadaAgrupada,
		 COUNT (A.HoraProgramadaLlegadaAgrupada) ,
		 SUM(QProg),
		 SUM(QReal)
		



from

(select	fechallegada, 
		IdTipoMovimiento, 
		IdAeropuerto, 
		IdCompañia, 
		IdTipoVuelo, 
		IdTramo, 
		HoraProgramadaLlegadaAgrupada, 
		count(distinct IdCertificacion) QProg, 
		0 QReal,
		CASE DATEPART(weekday, fechallegada)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miercoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sabado'
		END 'Dia de Semana'
from F_GESTIONRAMPA
where FechaLlegada is not null
group by fechallegada, IdTipoMovimiento, IdAeropuerto, IdCompañia, IdTipoVuelo, IdTramo, HoraProgramadaLlegadaAgrupada

union

Select	fechallegada, 
		IdTipoMovimiento, 
		IdAeropuerto, 
		IdCompañia, 
		IdTipoVuelo, 
		IdTramo, 
		HoraRealAgrupada, 
		0 ,
		count(distinct IdCertificacion) QReal,
		CASE DATEPART(weekday, fechallegada)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miercoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sabado'
		END 'Dia de Semana'
From F_GESTIONRAMPA
where FechaLlegada is not null

group by fechallegada, IdTipoMovimiento, IdAeropuerto, IdCompañia, IdTipoVuelo, IdTramo, HoraRealAgrupada) A

where  A.FechaLlegada between '2020-09-22' AND '2021-01-11' AND A.HoraProgramadaLlegadaAgrupada = '18:00' AND A.[Dia de Semana] = 'Lunes' AND A.IdTipoMovimiento = 1





---------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------




select  A.[Dia de Semana] ,
		A.HoraProgramadaLlegadaAgrupada



from

(select	fechallegada, 
		IdTipoMovimiento, 
		IdAeropuerto, 
		IdCompañia, 
		IdTipoVuelo, 
		IdTramo, 
		HoraProgramadaLlegadaAgrupada, 
		count(distinct IdCertificacion) QProg, 
		0 QReal,
		CASE DATEPART(weekday, fechallegada)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miercoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sabado'
		END 'Dia de Semana'
from F_GESTIONRAMPA
where FechaLlegada is not null
group by fechallegada, IdTipoMovimiento, IdAeropuerto, IdCompañia, IdTipoVuelo, IdTramo, HoraProgramadaLlegadaAgrupada

union

Select	fechallegada, 
		IdTipoMovimiento, 
		IdAeropuerto, 
		IdCompañia, 
		IdTipoVuelo, 
		IdTramo, 
		HoraRealAgrupada, 
		0 ,
		count(distinct IdCertificacion) QReal,
		CASE DATEPART(weekday, fechallegada)
			WHEN 1 THEN 'Domingo'
			WHEN 2 THEN 'Lunes'
			WHEN 3 THEN 'Martes'
			WHEN 4 THEN 'Miercoles'
			WHEN 5 THEN 'Jueves'
			WHEN 6 THEN 'Viernes'
			WHEN 7 THEN 'Sabado'
		END 'Dia de Semana'
From F_GESTIONRAMPA
where FechaLlegada is not null

group by fechallegada, IdTipoMovimiento, IdAeropuerto, IdCompañia, IdTipoVuelo, IdTramo, HoraRealAgrupada) A

where  A.FechaLlegada between '2020-07-01' AND '2021-09-17' AND A.HoraProgramadaLlegadaAgrupada = '04:00' AND A.[Dia de Semana] = 'Lunes'