#!/bin/bash

set -e

echo -e "Instalando Docker..."
sudo apt update
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
echo "Docker instalado y habilitado."

echo -e "Descargando imagen oficial de Apache..."
docker pull httpd

echo -e "Creando página personalizada index.html..."
mkdir -p apache_custom
cat > apache_custom/index.html <<EOF
<!DOCTYPE html>
<html>
<head><title>Mi Página Personalizada</title></head>
<body><h1>Hola desde Docker Apache</h1></body>
</html>
EOF

echo -e "Creando Dockerfile personalizado de Apache..."
cat > apache_custom/Dockerfile <<EOF
FROM httpd
COPY index.html /usr/local/apache2/htdocs/index.html
EOF

echo -e "Construyendo imagen personalizada de Apache..."
cd apache_custom
docker build -t apache_personalizado .
cd ..

echo -e "Ejecutando contenedor de Apache personalizado en el puerto 8081..."
docker run -d --name apache_mod --rm -p 8081:80 apache_personalizado

echo -e "Creando red personalizada para PostgreSQL..."
docker network create red_postgres || echo "La red ya existe."

echo "Lanzando dos contenedores de PostgreSQL conectados entre sí..."
docker run -d --name pg1 --rm --network red_postgres -e POSTGRES_PASSWORD=1234 postgres
docker run -d --name pg2 --rm --network red_postgres -e POSTGRES_PASSWORD=1234 postgres

echo -e " Todo listo."
echo "Apache personalizado: http://localhost:8081"
echo "Contenedores PostgreSQL (pg1, pg2) en red: red_postgres"
echo -e "Puedes entrar a pg1 y probar conexión a pg2 con:\n  docker exec -it pg1 bash\n  apt update && apt install -y postgresql-client\n  psql -h pg2 -U postgres"
