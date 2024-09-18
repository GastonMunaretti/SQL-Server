


DECLARE @myXml varchar(1000)


SET @myXml= 'bcp "exec dbo.XML_Cumple" QUERYOUT "\\servidorbk\utilitarios\XML\finame.xml" -S ezesql -d ModeloDeNegocio -T -w -r' 

EXEC Master..xp_CmdShell @myXml