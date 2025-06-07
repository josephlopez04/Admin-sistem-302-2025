#!/bin/bash

function verificar_paquetes {
    echo -e "\n Verificando componentes..."

    if dpkg -l | grep -q postfix; then
        echo " Postfix ya se encuentra instalado."
    else
        echo " Instalando Postfix..."
        sudo apt-get install -y postfix
    fi

    if dpkg -l | grep -q dovecot-core; then
        echo " Dovecot ya está presente."
    else
        echo " Instalando Dovecot..."
        sudo apt-get install -y dovecot-imapd dovecot-pop3d
    fi
}

function crear_dominio {
    echo -e "\n Configuración del dominio..."
    while true; do
        read -p "Ingresa el nombre del dominio: " DOMINIO
        if [[ -z "$DOMINIO" || "$DOMINIO" =~ \  ]]; then
            echo "El nombre de dominio no debe estar vacío ni contener espacios."
        else
            break
        fi
    done

    if grep -q "$DOMINIO" /etc/postfix/main.cf; then
        echo "El dominio '$DOMINIO' ya está registrado en Postfix."
    else
        echo "Añadiendo '$DOMINIO' a la configuración de Postfix..."
        sudo sed -i "/^mydestination/ s/$/, $DOMINIO/" /etc/postfix/main.cf
        sudo systemctl reload postfix
        echo "Postfix recargado con el nuevo dominio."
    fi
}

function crear_usuario_correo {
    echo -e "\n Configuración de usuario de correo..."

    while true; do
        read -p "Nombre de usuario: " USUARIO
        if [[ -z "$USUARIO" || "$USUARIO" =~ \  ]]; then
            echo "El nombre no puede estar vacío ni contener espacios."
        else
            break
        fi
    done

    read -s -p "Contraseña: " CONTRASENA
    echo

    if id "$USUARIO" &>/dev/null; then
        echo "El usuario '$USUARIO' ya existe."
    else
        sudo useradd -m -s /bin/false "$USUARIO"
        echo "$USUARIO:$CONTRASENA" | sudo chpasswd
        echo " Usuario '$USUARIO' creado correctamente."
    fi

    BUZON="/var/mail/$USUARIO"
    if [ ! -f "$BUZON" ]; then
        sudo touch "$BUZON"
        sudo chown "$USUARIO":mail "$BUZON"
        sudo chmod 644 "$BUZON"
        echo " Buzón de correo creado para '$USUARIO'."
    else
        echo "El buzón ya existe para '$USUARIO'."
    fi
}

function instalar_Smail {
    echo -e "\n Configurando SquirrelMail (webmail)..."
    echo "Se instalarán Apache, PHP y dependencias necesarias."

    sudo apt install software-properties-common -y
    sudo add-apt-repository ppa:ondrej/php -y
    sudo apt update
    sudo apt install php7.4 libapache2-mod-php7.4 php-mysql -y

    while true; do
        read -p "Dominio para acceso web (sin espacios): " WEB_DOMINIO
        if [[ -z "$WEB_DOMINIO" || "$WEB_DOMINIO" =~ \  ]]; then
            echo "Dominio inválido."
        else
            break
        fi
    done

    RUTA_INSTALACION="/var/www/html/squirrelmail"
    DATA_DIR="$RUTA_INSTALACION/data"
    ADJUNTOS_DIR="$RUTA_INSTALACION/attach"

    cd /var/www/html/
    wget -O squirrelmail.zip "https://sourceforge.net/projects/squirrelmail/files/stable/1.4.22/squirrelmail-webmail-1.4.22.zip/download" -q

    if [ $? -ne 0 ]; then
        echo "Error al descargar SquirrelMail."
        return 1
    fi

    unzip -q squirrelmail.zip
    sudo mv squirrelmail-webmail-1.4.22 squirrelmail
    rm squirrelmail.zip

    sudo chown -R www-data:www-data "$RUTA_INSTALACION"
    sudo chmod -R 755 "$RUTA_INSTALACION"

    CONFIG="$RUTA_INSTALACION/config/config_default.php"
    if [ ! -f "$CONFIG" ]; then
        echo "No se encontró el archivo de configuración. Revisa la instalación."
        return 1
    fi

    sudo sed -i "s/^\$domain.*/\$domain = '$WEB_DOMINIO';/" "$CONFIG"
    sudo sed -i "s|^\$data_dir.*|\$data_dir = '$DATA_DIR';|" "$CONFIG"
    sudo sed -i "s|^\$attachment_dir.*|\$attachment_dir = '$ADJUNTOS_DIR';|" "$CONFIG"
    sudo sed -i "s/^\$allow_server_sort.*/\$allow_server_sort = true;/" "$CONFIG"

    echo -e "s\n\nq" | perl "$RUTA_INSTALACION/config/conf.pl"

    sudo systemctl reload apache2
    sudo systemctl restart apache2

    echo -e "\n SquirrelMail instalado correctamente."
    echo "Accede desde: http://$WEB_DOMINIO o mediante la IP del servidor."
}

function mostrar_menu {
    while true; do
        echo "SERVIDOR DE CORREO - MENÚ"
        echo "=============================="
        echo "1 Instalar SquirrelMail "
        echo "2 Verificar/Instalar paquetes "
        echo "3 Establecer dominio"
        echo "4 Crear usuario y buzón"
        echo "5 Salir"
        echo "=============================="
        read -p "Selecciona una opción: " Op

        case $Op in
            1) instalar_Smail ;;
            2) verificar_paquetes ;;
            3) crear_dominio ;;
            4) crear_usuario_correo ;;
            5) echo  exit ;;
            *) echo "Opción inválida." ;;
        esac
    done
}

mostrar_menu
