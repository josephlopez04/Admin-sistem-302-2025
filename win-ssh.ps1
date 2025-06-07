# Instalar OpenSSH Server
Write-Host "Instalando OpenSSH Server..."
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Iniciar el servicio de OpenSSH
Write-Host "Iniciando el servicio OpenSSH..." -ForegroundColor Green
Start-Service sshd
Set-Service -Name sshd -StartupType Automatic

# Agregar AllowUsers Invitado al archivo de configuración de OpenSSH
Write-Host "Configurando usuarios permitidos en OpenSSH..." -ForegroundColor Green
$sshConfigPath = "C:\ProgramData\ssh\sshd_config"
if (Test-Path $sshConfigPath) {
    Add-Content -Path $sshConfigPath -Value "AllowUsers Invitado"
    Write-Host "Se ha agregado 'AllowUsers Invitado' a sshd_config."
} else {
    Write-Host "El archivo sshd_config no se encontró. Asegúrate de que OpenSSH está instalado correctamente." -ForegroundColor Red
}

Write-Host "El servidor SSH está instalado y en ejecución."