SELECT	ViewName, 
		Type 

from v_SchemaViews 
order by 2


SELECT * 
from v_GroupMap



/**************************************************************************/
/**************************************************************************/
/**************************************************************************/

SELECT
		SYS.Name0 AS Name,
		OS.Caption0 AS OS,
		CS.Manufacturer0 AS Manufacturer,
		CS.Model0 AS Model,
		CPU.Name0 AS CPUName
	
FROM
		v_R_System AS SYS

JOIN    v_GS_OPERATING_SYSTEM OS ON OS.ResourceID = SYS.ResourceID
JOIN	v_GS_COMPUTER_SYSTEM CS ON CS.ResourceID = SYS.ResourceID
JOIN	v_GS_PROCESSOR CPU ON CPU.ResourceID = SYS.ResourceID

Order By 1,2,3,4






/***********************************************************************************/
/***********************************************************************************/
/***********************************************************************************/


SELECT
		SYS.Name0 AS Name,
		OS.Caption0 AS OS,
		CS.Manufacturer0 AS Manufacturer,
		CS.Model0 AS Model,
		CPU.Name0 AS CPUName
	
FROM
		v_R_System AS SYS

JOIN    v_GS_OPERATING_SYSTEM OS ON OS.ResourceID = SYS.ResourceID
JOIN	v_GS_COMPUTER_SYSTEM CS ON CS.ResourceID = SYS.ResourceID
JOIN	v_GS_PROCESSOR CPU ON CPU.ResourceID = SYS.ResourceID




/**************************************************************************/
/**************************************************************************/
/**************************************************************************/

SELECT	v_R_System.Name0,v_R_System.Operating_System_Name_and0, 
		v_R_User.User_Name0,v_R_User.Name0,
		v_R_User.Mail0, v_GS_COMPUTER_SYSTEM.Model0

FROM v_R_System
	INNER JOIN v_R_User 
		ON v_R_User.User_Name0 = v_R_System.User_Name0
	INNER JOIN v_GS_COMPUTER_SYSTEM 
		ON v_GS_COMPUTER_SYSTEM.ResourceID = v_R_System.ResourceId






SELECT	v_R_User.ResourceID, 
		User_Principal_Name0, 
		v_GS_COMPUTER_SYSTEM.Name0

FROM v_GS_COMPUTER_SYSTEM
LEFT JOIN v_R_User 
	ON v_GS_COMPUTER_SYSTEM.UserName0 = v_R_User.Unique_User_Name0
Order by 2




SELECT sys.Netbios_Name0, TopConsoleUser0
FROM v_R_System sys
LEFT OUTER JOIN v_GS_SYSTEM_CONSOLE_USAGE_MAXGROUP um
ON um.ResourceID = sys.ResourceID
WHERE TopConsoleUser0 IS NOT NULL
ORDER BY sys.Netbios_Name0

/****************************************************************************************/
/******************* Computers that have 30+ days old hardware information **************/
/****************************************************************************************/

SELECT
		a.ResourceID,
		a.Netbios_name0 AS[Name],
		b.LastHWScan
FROM
v_R_System a
INNER JOIN v_GS_WORKSTATION_STATUS b
	ON a.ResourceID = b.ResourceID

WHERE b.LastHWScan <= Dateadd(day, -30, getdate())




/****************************************************************************************/
/******************* All Physical Systems Server ****************************************/
/****************************************************************************************/

SELECT
		a.ResourceID,
		a.ResourceType,
		a.Name0,
		a.SMS_Unique_Identifier0,
		a.Resource_Domain_OR_Workgr0,
		a.Client0

FROM	v_R_System a
INNER JOIN v_GS_SYSTEM_ENCLOSURE b
	ON	b.ResourceID = a.ResourceId

WHERE b.ChassisTypes0 = '23' or b.ChassisTypes0 = '17'





/****************************************************************************************/
/*******************  Report to list of all users laptops  ******************************/
/****************************************************************************************/

SELECT DISTINCT
dbo.v_R_System.Name0 AS [Computer Name],
dbo.v_R_System.User_Name0 AS [User Name], dbo.v_R_System.User_Domain0 AS [Domain Name],
dbo.v_GS_SYSTEM_ENCLOSURE.Manufacturer0 AS Manufacturer, dbo.v_GS_COMPUTER_SYSTEM.Model0 AS Model,
dbo.v_GS_SYSTEM_ENCLOSURE.SerialNumber0 AS [Serial Number], dbo.v_GS_SYSTEM.SystemRole0 AS [System OS Type],
dbo.v_GS_SYSTEM.SystemType0 AS [System Type]
FROM
dbo.v_GS_SYSTEM_ENCLOSURE
INNER JOIN
dbo.v_R_System ON dbo.v_GS_SYSTEM_ENCLOSURE.ResourceID = dbo.v_R_System.ResourceID INNER JOIN
dbo.v_GS_SYSTEM ON dbo.v_R_System.ResourceID = dbo.v_GS_SYSTEM.ResourceID
INNER JOIN
dbo.v_GS_COMPUTER_SYSTEM
ON dbo.v_GS_SYSTEM.ResourceID = dbo.v_GS_COMPUTER_SYSTEM.ResourceID
WHERE
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '8') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '9') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '10') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '11') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '12') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '14') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '18') OR
(dbo.v_GS_SYSTEM_ENCLOSURE.ChassisTypes0 = '21')









/****************************************************************************************/
/*******************  Last Logon  *******************************************************/
/****************************************************************************************/



select	A.Name0,
		A.User_Name0,
		A.Last_Logon_Timestamp0

from v_R_System A

where A.Name0 like '%IP%' 

order by A.Last_Logon_Timestamp0 desc



/****************************************************************************************/
/*******************  Last Logon > 45 ***************************************************/
/****************************************************************************************/

select	A.ResourceID,
		A.ResourceType,
		A.Name0,
		A.User_Name0,
		A.SMS_Unique_Identifier0,
		A.Resource_Domain_OR_Workgr0,
		A.Client0

from v_R_System AS A

where DATEDIFF(dd,A.Last_Logon_Timestamp0,GetDate()) > 45 and  A.Name0 LIKE 'IP%'

order by 3




select	distinct ad.AgentName [Discovery Method],
		count(*) [Discovered Clients]

from v_R_System sys
inner join v_AgentDiscoveries AD 
	on AD.ResourceId=sys.resourceid	and DATEDIFF(dd,AD.AgentTime,GetDate()) >30

group by ad.AgentName

order by ad.AgentName




SELECT DISTINCT
dbo.v_R_System.Netbios_Name0 as [Machine Name],
dbo.v_R_System.User_Name0 as [User Name],
dbo.v_R_System.AD_Site_Name0 as [AD Site],
dbo.v_R_System.User_Domain0 as [Domain],
dbo.v_GS_OPERATING_SYSTEM.Caption0 as [OS Name],
dbo.v_GS_OPERATING_SYSTEM.CSDVersion0 as [SP Name],
dbo.v_R_System.Operating_System_Name_and0 as [OS NT Version],
dbo.v_GS_OPERATING_SYSTEM.BuildNumber0 as [Build Number]
FROM
dbo.v_R_System
INNER JOIN
dbo.v_GS_OPERATING_SYSTEM
ON
dbo.v_R_System.ResourceID = dbo.v_GS_OPERATING_SYSTEM.ResourceID
 