# Solicitar informaciÃ³n al usuario
$ServerIP = Read-Host "Ingrese la IP del servidor DHCP (ejemplo: 192.168.0.34)"
$ScopeName = Read-Host "Ingrese el nombre del Ã¡mbito DHCP (ejemplo: Red Local)"
$ScopeID = Read-Host "Ingrese la direcciÃ³n de red (ejemplo: 192.168.0.0)"
$StartRange = Read-Host "Ingrese la primera IP del rango de asignaciÃ³n (ejemplo: 192.168.0.100)"
$EndRange = Read-Host "Ingrese la Ãºltima IP del rango de asignaciÃ³n (ejemplo: 192.168.0.200)"
$SubnetMask = Read-Host "Ingrese la mÃ¡scara de subred (ejemplo: 255.255.255.0)"
$Gateway = Read-Host "Ingrese la IP del gateway (ejemplo: 192.168.0.1)"
$DNSServer = Read-Host "Ingrese la IP del servidor DNS (ejemplo: 8.8.8.8 para Google)"
$DomainName = Read-Host "Ingrese el nombre del dominio DNS (ejemplo: miempresa.local)"

# Instalar el rol DHCP si no estÃ¡ instalado
Write-Host "Instalando el rol de DHCP..."
Install-WindowsFeature -Name DHCP -IncludeManagementTools

# Intentar autorizar el servidor en Active Directory
try {
    Write-Host "Autorizando el servidor DHCP en el Directorio Activo..."
    Add-DhcpServerInDC -DnsName $env:COMPUTERNAME -IPAddress $ServerIP
} catch {
    Write-Host "Advertencia: No se pudo autorizar en AD. Puede ignorar este mensaje si no usa dominio."
}

# Crear el Ã¡mbito DHCP
Write-Host "Creando el Ã¡mbito DHCP..."
Add-DhcpServerV4Scope -Name $ScopeName -StartRange $StartRange -EndRange $EndRange -SubnetMask $SubnetMask -State Active

# Configurar opciones del Ã¡mbito (Gateway, DNS, Dominio)
Write-Host "Configurando opciones de Ã¡mbito DHCP..."
Set-DhcpServerV4OptionValue -ScopeId $ScopeID -Router $Gateway -DnsServer $DNSServer -DnsDomain $DomainName

# Reiniciar el servicio DHCP
Write-Host "Reiniciando el servicio DHCP..."
Restart-Service DHCPServer

Write-Host "ConfiguraciÃ³n completada exitosamente. Puede verificar con los siguientes comandos:"
Write-Host "Get-DhcpServerV4Scope"
Write-Host "Get-DhcpServerV4OptionValue -ScopeId $ScopeID"
