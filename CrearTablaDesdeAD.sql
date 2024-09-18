CREATE TABLE #ADData9(
    Login           NVARCHAR(256)
    ,CommonName     NVARCHAR(256)
    ,GivenName      NVARCHAR(256)
    ,FamilyName     NVARCHAR(256)   
    ,DisplayName    NVARCHAR(256)
    ,Title          NVARCHAR(256)
    ,Department     NVARCHAR(256)
    ,Location       NVARCHAR(256)
    ,Info           NVARCHAR(256)
    ,LastLogin      BIGINT
    ,flags          INT
    ,Email          NVARCHAR(256)
    ,Phone          NVARCHAR(256)   
    ,Mobile         NVARCHAR(256)
    ,Quickdial      NVARCHAR(256)
    , usnCreated    INT)

DECLARE @Query      VARCHAR (2000)
DECLARE @Filter     VARCHAR(200)
DECLARE @Rowcount   INT

select @Filter =''

WHILE ISNULL(@rowcount,901)  = 901 BEGIN

    SELECT @Query = '
    SELECT top 901
            Login           = SamAccountName
            , CommonName    = cn
            , GivenName
            , FamilyName    = sn    
            , DisplayName
            , Title
            , Department
            , Location      = physicalDeliveryOfficeName
            , Info
            , LastLogin     = CAST(LastLogon AS bigint)
            , flags         = CAST (UserAccountControl as int)
            , Email         = mail
            , Phone         = telephoneNumber
            , Mobile        = mobile
            , QuickDial     = Pager
            , usnCreated
        FROM OPENROWSET(''ADSDSOObject'', '''', ''
                SELECT cn, givenName, sn, userAccountControl, lastLogon, displayName, samaccountname, 
                title,  department, physicalDeliveryOfficeName, info, mail, telephoneNumber, mobile, pager, usncreated
            FROM ''''LDAP://192.168.3.8/DC=INTERCARGO,DC=COM,DC=AR'''' 
            WHERE objectClass=''''Person''''
            AND objectClass = ''''User''''
            ' + @filter + '
            ORDER BY usnCreated'')'             
    INSERT INTO #ADData9 EXEC (@Query) 
    SELECT @Rowcount = @@ROWCOUNT
    SELECT @Filter = 'and usnCreated > '+ LTRIM(STR((SELECT MAX(usnCreated) FROM #ADData9)))

END

SELECT LOGIN            
        , CommonName    
        , GivenName
        , FamilyName
        , DisplayName
        , Title         
        , Department
        , Location      
        , Email         
        , Phone         
        , QuickDial     
        , Mobile        
        , Info          
        , Disabled      = CASE WHEN CAST (flags AS INT) & 2 > 0 THEN 'Y' ELSE NULL END 
        , Locked        = CASE WHEN CAST (flags AS INT) & 16  > 0 THEN 'Y' ELSE NULL END 
        , NoPwdExpiry   = CASE WHEN CAST (flags AS INT) & 65536  > 0 THEN 'Y' ELSE NULL END 
        , LastLogin     = CASE WHEN ISNULL(CAST (LastLogin AS BIGINT),0) = 0 THEN NULL ELSE 
                            DATEADD(ms, (CAST (LastLogin AS BIGINT) / CAST(10000 AS BIGINT)) % 86400000,
                            DATEADD(day, CAST (LastLogin AS BIGINT) / CAST(864000000000 AS BIGINT) - 109207, 0)) END 
        , Type = CASE WHEN flags  & 512 = 512 THEN 'user' 
                    WHEN flags IS NULL THEN 'contact' 
                    WHEN flags & 4096 = 4096 THEN 'computer'
                    WHEN flags & 532480 = 532480 THEN 'computer (DC)' END
FROM #ADData9
where  GivenName is not null
ORDER BY Type

DROP TABLE #ADData9