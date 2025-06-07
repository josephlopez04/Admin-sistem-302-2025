#!/bin/bash

echo "Instalando OpenSSH Server..."
apt update && apt install -y openssh-server

echo "OpenSSH instalado correctamente."

# Habilitar e iniciar SSH
echo "Habilitando y arrancando SSH..."
systemctl enable ssh
systemctl start ssh

# Configurar Firewall para permitir SSH
echo "Configurando el firewall..."
ufw allow 22/tcp

# Reiniciar SSH para aplicar cambios
echo "Reiniciando SSH para aplicar cambios..."
systemctl restart ssh

# Mostrar estado final del servicio
systemctl status ssh --no-pager

echo "SSH está configurado y en ejecución."
echo "Ahora puedes conectarte con: ssh usuario@<IP_DEL_SERVIDOR>"
