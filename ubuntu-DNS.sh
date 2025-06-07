#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalar Bind9
sudo apt-get install -y bind9 bind9utils

# Configuración Zona Directa
read -p "Introduzca el dominio: " dominio
read -p "Introduzca la IP: " ip

sudo mkdir -p /etc/bind/zones
sudo chown bind:bind /etc/bind/zones

nombrearchivozona="db.${dominio}"
ruta="/etc/bind/zones/${nombrearchivozona}"

cat > ${ruta} << EOF
\$TTL 86400
@ IN SOA ns1.${dominio}. admin.${dominio}. (
    $(date +%Y%m%d)01 ; Serial
    28800 ; Refresh
    7200 ; Retry
    864000 ; Expire
    86400 ) ; Minimum TTL
;
    IN NS ns1.${dominio}.
ns1 IN A ${ip}
@ IN A ${ip}
www IN A ${ip}
EOF

ZoneConfig="/etc/bind/named.conf.local"
echo "zone \"${dominio}\" {
    type master;
    file \"${ruta}\";
};" | sudo tee -a ${ZoneConfig}

# Verificar configuración
echo "Verificando configuración..."
sudo named-checkconf

sudo chown bind:bind ${ruta}

# Reiniciar Bind9
echo "Reiniciando Bind9..."
sudo systemctl restart bind9
sudo systemctl enable bind9

echo "Servidor DNS configurado con éxito"
