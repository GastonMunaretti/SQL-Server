

SELECT  A.Name0				AS [Nombre Equipo],
		A.UserName0			AS Usuario,
		A.SystemType0		AS Sistema,
		A.Manufacturer0		AS Hardware,
		B.ARPDisplayName0	AS Software,
		B.ProductName0		AS [Nombre de software],
		B.ProductVersion0	AS [Version de software]

FROM   v_GS_COMPUTER_SYSTEM A
JOIN v_GS_INSTALLED_SOFTWARE B
	ON A.ResourceID = B.ResourceID

WHERE	A.Name0 LIKE '%IP%' AND
		B.ProductName0 NOT IN (	'Microsoft Visual C++ 2015-2019 Redistributable (x86) - 14.28.29914',
								'Microsoft Visual C++ 2019 X86 Additional Runtime - 14.28.29914',
								'Microsoft Visual C++ 2015-2019 Redistributable (x64) - 14.28.29914',
								'Microsoft Visual C++ 2019 X64 Additional Runtime - 14.28.29914',
								'Catalyst Control Center Next Localization TR',
								'CCC Help Chinese Standard',
								'CCC Help Chinese Traditional',
								'CCC Help Czech',
								'CCC Help English',
								'CCC Help French',
								'Eines de correcció del Microsoft Office 2013: català',
								'Intel® Trusted Connect Service Client',
								'Intellisense Lang Pack Mobile Extension SDK 10.0.14393.0',
								'IntelliTraceProfilerProxy',
								'ISS_Drivers_x64',
								'iVMS-4200(V2.8.1.4_ML)',
								
								'Configuration Manager Client',
								'Realtek Audio COM Components',
								'Actualización de NVIDIA 1.10.8',
								'AD Replication Status Tool 1.0',
								'Microsoft Policy Platform',
								'Visual C++ IDE x64 Package',
								'Visual C++ IDE Windows Express Plus Package',
								'Visual C++ IDE Professional Plus Resource Package',
								'Visual C++ Library ATL ARM Package',
								'Visual C++ Library ATL Headers Package',
								'Visual C++ Library ATL Source Package',
								'Visual C++ Library ATL X64 Package',
								'Visual C++ Library CRT Appx Package',
								'Visual C++ Library CRT Appx Resource Package',
								'Visual C++ Library CRT ARM Desktop Package',
								'Visual C++ Library CRT ARM OneCore For Desktop Package',
								'Visual C++ Library CRT ARM Redist Package',
								'Visual C++ Library CRT ARM Store Package',
								'Visual C++ Library CRT ARM64 Appx Package',
								'Visual C++ Library CRT Desktop Appx Package',
								'Visual C++ Library CRT Redist Resource Package',
								'Visual C++ Library CRT Source Package',
								'Visual C++ Library CRT X64 Desktop Package',
								'Visual C++ Library CRT X64 OneCore For Desktop Package',
								'HP Support Assistant',
								'HP Support Solutions Framework',
								'HP Sure Connect',
								'HP System Default Settings',
								'HP Unified IO',
								'HP Update',
								'HP USB-C Mini Dock versión 0.2.8.0518',
								'HPDXP',
								'hppFaxDrvM1530',
								'hppFaxDrvM375M475',
								'hppFaxUtilityM1530',
								'hppLaserJetService',
								'hppM375_M475LaserJetService',
								'hppM1530LaserJetService',
								'hppM41426427LaserJetService',
								'hppP1100P1560P1600SeriesLaserJetService',
								'HPProductAssistant',
								'hppSendFaxM1530',
								'hppTLBXFXM1530',
								'hppToolboxProxyM375',
								'hppusgM1130M1210Series',
								'hppusgP1100P1560P1600Series',
								'HPSSupply',
								'hpStatusAlerts',
								'I.R.I.S. OCR',
								'I.V.A.',
								'icecap_collection_neutral',
								'icecap_collection_neutral',
								'icecap_collectionresources',
								'icecap_collectionresourcesx64',
								'IDE Tools for Windows 10',
								'IDE Tools for Windows 10 - ENU',
								'IDE Tools for Windows 10',
								'IETester v0.4.1 (remove only)',
								'IIS 10.0 Express',
								'IIS 8.0 Express',
								'IIS Express Application Compatibility Database for x64',
								'IIS URL Rewrite Module 2',
								'iLO 3/4 Channel Interface Driver',
								'Языковой пакет Microsoft ReportViewer 2010 Redistributable - rus',
								'Microsoft Visual Studio 2015 Update 3 Diagnostic Tools - amd64',
								'Microsoft Windows 10 Pro',
								'Microsoft Windows Server 2012 R2 Standard',
								'Microsoft Windows Server 2012 R2 Datacenter',
								'Microsoft Windows Server 2016 Datacenter',
								'Microsoft Windows Server 2016 Standard',
								'Microsoft_VC80_ATL_x86',
								'Microsoft_VC80_ATL_x86_x64',
								'MiniTool Partition Wizard Free 11',
								'Motorola Device Software Update',
								'Motorola Mobile Drivers Installation 5.9.0',
								'MrvlUsgTracking',
								'MPM',
								'MSI Development Tools',
								'MSBuild/NuGet Integration 14.0 (x86)',
								'MSVCRT',
								'MSVCRT_amd64',
								'MSVCRT110',
								'MSXML 4.0 SP3 Parser',
								'MSXML 4.0 SP3 Parser (KB2721691)',
								'MSXML 4.0 SP3 Parser (KB2721691)',
								'MSXML 4.0 SP3 Parser (KB2758694)',
								'Multi-Device Hybrid Apps using C# - Templates - ENU',
								'NetInfo',
								'ACA & MEP 2021 Object Enabler',
								'Active Directory Rights Management Services Client 2.1',
								'Языковой пакет Microsoft ReportViewer 2010 Redistributable - rus',
								'Языковой пакет Microsoft ReportViewer 2010 Redistributable - rus',
								'Microsoft Visual C++ 2005 Redistributable (x64)',
								'Microsoft Visual C++ 2008 Redistributable - x64 9.0.21022',
								'Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161',
								'ZKOnline SDK 2.3.4.0',
								'32 Bit HP CIO Components Installer',
								'@BIOS',
								'64 Bit HP CIO Components Installer',
								'${{arpDisplayName}}',
								'%SQL_PRODUCT_SHORT_NAME% Data Tools - BI for Visual Studio 2013',
								'7-Zip 16.02 (x64 edition)',
								'7-Zip 16.04 (x64)',
								'8500A909_eDocs',
								'Active Directory Authentication Library for SQL Server',
								'Active Directory Authentication Library for SQL Server (x86)',
								'ActKey',
								'Microsoft Visual C++ 2013 Redistributable (x64) - 12.0.40660',
								'Visual C++ Library CRT X64 Redist Package',
								'Active Directory Rights Management Services Client 2.0',
								'Языковой пакет для поддержки размещения набора средств Microsoft Visual Studio Tools для работы с приложениями 2012 (x64) - RUS',
								'%SQL_PRODUCT_SHORT_NAME% SSIS 64Bit For SSDTBI',
								'Microsoft Visual C++ 2005 Redistributable',
								'Microsoft Visual C++  x86 Libraries',
								'Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.17',
								'Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.4148')


			AND B.ProductName0 NOT LIKE '%java%' 
			AND B.ProductName0 NOT LIKE '%WinRT Intellisense%'   
			AND B.ProductName0 NOT LIKE '%Языковой пакет%' 
			AND B.ProductName0 NOT LIKE '%Microsoft Visual C++%'  
			AND B.ProductName0 NOT LIKE '%Microsoft .NET Framework%'      
			AND B.ProductName0 NOT LIKE '%Visual C++%'     
			AND B.ProductName0 NOT LIKE '%Microsoft ReportViewer%' 
			AND B.ProductName0 NOT LIKE '%Workflow Manager%'   
			AND B.ProductName0 NOT LIKE '%Intel(R)%'         
			AND B.ProductName0 NOT LIKE '%Asistente%'  
			AND B.ProductName0 NOT LIKE '%Catalyst%' 
			AND B.ProductName0 NOT LIKE'%CCC%'
			AND B.ProductName0 NOT LIKE'%ccc%'  
			AND B.ProductName0 NOT LIKE'%Counter%'   
			AND B.ProductName0 NOT LIKE'%Crystal%'
			AND B.ProductName0 NOT LIKE'%Dell%'   
			AND B.ProductName0 NOT LIKE'%DiagnosticsHub%'   
			AND B.ProductName0 NOT LIKE'%Eines%'  
			AND B.ProductName0 NOT LIKE'%icecap%'  
			AND B.ProductName0 NOT LIKE'%Insyde%'
			AND B.ProductName0 NOT LIKE'%Integration%'
			AND B.ProductName0 NOT LIKE'%Intel%'
			AND B.ProductName0 NOT LIKE'%Kits%'
			AND B.ProductName0 NOT LIKE'%Maxx%' 
			AND B.ProductName0 NOT LIKE'%Microsoft .NET%'  
			AND B.ProductName0 NOT LIKE'%Visual F#%'



order by 6






select * from v_GS_COMPUTER_SYSTEM A
select * from v_GS_INSTALLED_SOFTWARE


/**** contar autocad ****/



SELECT  A.Name0	AS [Nombre Equipo],
		RANK() OVER  (ORDER BY A.Name0 DESC) 

FROM   v_GS_COMPUTER_SYSTEM A
JOIN v_GS_INSTALLED_SOFTWARE B
	ON A.ResourceID = B.ResourceID


WHERE
  B.ProductName0 like '%autocad%'

Group by A.Name0
