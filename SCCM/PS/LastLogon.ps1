Get-ADUser -Filter * -Properties * | Select-Object Samaccountname, @{N='LastLogon'; E={[DateTime]::FromFileTime($_.LastLogon)}}


Get-ADcomputer -Filter * -properties * | sort lastlogondate | FT name, Lastlogondate, SamAccountName, Description



Get-ADComputer -Filter  {OperatingSystem -Like '*SERVER*' } -Properties lastlogondate,operatingsystem |select name,lastlogondate,operatingsystem

Get-ADComputer -Filter  {OperatingSystem -notLike '*SERVER*' } -Properties lastlogondate,operatingsystem |select name,lastlogondate,operatingsystem





##################################################################
##### usuarios que están inactivos por más de 90 días ############
##################################################################



$date1= (Get-Date).AddDays(-90)

Get-ADUser -Properties LastLogonDate -Filter {LastLogonDate -lt $date1} | ft GivenName, LastLogonDate, name




#######################################################################################
##### lista de todas las PC que han estado latentes durante más de 90 días ############
#######################################################################################

Get-ADComputer  -Properties LastLogonDate -Filter {LastLogonDate -lt $date1} | Sort LastLogonDate | FT Name, LastLogonDate -Autosize





#######################################################################################
##### últimos inicios de sesión de cada pc en el dominio ##############################
#######################################################################################

$dcs = Get-ADComputer -Filter { OperatingSystem -NotLike '*Server*' } -Properties OperatingSystem

$ListaPC=foreach($dc in $dcs) { 
    Get-ADComputer $dc.Name -Properties lastlogontimestamp | 
    Select-Object @{n="Computer";e={$_.Name}}, @{Name="Lastlogon"; Expression={[DateTime]::FromFileTime($_.lastLogonTimestamp)}}
}



$ListaPC



foreach($elemento in $ListaPC.Computer) { 
        
        if($elemento -ilike "IP*"){
                
                $elemento
        
        }
        else{
        
        
        }

}

