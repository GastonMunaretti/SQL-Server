Select	A.PURCHID 'Pedido De Compra',
		A.ORDERACCOUNT 'Cuenta De Proveedor',
		A.PURCHNAME 'Nombre',
		A.INVOICEACCOUNT 'Cuenta de facturacion',
		A.DOCUMENTSTATE 'Estado de aprobacion',
		Case When A.DOCUMENTSTATE = 0  then 'Borrador'
			 When A.DOCUMENTSTATE = 10 then 'En revision'
			 When A.DOCUMENTSTATE = 20 then 'Rechazado'
			 When A.DOCUMENTSTATE = 30 then 'Aprobado'
			 When A.DOCUMENTSTATE = 50 then 'Finalizado'
			 When A.DOCUMENTSTATE = 40 then 'Confirmado'
		end AS 'Estado de aprobacion_' ,

		Case When A.PURCHSTATUS = 1 then 'Pedido abierto'
			 When A.PURCHSTATUS = 2 then 'Recibido'
			 When A.PURCHSTATUS = 3 then 'Facturado'
			 Else 'Cancelado'
		end AS 'Estado' 
		
from PURCHTABLE A


Select * from PURCHTABLE A