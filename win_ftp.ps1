function Mostrar-Menu {
    Clear-Host
    Write-Host "  Menú de Configuración del Servidor FTP  "
    Write-Host "========================================="
    Write-Host "1) Instalar y configurar el Servidor FTP"
    Write-Host "2) Crear usuario"
    Write-Host "3) Eliminar usuario"
    Write-Host "4) Cambiar grupo de usuario"
    Write-Host "5) Salir"
}

function Verificar-FTP {
    $serviceName = "FTPSVC"
    $service = Get-Service -Name $serviceName -ErrorAction SilentlyContinue
    if ($null -ne $service) {
        Write-Host "El Servidor FTP ya está instalado."
        return $true
    } else {
        return $false
    }
}

function Instalar-FTP {
    Write-Host "Instalando y configurando el Servidor FTP..."
    if (Verificar-FTP) { return }

    Install-WindowsFeature Web-FTP-Server -IncludeManagementTools 
    if (!(Verificar-FTP)) {
        Write-Host "Error: No se pudo instalar el servidor FTP."
        return
    }

    # Configurar firewall
    New-NetFirewallRule -Name "FTP" -DisplayName "FTP Server" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 21

    # Crear carpetas y asegurarse de que tengan permisos correctos
    $rutas = @("C:\FTP", "C:\FTP\LocalUser", "C:\FTP\LocalUser\Public", "C:\FTP\reprobados", "C:\FTP\recursadores")
    foreach ($ruta in $rutas) {
        if (!(Test-Path $ruta)) {
            New-Item -Path $ruta -ItemType Directory -Force
            Write-Host "Carpeta creada: $ruta"
        }
    }

    # Crear grupos si no existen
    $grupos = @("reprobados", "recursadores")
    foreach ($grupo in $grupos) {
        if (!(Get-LocalGroup -Name $grupo -ErrorAction SilentlyContinue)) {
            New-LocalGroup -Name $grupo -Description "Grupo FTP $grupo"
        }
    }

    # Configurar permisos correctamente
    icacls "C:\FTP\reprobados" /grant "reprobados:(OI)(CI)F"
    icacls "C:\FTP\recursadores" /grant "recursadores:(OI)(CI)F"

    Write-Host "Servidor FTP instalado y configurado correctamente." 
}

function Agregar-Usuario {
    Write-Host "Creando usuario FTP..."
    do {
        $nombre = Read-Host "Ingrese el nombre del usuario (o 'salir' para terminar)"
        if ($nombre -eq "salir") { return }
        
        # Validar nombre
        if ($nombre -match "^[._-]" -or $nombre -match "^[0-9]") {
            Write-Host "El nombre del usuario no puede comenzar con un punto, guion o número." -ForegroundColor Red
            continue
        }

        # Validar grupo
        $grupo = Read-Host "Ingrese el grupo (reprobados/recursadores)"
        if ($grupo -notmatch "^(reprobados|recursadores)$") {
            Write-Host "Grupo no válido. Intente de nuevo." -ForegroundColor Red
            continue
        }

        # Crear usuario
        $password = Read-Host "Ingrese la contraseña para $nombre" -AsSecureString
        New-LocalUser -Name $nombre -Password $password -PasswordNeverExpires:$true -ErrorAction SilentlyContinue
        Add-LocalGroupMember -Group $grupo -Member $nombre -ErrorAction SilentlyContinue

        # Crear carpeta en el directorio correspondiente
        $directorio = "C:\FTP\$grupo\$nombre"
        if (!(Test-Path $directorio)) {
            New-Item -Path $directorio -ItemType Directory -Force
            icacls $directorio /grant "$nombre:(OI)(CI)F"
            Write-Host "Carpeta asignada a $nombre en $directorio"
        }

        Write-Host "Usuario $nombre agregado al grupo $grupo."
    } while ($true)
}

function Eliminar-Usuario {
    Write-Host "Eliminando usuario FTP..."
    $nombre = Read-Host "Ingrese el nombre del usuario a eliminar"
    
    # Eliminar usuario
    Remove-LocalUser -Name $nombre -ErrorAction SilentlyContinue
    
    # Eliminar carpeta del usuario
    $carpetas = @("C:\FTP\reprobados\$nombre", "C:\FTP\recursadores\$nombre")
    foreach ($carpeta in $carpetas) {
        if (Test-Path $carpeta) {
            Remove-Item -Path $carpeta -Recurse -Force
            Write-Host "Carpeta eliminada: $carpeta"
        }
    }

    Write-Host "Usuario eliminado correctamente." -ForegroundColor Green
}

function Cambiar-GrupoUsuario {
    Write-Host "Cambiando grupo de un usuario..."
    $nombre = Read-Host "Ingrese el nombre del usuario"

    # Verificar si el usuario existe
    if (!(Get-LocalUser -Name $nombre -ErrorAction SilentlyContinue)) {
        Write-Host "El usuario no existe." -ForegroundColor Red
        return
    }

    # Seleccionar nuevo grupo
    $nuevoGrupo = Read-Host "Ingrese el nuevo grupo (reprobados/recursadores)"
    if ($nuevoGrupo -notmatch "^(reprobados|recursadores)$") {
        Write-Host "Grupo no válido. Intente de nuevo." -ForegroundColor Red
        return
    }

    # Remover usuario de cualquier grupo anterior
    $grupos = @("reprobados", "recursadores")
    foreach ($grupo in $grupos) {
        Remove-LocalGroupMember -Group $grupo -Member $nombre -ErrorAction SilentlyContinue
    }

    # Agregar al nuevo grupo
    Add-LocalGroupMember -Group $nuevoGrupo -Member $nombre
    Write-Host "El usuario $nombre ahora pertenece al grupo $nuevoGrupo." -ForegroundColor Green

    # Mover directorio del usuario
    $directorioAntiguo = "C:\FTP\reprobados\$nombre"
    $directorioNuevo = "C:\FTP\$nuevoGrupo\$nombre"

    if (Test-Path $directorioAntiguo) {
        Move-Item -Path $directorioAntiguo -Destination $directorioNuevo -Force
        Write-Host "Carpeta movida a: $directorioNuevo"
    } else {
        Write-Host "No se encontró la carpeta anterior, creando nueva..."
        New-Item -Path $directorioNuevo -ItemType Directory -Force
    }

    icacls $directorioNuevo /grant "$nombre:(OI)(CI)F"
}

# Bucle del menú
do {
    Mostrar-Menu
    $opcion = Read-Host "Seleccione una opción [1-5]"

    switch ($opcion) {
        "1" { Instalar-FTP }
        "2" { Agregar-Usuario }
        "3" { Eliminar-Usuario }
        "4" { Cambiar-GrupoUsuario }
        "5" { Write-Host "Saliendo..."; exit }
        default { Write-Host "Opción no válida. Intente de nuevo." -ForegroundColor Red }
    }

    Pause
} while ($true)
