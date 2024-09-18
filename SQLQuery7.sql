select * from DirPartyTable A
    join VendTable B
	On B.Party = A.RecId 
    join PurchReqLine C
	On C.VendAccount = B.AccountNum
   