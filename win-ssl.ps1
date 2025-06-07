# Función para asegurarse de que un directorio existe
function Ensure-DirectoryExists($path) {
    if (!(Test-Path -Path $path)) {
        New-Item -Path $path -ItemType Directory | Out-Null
    }
}

# Instalar IIS si no está instalado
function Install-IIS {
    Write-Output "Instalando IIS y herramientas necesarias..."
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    if (!(Get-Service -Name W3SVC -ErrorAction SilentlyContinue)) {
        Write-Output "Error: IIS no se instaló correctamente o el servicio W3SVC no está disponible."
        exit
    }
    Write-Output "IIS instalado exitosamente."
}

# Verificar estado del servicio IIS
function Verify-IIS {
    if (!(Get-Service -Name W3SVC -ErrorAction SilentlyContinue)) {
        Write-Output "Error: El servicio W3SVC no está disponible. Asegúrate de que IIS esté instalado correctamente."
        exit
    }
    Write-Output "El servicio IIS está disponible."
}

# Definir variables
$ServiceName = Read-Host "Ingrese el nombre del servicio (IIS, Apache, FTP)"
$CertFriendlyName = "$ServiceName SSL Cert"

# Solicitar puerto para el servicio
$Port = Read-Host "Ingrese el puerto donde desea instalar el servicio (por defecto: 443)"
if (-not $Port) { $Port = "443" }  # Valor predeterminado si no se especifica

# Crear el certificado SSL auto firmado
$Cert = New-SelfSignedCertificate -DnsName "localhost" -CertStoreLocation "Cert:\LocalMachine\My" -FriendlyName $CertFriendlyName
Write-Output "Certificado SSL generado para localhost"

# Exportar el certificado (opcional)
$ExportCert = Read-Host "¿Desea exportar el certificado? (s/n)"
if ($ExportCert -eq "s") {
    $CertPath = "C:\Certificados\localhost.pfx"
    Ensure-DirectoryExists -Path "C:\Certificados"
    $Password = ConvertTo-SecureString -String "TuContraseña" -Force -AsPlainText
    Export-PfxCertificate -Cert $Cert.PSPath -FilePath $CertPath -Password $Password
    Write-Output "Certificado exportado en $CertPath"
}

# Configurar el firewall para permitir conexiones al puerto seleccionado
New-NetFirewallRule -DisplayName "Permitir tráfico en puerto $Port" -Direction Inbound -LocalPort $Port -Protocol TCP -Action Allow
Write-Output "Regla de firewall creada para permitir conexiones en el puerto $Port."

# Configuración según el servicio
if ($ServiceName -eq "IIS") {
    Install-IIS
    Verify-IIS
    Import-Module WebAdministration

    # Verificar si el binding SSL ya existe para el puerto seleccionado
    $existingBindings = Get-ChildItem "IIS:\SslBindings" | Where-Object { $_.Port -eq $Port }
    if (!$existingBindings) {
        # Crear el binding SSL para IIS en el puerto seleccionado
        New-Item -Path "IIS:\SslBindings\0.0.0.0!$Port" -Thumbprint $Cert.Thumbprint -CertificateStoreName "My"
        Write-Output "Certificado SSL asignado a IIS en el puerto $Port."
    } else {
        Write-Output "Ya existe una configuración SSL para IIS en el puerto $Port."
    }

    # Reiniciar IIS para aplicar cambios
    Restart-Service W3SVC
}

if ($ServiceName -eq "Apache") {
    $ApacheConfigPath = "C:\Apache24\conf\httpd.conf"
    if (Test-Path $ApacheConfigPath) {
        Ensure-DirectoryExists -Path "C:\Certificados"
        $CertFile = "C:\Certificados\localhost.crt"
        $KeyFile = "C:\Certificados\localhost.key"

        if (!(Test-Path $CertFile) -or !(Test-Path $KeyFile)) {
            Write-Output "Error: Los archivos de certificado no se encuentran en C:\Certificados."
            exit
        }

        Add-Content $ApacheConfigPath "`nListen $Port"
        Add-Content $ApacheConfigPath "`nSSLEngine on"
        Add-Content $ApacheConfigPath "`nSSLCertificateFile $CertFile"
        Add-Content $ApacheConfigPath "`nSSLCertificateKeyFile $KeyFile"
        Write-Output "Configuración SSL agregada a Apache en el puerto $Port."

        # Reiniciar Apache para aplicar los cambios
        Start-Process "httpd" -ArgumentList "-k restart" -NoNewWindow -Wait
    } else {
        Write-Output "No se encontró la configuración de Apache."
    }
}

if ($ServiceName -eq "FTP") {
    Import-Module WebAdministration
    New-Item -Path "IIS:\SslBindings\0.0.0.0!$Port" -Thumbprint $Cert.Thumbprint -CertificateStoreName "My"
    Write-Output "Certificado SSL configurado para FTP en el puerto $Port."
}

Write-Output "Configuración completada."