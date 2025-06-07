#!/bin/bash

# Función para obtener la versión más reciente y la versión beta de un paquete
determine_versions() {
    local package=$1
    stable_version=$(apt-cache madison $package | awk '{print $3}' | head -1)
    beta_version=$(apt-cache madison $package | awk '{print $3}' | tail -1)
}

# Menú de selección de versión
clear
echo "Seleccione la versión que desea instalar:"
echo "1.- Versión estable"
echo "2.- Versión en desarrollo (beta)"
read -p "Ingrese el número de la opción: " version_type

# Verificar opción válida
if [[ "$version_type" != "1" && "$version_type" != "2" ]]; then
    echo "Opción no válida."
    exit 1
fi

# Mostrar menú de servicios según la versión seleccionada
clear
echo "¿Qué servicio desea instalar?"
if [ "$version_type" == "1" ]; then
    echo "1.- Apache (apache2)"
    echo "2.- Tomcat (tomcat10)"
    echo "3.- Nginx (nginx)"
else
    echo "1.- Apache Beta (apache2-beta)"
    echo "2.- Tomcat Beta (tomcat11)"
    echo "3.- Nginx Beta (nginx-beta)"
fi

read -p "Ingrese el número de la opción: " option

# Determinar el servicio según la versión seleccionada
case $option in
    1) service_name=$([ "$version_type" == "1" ] && echo "apache2" || echo "apache") ;;
    2) service_name=$([ "$version_type" == "1" ] && echo "tomcat10" || echo "tomcat11") ;;
    3) service_name=$([ "$version_type" == "1" ] && echo "nginx" || echo "mainline") ;;
    *) echo "Opción no válida."; exit 1 ;;
esac

# Determinar las versiones disponibles
determine_versions $service_name
selected_version=$([ "$version_type" == "1" ] && echo "$stable_version" || echo "$beta_version")

# Preguntar por el puerto
read -p "Ingrese el puerto en el que desea configurar el servicio: " port

# Instalación del servicio
sudo apt update
sudo apt install -y $service_name=$selected_version

# Configuración del puerto según el servicio
if [[ "$service_name" == "apache2"* ]]; then
    sudo sed -i "s/^Listen [0-9]\+/Listen $port/" /etc/apache2/ports.conf
    sudo sed -i "s/<VirtualHost \*:80>/<VirtualHost *:$port>/g" /etc/apache2/sites-available/000-default.conf
    sudo systemctl restart apache2

elif [[ "$service_name" == "nginx"* ]]; then
    # Modificar el archivo de configuración de Nginx para usar el puerto deseado
    sudo sed -i "s/listen 80;/listen $port;/" /etc/nginx/sites-available/default
    
    # Si no existe la línea listen, añadirla manualmente dentro del bloque server
    if ! grep -q "listen $port;" /etc/nginx/sites-available/default; then
        sudo sed -i "/server_name _;/a \    listen $port;" /etc/nginx/sites-available/default
    fi

    sudo systemctl restart nginx

elif [[ "$service_name" == "tomcat"* ]]; then
    sudo sed -i "s/port=\"[0-9]\+\"/port=\"$port\"/g" /etc/tomcat*/server.xml
    sudo systemctl restart tomcat*
fi

echo -e "\n$service_name ha sido instalado y configurado en el puerto $port."
