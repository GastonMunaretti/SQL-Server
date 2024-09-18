

select b.name, a.* from sys.columns a join sys.objects b on a.object_id = b.object_id where a.name like '%Invoices%' order by 1 




select * From sys.columns a join sys.objects b on a.object_id = b.object_id where a.name like '%PURCHSTATUS%' order by 1 


Select * From PURCHLINEHISTORY

Select * From PURCHTABLEHISTORY


Select L.PURCHPRICE, L.PURCHMARKUP, L.MAXIMUMRETAILPRICE_IN ,L.* From VENDINVOICETRANS L


Select * from CUSTOMSVENDBOEJOUR_IN