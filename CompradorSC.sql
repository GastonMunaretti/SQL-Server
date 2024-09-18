/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [TRACKINGID]
      ,[TRACKINGCONTEXT]
      ,[TRACKINGTYPE]
      ,[USER_]
      ,[ELEMENTID]
      ,[STEPID]
      ,[NAME]
      ,[WORKFLOWTRACKINGSTATUSTABLE]
      ,[WORKFLOWELEMENTTABLE]
      ,[WORKFLOWSTEPTABLE]
      ,[WORKFLOWPARALLELBRANCHTABLE]
      ,[WORKFLOWSUBWORKFLOW]
      ,[TRACKINGDATETIMETICKCOUNT]
      ,[CREATEDDATETIME]
      ,[RECVERSION]
      ,[PARTITION]
      ,[RECID]
  FROM [ITCAXPROD].[dbo].[WORKFLOWTRACKINGTABLE]


 select * 
 FROM [ITCAXPROD].[dbo].[PurchReqLine]


select 
			A.ITCPURCHREQUESTER,
			A.ORIGINATOR,
			* 
 FROM [ITCAXPROD].[dbo].[PURCHREQTABLE] A


  select * 
 FROM [ITCAXPROD].[dbo].[USERINFO] B
 where B.ID like '%fplaq%'
 order by B.RECID


  select * 
 FROM [ITCAXPROD].[dbo].[HCMWORKER]


  select * 
 FROM [ITCAXPROD].[dbo].[]


from hcm in db.HCMWORKERs
join r in db.DIRPARTYTABLEs 
	on hcm.PERSON equals r.RECID

where hcm.RECID == reqtable.ITCPURCHREQUESTER
select r.NAME




/**********************************************************************/

Select  
		W.IdSolicitudCompraAX,
		Z.NAME
from


(select IdSolicitudCompraAX from ezesql.dw.[dbo].[F_SOLICITUDCOMPRA]) W

Left Join
(
Select 
		B.NAME,
		C.PURCHREQID

from [dbo].[HCMWORKER] A
join [dbo].[DIRPARTYTABLE] B
	ON A.PERSON = B.RECID
join [dbo].[PURCHREQTABLE] C
	ON A.RECID = C.ITCPURCHREQUESTER
--Where C.PURCHREQID= 'SC-0007452'
) Z

ON W.IdSolicitudCompraAX =  Z.PURCHREQID collate Latin1_General_CI_AS


/************************************************************************************/


[SQLDATAAX].[ITCAXPROD].[dbo].[PURCHREQTABLE]


select * from [dbo].[PURCHREQTABLE]