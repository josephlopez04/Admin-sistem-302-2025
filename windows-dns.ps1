# Solicitar el dominio y las IPs necesarias
$Dominio = Read-Host "Ingrese el dominio "
$IPServidor = Read-Host "Ingrese la IP del servidor DNS (ejemplo: 192.168.100.67)"

Write-Host "Configurando el servidor DNS para el dominio $Dominio con IP del DNS $IPServidor..."

# Instalar el rol de DNS si no está instalado
Install-WindowsFeature -Name DNS -IncludeManagementTools

# Crear la zona DNS primaria
Add-DnsServerPrimaryZone -Name $Dominio -ZoneFile "$Dominio.dns" -DynamicUpdate None -PassThru

# Agregar un registro A para el dominio apuntando a la IP del servidor
Add-DnsServerResourceRecordA -ZoneName $Dominio -Name "@" -IPv4Address $IPServidor -TimeToLive 01:00:00

# Agregar un registro A para www (ejemplo: www.reprobados.com -> 192.168.100.67)
Add-DnsServerResourceRecordA -ZoneName $Dominio -Name "www" -IPv4Address $IPServidor -TimeToLive 01:00:00

# Reiniciar el servicio del servidor DNS
Restart-Service -Name DNS -Force

# Verificar que la configuración se haya realizado
Write-Host "Configuración completada. Puede verificar con los siguientes comandos:"
Write-Host "Get-DnsServerResourceRecord -ZoneName $Dominio"
Write-Host "nslookup $Dominio"
Write-Host "nslookup www.$Dominio"
