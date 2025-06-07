#!/bin/bash

# Función para verificar si vsftpd ya está instalado
verificar_vsftpd() {
    if dpkg -l | grep -q vsftpd; then
        echo "VSFTPD ya está instalado."
        return 0
    else
        return 1
    fi
}

# Función para instalar y configurar vsftpd
instalar_vsftpd() {
    if verificar_vsftpd; then
        return
    fi

    # Configurar acceso anónimo
    echo "Configurando FTP con acceso anónimo..."
    mkdir -p /ftp/general
    chmod 755 /ftp/general

    # Configurar grupos de usuarios
    echo "Creando grupos de usuarios..."
    groupadd reprobados
    groupadd recursadores

    # Crear estructura de carpetas
    echo "Creando estructura de directorios..."
    mkdir -p /ftp/localuser
    mkdir -p /ftp/grupos/reprobados
    mkdir -p /ftp/grupos/recursadores
    chmod 755 /ftp
    chmod 770 /ftp/grupos/reprobados 
    chmod 770 /ftp/grupos/recursadores
    chown root:reprobados /ftp/grupos/reprobados
    chown root:recursadores /ftp/grupos/recursadores

    # Configurar vsftpd.conf
    echo "Configurando VSFTPD..."
    cat <<EOF > /etc/vsftpd.conf
listen=YES
anonymous_enable=YES
local_enable=YES
write_enable=YES
anon_root=/ftp/general
anon_upload_enable=NO
anon_mkdir_write_enable=NO
chroot_local_user=YES
allow_writeable_chroot=YES
user_sub_token=\$USER
local_root=/ftp/localuser/\$USER
user_config_dir=/etc/vsftpd_user_conf
EOF

    mkdir -p /etc/vsftpd_user_conf

    # Reiniciar servicio
    echo "Reiniciando VSFTPD..."
    systemctl restart vsftpd
    systemctl enable vsftpd
}

# Función para crear usuarios
crear_usuario() {
    while true; do
        read -p "Ingrese el nombre de usuario (o 'salir' para terminar): " USERNAME
        [[ "$USERNAME" == "salir" ]] && break
        read -p "Grupo (reprobados/recursadores): " GROUP

        if [[ "$GROUP" != "reprobados" && "$GROUP" != "recursadores" ]]; then
            echo "Grupo inválido. Inténtalo de nuevo."
            continue
        fi

        # Crear usuario y asignar grupo
        useradd -m -d /ftp/localuser/$USERNAME -s /bin/false -G $GROUP $USERNAME
        passwd $USERNAME
        usermod -aG $GROUP $USERNAME

        # Crear carpeta privada del usuario con su nombre
        mkdir -p /ftp/localuser/$USERNAME/$USERNAME
        chown $USERNAME:$GROUP /ftp/localuser/$USERNAME/$USERNAME
        chmod 770 /ftp/localuser/$USERNAME/$USERNAME

        # Crear configuración individual del usuario
        echo "local_root=/ftp/localuser/$USERNAME" > /etc/vsftpd_user_conf/$USERNAME

        # Montar la carpeta del grupo correcto
        mkdir -p /ftp/localuser/$USERNAME/grupo
        mount --bind /ftp/grupos/$GROUP /ftp/localuser/$USERNAME/grupo
        echo "/ftp/grupos/$GROUP /ftp/localuser/$USERNAME/grupo none bind 0 0" >> /etc/fstab

        # Montar la carpeta general dentro de la carpeta del usuario
        mkdir -p /ftp/localuser/$USERNAME/general
        mount --bind /ftp/general /ftp/localuser/$USERNAME/general
        echo "/ftp/general /ftp/localuser/$USERNAME/general none bind 0 0" >> /etc/fstab

        echo "Usuario $USERNAME creado en grupo $GROUP con acceso a general, su carpeta privada y la carpeta del grupo."
    done
}

# Función para eliminar usuarios
eliminar_usuario() {
    read -p "Ingrese el nombre del usuario a eliminar: " USERNAME
    
    if ! id "$USERNAME" &>/dev/null; then
        echo "El usuario $USERNAME no existe."
        return
    fi

    # Desmontar los directorios antes de eliminar
    umount /ftp/localuser/$USERNAME/general 2>/dev/null
    umount /ftp/localuser/$USERNAME/grupo 2>/dev/null

    userdel -r $USERNAME
    rm -rf /ftp/localuser/$USERNAME
    rm -f /etc/vsftpd_user_conf/$USERNAME
    sed -i "/\/ftp\/grupos\/.*\/ftp\/localuser\/$USERNAME\/grupo/d" /etc/fstab
    sed -i "/\/ftp\/general\/ftp\/localuser\/$USERNAME\/general/d" /etc/fstab
    echo "Usuario $USERNAME eliminado correctamente."
}

# Función para cambiar un usuario de grupo
cambiar_grupo_usuario() {
    read -p "Ingrese el nombre del usuario a modificar: " USERNAME
    if id "$USERNAME" &>/dev/null; then
        read -p "Nuevo grupo (reprobados/recursadores): " NEW_GROUP
        if [[ "$NEW_GROUP" != "reprobados" && "$NEW_GROUP" != "recursadores" ]]; then
            echo "Grupo inválido. Inténtalo de nuevo."
            return
        fi

        # Obtener grupo actual del usuario
        CURRENT_GROUP=$(id -nG "$USERNAME" | grep -Eo 'reprobados|recursadores')

        if [[ -z "$CURRENT_GROUP" ]]; then
            echo "El usuario no pertenece a un grupo válido."
            return
        fi

        # Cambiar grupo
        usermod -aG "$NEW_GROUP" "$USERNAME"

        # Desmontar grupo anterior y montar el nuevo
        umount /ftp/localuser/$USERNAME/grupo 2>/dev/null
        mount --bind /ftp/grupos/$NEW_GROUP /ftp/localuser/$USERNAME/grupo
        sed -i "/\/ftp\/grupos\/$CURRENT_GROUP \/ftp\/localuser\/$USERNAME\/grupo/d" /etc/fstab
        echo "/ftp/grupos/$NEW_GROUP /ftp/localuser/$USERNAME/grupo none bind 0 0" >> /etc/fstab

        echo "El usuario $USERNAME ha sido cambiado al grupo $NEW_GROUP correctamente."
    else
        echo "El usuario no existe."
    fi
}

# Menú principal
while true; do
    clear
    echo "Menú de Configuración del Servidor FTP"
    echo "1) Instalar y configurar el servidor FTP"
    echo "2) Crear usuario"
    echo "3) Eliminar usuario"
    echo "4) Cambiar usuario de grupo"
    echo "5) Salir"
    read -p "Seleccione una opción [1-5]: " OP
    case $OP in
        1) instalar_vsftpd ;;
        2) crear_usuario 
           systemctl restart vsftpd ;;
        3) eliminar_usuario 
           systemctl restart vsftpd ;;
        4) cambiar_grupo_usuario ;;
        5) exit 0 ;;
        *) echo "Opción inválida, intente de nuevo." ;;
    esac
    read -p "Presione Enter para continuar..."
done
