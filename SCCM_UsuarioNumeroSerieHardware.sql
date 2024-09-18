SELECT        A.Name0,
			  A.User_Name0,
			  format(A.Last_Logon_Timestamp0,'yy/MM/dd, hh:mm'),
			  A.AD_Site_Name0,
			  B.Manufacturer0, 
			  B.SerialNumber0, 
			  C.Model0,
			 A.Build01,
			--CASE  A.Build01
			--	WHEN '6.1.7601' THEN 'WIN 7'
			--	WHEN '6.1.7601' THEN 'WIN 7'
			--	WHEN '6.3.9600' THEN 'WIN 8'
			--	WHEN '10.0.17134' THEN 'WIN 10'

			--END
			CASE WHEN A.Build01 like'10%' THEN 'WIN 10'
			     WHEN A.Build01 like'6.1%' THEN 'WIN 7'
				 WHEN A.Build01 like'6.2%' THEN 'WIN 8'
				 WHEN A.Build01 like'6.3%' THEN 'WIN 8.1'
			ELSE 'INDEFINIDO'
			END
			  


FROM            v_R_System A 
				INNER JOIN v_GS_PC_BIOS B ON 
					A.ResourceID = B.ResourceID 
				INNER JOIN v_GS_COMPUTER_SYSTEM C ON 
					A.ResourceID = C.ResourceID

WHERE        (A.Name0 LIKE 'IP%')



ORDER BY A.Name0