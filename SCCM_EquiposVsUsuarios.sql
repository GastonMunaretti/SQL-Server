SELECT        A.Name0 [Nombre de red], 
			  B.Manufacturer0 Bios, 
			  B.SerialNumber0 Serie, 
			  C.Model0 Modelo,
			  A.User_Name0 Usuario


FROM            v_R_System A 
				INNER JOIN v_GS_PC_BIOS B ON 
					A.ResourceID = B.ResourceID 
				INNER JOIN v_GS_COMPUTER_SYSTEM C ON 
					A.ResourceID = C.ResourceID

WHERE        (A.Name0 LIKE 'IP%')



ORDER BY A.Name0