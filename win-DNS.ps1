param(
    [string]$Dominio,
    [string]$IPServidor
)

# Verificar que se ingresaron parámetros
if (-not $Dominio -or -not $IPServidor) {
    Write-Host "Uso: .\Instalar-DNS.ps1 -Dominio 'ejemplo.com' -IPServidor '192.168.1.100'"
    exit
}

Write-Host "Configurando servidor DNS para $Dominio en $IPServidor..."

# Instalar el rol de servidor DNS si no está instalado
$dnsInstalled = Get-WindowsFeature -Name DNS
if ($dnsInstalled.InstallState -ne "Installed") {
    Write-Host "Instalando el rol de servidor DNS..."
    Install-WindowsFeature -Name DNS -IncludeManagementTools
    Restart-Service DNS
} else {
    Write-Host "El rol de servidor DNS ya está instalado"
}

# 2️⃣ Crear la zona primaria para el dominio
Write-Host "Creando la zona primaria para $Dominio..."
Add-DnsServerPrimaryZone -Name $Dominio -ZoneFile "$Dominio.dns" -DynamicUpdate Secure

# Crear los registros A para el dominio y www
Write-Host "Creando registros DNS..."
Add-DnsServerResourceRecordA -Name "@" -ZoneName $Dominio -IPv4Address $IPServidor
Add-DnsServerResourceRecordA -Name "www" -ZoneName $Dominio -IPv4Address $IPServidor

# Configurar el servidor para que use su propia IP como DNS
Write-Host "Configurando el servidor para que use su propia IP como DNS..."
$interfaceIndex = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null }).InterfaceIndex
Set-DnsClientServerAddress -InterfaceIndex $interfaceIndex -ServerAddresses ("127.0.0.1", $IPServidor)

# Reiniciar el servicio DNS
Write-Host "Reiniciando el servicio DNS..."
Restart-Service DNS

#Limpiar caché DNS y registrar cambios
Write-Host "Limpiando caché y registrando cambios..."
ipconfig /flushdns
ipconfig /registerdns

# Pruebas de verificación
Write-Host "Verificando configuración..."
nslookup $Dominio 127.0.0.1
nslookup www.$Dominio 127.0.0.1

Write-Host "Configuración completa para $Dominio"
