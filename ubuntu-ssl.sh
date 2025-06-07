#!/bin/bash

# Función para obtener la versión más reciente y la versión beta de un paquete
determine_versions() {
    local package=$1
    stable_version=$(apt-cache madison $package | awk '{print $3}' | head -1)
    beta_version=$(apt-cache madison $package | awk '{print $3}' | tail -1)
}

# Menú de selección del servicio
clear
echo "¿Qué servicio desea instalar?"
echo "1.- Apache"
echo "2.- Tomcat"
echo "3.- Nginx"
read -p "Ingrese el número de la opción: " option

# Determinar las versiones disponibles según el servicio seleccionado
case $option in
    1)
        service_name="apache2"
        config_file="/etc/apache2/ports.conf"
        vhost_config="/etc/apache2/sites-available/000-default.conf"
        ;;
    2)
        service_name="tomcat10"
        config_file="/etc/tomcat10/server.xml"
        ;;
    3)
        service_name="nginx"
        config_file="/etc/nginx/sites-available/default"
        ;;
    *)
        echo "Opción no válida."
        exit 1
        ;;
esac

determine_versions $service_name

echo -e "\nSeleccione la versión a instalar:"
echo "1.- Versión estable más reciente ($stable_version)"
echo "2.- Versión en desarrollo (beta) más reciente ($beta_version)"
read -p "Ingrese el número de la opción: " version_option

if [ "$version_option" == "1" ]; then
    selected_version=$stable_version
elif [ "$version_option" == "2" ]; then
    selected_version=$beta_version
else
    echo "Opción no válida"
    exit 1
fi

# Preguntar por el puerto
echo -e "\nIngrese el puerto en el que desea configurar el servicio: "
read port

# Preguntar si desea usar localhost o un dominio
echo -e "\n¿Desea usar localhost o un dominio personalizado?"
echo "1.- Localhost"
echo "2.- Escribir un dominio"
read -p "Ingrese el número de la opción: " domain_option

if [ "$domain_option" == "1" ]; then
    server_name="localhost"
elif [ "$domain_option" == "2" ]; then
    read -p "Ingrese el nombre de dominio (ejemplo: aprobados.com): " server_name
else
    echo "Opción no válida"
    exit 1
fi

# Instalación del servicio
sudo apt update
sudo apt install -y $service_name=$selected_version

# Configuración del puerto y dominio según el servicio
if [ "$service_name" == "apache2" ]; then
    sudo sed -i "/^Listen /d" $config_file
    echo "Listen $port" | sudo tee -a $config_file
    sudo sed -i "s/<VirtualHost \*:80>/<VirtualHost *:$port>/g" $vhost_config
    sudo sed -i "s|ServerName .*|ServerName $server_name|g" $vhost_config
    sudo systemctl restart apache2
elif [ "$service_name" == "nginx" ]; then
    sudo sed -i "s/listen 80;/listen $port;/g" $config_file
    sudo sed -i "s|server_name .*|server_name $server_name;|g" $config_file
    sudo systemctl restart nginx
elif [ "$service_name" == "tomcat10" ]; then
    sudo sed -i "s/port=\"8080\"/port=\"$port\"/g" $config_file
    sudo systemctl restart tomcat10
fi

echo "\n$service_name ha sido instalado y configurado en el puerto $port con el dominio $server_name."
