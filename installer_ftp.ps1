function Mostrar-Menu {
    Clear-Host
    Write-Host "  Menú de Configuración del Servidor FTP  "
    Write-Host "==============================="
    Write-Host "1) Instalar y configurar el Servidor FTP (incluye firewall y directorios)"
    Write-Host "2) Crear usuario"
    Write-Host "3) Eliminar usuario" 
    Write-Host "4) Salir"
}

function Instalar-FTP {
    Write-Host "Instalando y configurando el Servidor FTP..."
    $serviceName = "FTPSVC"
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if($null -ne $serviceName){
        Write-Host "El Servidor FTP ya está instalado."
    } else {
      Install-WindowsFeature Web-FTP-Server -IncludeManagementTools -ErrorAction SilentlyContinue
      if ($null -ne $service) {
        Write-Host "El servicio FTP ya esta instalado"
      }
      else{
        Write-Host "El servicio FTP no se instalo"
      }
    }

    # Crear carpetas
    New-Item -Path "C:\FTP\general" -ItemType Directory -Force
    New-Item -Path "C:\FTP\reprobados" -ItemType Directory -Force
    New-Item -Path "C:\FTP\recursadores" -ItemType Directory -Force

    # Crear grupos
    New-LocalGroup -Name "reprobados" -Description "Usuarios reprobados con acceso FTP" -ErrorAction SilentlyContinue
    New-LocalGroup -Name "recursadores" -Description "Usuarios recursadores con acceso FTP" -ErrorAction SilentlyContinue

    # Configurar permisos
    icacls "C:\FTP\general" /grant "IUSR:(OI)(CI)F" /T /C /Q
    icacls "C:\FTP\reprobados" /grant "reprobados:(OI)(CI)F" /T /C /Q
    icacls "C:\FTP\recursadores" /grant "recursadores:(OI)(CI)F" /T /C /Q

    
    Write-Host "Servidor FTP instalado y configurado correctamente." 
}

function Agregar-Usuario {
    Write-Host "Creando usuario FTP..." 
    do {
        $nombre = Read-Host "Ingrese el nombre del usuario (o 'salir' para terminar)"
        if ($nombre -eq "salir") { return }
        
        # Validar nombre
        if ($nombre -match "^[.\-_0-9]") {
            Write-Host "El nombre del usuario no puede comenzar con un punto, guion o número." 
        } else {
            $grupo = Read-Host "Ingrese el grupo (reprobados/recursadores)"
            if ($grupo -ne "reprobados" -and $grupo -ne "recursadores") {
                Write-Host "Grupo no válido. Intente de nuevo." -ForegroundColor Red
            } else {
                $password = Read-Host "Ingrese la contraseña para $nombre" -AsSecureString
                New-LocalUser -Name $nombre -Password $password -PasswordNeverExpires:$true -ErrorAction SilentlyContinue
                Add-LocalGroupMember -Group $grupo -Member $nombre -ErrorAction SilentlyContinue
                New-Item -Path "C:\FTP\$nombre" -ItemType Directory -Force
                Write-Host "Usuario $nombre agregado al grupo $grupo con carpeta propia."
            }
        }
    } while ($true)
}

function Eliminar-Usuario {
    Write-Host "Eliminando usuario FTP..." 
    $nombre = Read-Host "Ingrese el nombre del usuario a eliminar"
    Remove-LocalUser -Name $nombre -ErrorAction SilentlyContinue
    Remove-Item -Path "C:\FTP\$nombre" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Usuario eliminado correctamente." -ForegroundColor Green
}

# Bucle del menú
do {
    Mostrar-Menu
    $opcion = Read-Host "Seleccione una opción [1-4]"

    switch ($opcion) {
        "1" { Instalar-FTP }
        "2" { Agregar-Usuario }
        "3" { Eliminar-Usuario }
        "4" { Write-Host "Saliendo..."; exit }
        default { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
    }

    Pause
} while ($true)