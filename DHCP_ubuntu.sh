#!/bin/bash

read -p "Ingrese la subred (ejemplo, 192.168.1.0): " subred
read -p "Ingrese la máscara de subred (ejemplo, 255.255.255.0): " máscara
read -p "Ingrese el rango de direcciones IP (inicio, ejemplo, 192.168.1.100): " rango_inicio
read -p "Ingrese el rango de direcciones IP (fin, ejemplo, 192.168.1.200): " rango_fin
read -p "Ingrese la dirección IP del router: " router
read -p "Ingrese las direcciones IP de los servidores DNS (ejemplo, 8.8.8.8,8.8.4.4): " dns

# Actualizar el sistema
sudo apt-get update -y
sudo apt-get upgrade -y

# Instalar el servidor DHCP
sudo apt install isc-dhcp-server -y

# Configurar el servidor DHCP
sudo bash -c "cat > /etc/dhcp/dhcpd.conf << EOF
default-lease-time 600;
max-lease-time 7200;
authoritative;
subnet \$subred netmask \$máscara {
    range \$rango_inicio \$rango_fin;
    option routers \$router;
    option domain-name-servers \$dns;
}
EOF"

# Configurar el servidor DHCP
INTERFAZ=\$(ip -o -4 addr list | grep -v '127.0.0.1' | awk '{print \$2}' | head -1)
sudo sed -i "s/INTERFACESv4=\"\"/INTERFACESv4=\"\$INTERFAZ\"/" /etc/default/isc-dhcp-server

# Reiniciar el servidor DHCP
sudo systemctl restart isc-dhcp-server
sudo systemctl enable isc-dhcp-server

echo "Servidor DHCP configurado y ejecutando correctamente."
