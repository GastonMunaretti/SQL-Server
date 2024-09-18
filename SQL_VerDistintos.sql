Use [ITCAXPROD]

Select distinct ITEMID from PURCHRFQCASELINE



Select distinct A.NAME from PURCHRFQCASELINE A
Select distinct ITEMNAME from PURCHRFQCASELINE


Select A.NAME, count(distinct A.NAME) from PURCHRFQCASELINE A 
group by A.NAME order by 2 desc
--where A.NAME = A.ITEMNAME 
order by A.NAME, A.ITEMNAME


