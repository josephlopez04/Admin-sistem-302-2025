# Script de instalación de servicios HTTP en Windows Server

Write-Host "=== Instalando IIS (Obligatorio) ==="
Install-WindowsFeature -name Web-Server -IncludeManagementTools
Start-Service W3SVC
Set-Service -Name W3SVC -StartupType Automatic
Write-Host "IIS ha sido instalado y activado en el puerto 80."

# Preguntar por el servicio adicional
Write-Host "`nSeleccione un servicio adicional para instalar:"
Write-Host "1.- Apache"
Write-Host "2.- Tomcat"
Write-Host "3.- Nginx"
Write-Host "4.- Ninguno"
$option = Read-Host "Ingrese el número de la opción"

if ($option -ne "4") {
    Write-Host "`nSeleccione la versión a instalar:"
    Write-Host "1.- Versión estable más reciente"
    Write-Host "2.- Versión en desarrollo (beta) más reciente"
    $versionOption = Read-Host "Ingrese el número de la opción"
}

if ($option -eq "1") {
    Write-Host "`n=== Instalando Apache ==="
    
    # Obtener la última versión de Apache desde Apache Lounge
    $apachePage = Invoke-WebRequest -Uri "https://www.apachelounge.com/download/" -UseBasicParsing
    $apacheVersions = ($apachePage.Links | Where-Object { $_.href -match "httpd-[\d.]+-win64-VS17.zip" }).href
    $apacheLatest = $apacheVersions | Select-Object -First 1
    $apacheUrl = "https://www.apachelounge.com/download/VS17/binaries/$apacheLatest"
    
    $apacheZip = "$env:TEMP\apache.zip"
    $apacheDir = "C:\Apache24"

    Invoke-WebRequest -Uri $apacheUrl -OutFile $apacheZip
    Expand-Archive -Path $apacheZip -DestinationPath $apacheDir -Force
    Write-Host "Apache instalado en $apacheDir"

    # Configurar puerto 8080 en httpd.conf
    $confFile = "$apacheDir\conf\httpd.conf"
    (Get-Content $confFile) -replace "Listen 80", "Listen 8080" | Set-Content $confFile
    Start-Process "$apacheDir\bin\httpd.exe" -ArgumentList "-k install"
    Start-Service Apache2.4
    Set-Service -Name Apache2.4 -StartupType Automatic
    Write-Host "Apache ha sido configurado en el puerto 8080."

} elseif ($option -eq "2") {
    Write-Host "`n=== Instalando Tomcat ==="
    
    # Obtener la última versión de Tomcat
    $tomcatBaseUrl = "https://downloads.apache.org/tomcat/tomcat-9/"
    $tomcatPage = Invoke-WebRequest -Uri $tomcatBaseUrl -UseBasicParsing
    $tomcatVersions = ($tomcatPage.Links | Where-Object { $_.href -match "v9\.[\d.]+/" }).href | Sort-Object -Descending
    $tomcatLatestVersion = $tomcatVersions | Select-Object -First 1 -replace "/", ""
    
    $tomcatUrl = "$tomcatBaseUrl$tomcatLatestVersion/bin/apache-tomcat-$tomcatLatestVersion-windows-x64.zip"
    
    $tomcatZip = "$env:TEMP\tomcat.zip"
    $tomcatDir = "C:\Tomcat"

    Invoke-WebRequest -Uri $tomcatUrl -OutFile $tomcatZip
    Expand-Archive -Path $tomcatZip -DestinationPath $tomcatDir -Force
    Write-Host "Tomcat instalado en $tomcatDir"

    # Configurar puerto 9090 en server.xml
    $serverXml = "$tomcatDir\conf\server.xml"
    (Get-Content $serverXml) -replace 'port="8080"', 'port="9090"' | Set-Content $serverXml

    New-Service -Name Tomcat9 -BinaryPathName "$tomcatDir\bin\startup.bat" -DisplayName "Apache Tomcat 9" -Description "Servidor Tomcat" -StartupType Automatic
    Start-Service Tomcat9
    Write-Host "Tomcat ha sido configurado en el puerto 9090."

} elseif ($option -eq "3") {
    Write-Host "`n=== Instalando Nginx ==="
    
    # Obtener la última versión de Nginx desde el sitio oficial
    $nginxPage = Invoke-WebRequest -Uri "https://nginx.org/en/download.html" -UseBasicParsing
    $nginxVersions = ($nginxPage.Links | Where-Object { $_.href -match "nginx-[\d.]+.zip" }).href
    $nginxLatest = $nginxVersions | Select-Object -First 1
    $nginxUrl = "https://nginx.org/download/$nginxLatest"
    
    $nginxZip = "$env:TEMP\nginx.zip"
    $nginxDir = "C:\Nginx"

    Invoke-WebRequest -Uri $nginxUrl -OutFile $nginxZip
    Expand-Archive -Path $nginxZip -DestinationPath $nginxDir -Force
    Write-Host "Nginx instalado en $nginxDir"

    # Configurar Nginx en el puerto 8081
    $confFile = "$nginxDir\conf\nginx.conf"
    (Get-Content $confFile) -replace 'listen       80;', 'listen       8081;' | Set-Content $confFile
    
    New-Service -Name Nginx -BinaryPathName "$nginxDir\nginx.exe" -DisplayName "Nginx" -Description "Servidor Nginx" -StartupType Automatic
    Start-Service Nginx
    Write-Host "Nginx ha sido configurado en el puerto 8081."
}

Write-Host "`n=== Instalación finalizada ==="
Write-Host "IIS está en el puerto 80."
if ($option -eq "1") { Write-Host "Apache está en el puerto 8080." }
if ($option -eq "2") { Write-Host "Tomcat está en el puerto 9090." }
if ($option -eq "3") { Write-Host "Nginx está en el puerto 8081." }
