SELECT * FROM OpenQuery ( 
  "eze-dc1.intercargo.com.ar",  
  'SELECT
  userPrincipalName, sAMAccountName, sn, givenName, cn,  displayName
  FROM  ''LDAP://EZE-DC1/DC=INTERCARGO,DC=COM,DC=AR'' 
  WHERE objectClass =  ''User''
  ') AS tblADSI

WHERE userPrincipalName is not null
ORDER BY displayname asc