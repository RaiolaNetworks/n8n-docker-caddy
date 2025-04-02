#!/bin/bash

# 1. Comprobamos si somos root
if [ "$EUID" -ne 0 ]; then
  echo "Este script debe ejecutarse como root."
  exit 1
fi

# 2. Comprobamos si es Debian y al menos versión 12
if ! grep -qi "debian" /etc/os-release; then
  echo "Este script solo puede ejecutarse en Debian."
  exit 1
fi

DEBIAN_VERSION=$(grep VERSION_ID /etc/os-release | cut -d '"' -f2 | cut -d '.' -f1)
if [ "$DEBIAN_VERSION" -lt 12 ]; then
  echo "Debian 12 o superior es requerido."
  exit 1
fi

# 3. Pedimos dominio, subdominio y email
read -rp "Introduce el dominio (ejemplo: ejemplo.com): " DOMINIO
read -rp "Introduce el subdominio (ejemplo: n8n): " SUBDOMINIO
read -rp "Introduce tu email para SSL (ejemplo: user@dominio.com): " EMAIL

# 4. Instalamos dependencias
apt update
apt install -y ca-certificates curl git

# 5. Instalamos Docker
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  apt remove -y "$pkg"
done

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 6. Clonamos el repositorio
cd /root || exit
git clone https://github.com/RaiolaNetworks/n8n-docker-caddy
cd n8n-docker-caddy || exit

# 7. Copiamos el .env.sample a .env
cp .env.sample .env

# 8. Sustituimos los valores en el .env
sed -i "s/^DOMAIN_NAME=.*/DOMAIN_NAME=$DOMINIO/" .env
sed -i "s/^SUBDOMAIN=.*/SUBDOMAIN=$SUBDOMINIO/" .env
sed -i "s/^SSL_EMAIL=.*/SSL_EMAIL=$EMAIL/" .env

# 9. Instrucciones finales
echo ""
echo "✅ Configuración completada con éxito."
echo "➡️ Para iniciar el contenedor, ejecuta lo siguiente:"
echo "cd /root/n8n-docker-caddy && docker compose up -d"
