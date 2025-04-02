# n8n con Docker y Caddy - by Raiola Networks 🚀

Este repositorio ha sido creado por [**Raiola Networks**](https://raiolanetworks.com) para desplegar [n8n](https://n8n.io/) de forma sencilla usando **Docker** y **Caddy** como servidor web y proxy inverso con certificados SSL automáticos vía Let's Encrypt.

---

## 🚀 ¿Qué incluye este proyecto?

- Un contenedor de **n8n**, una potente herramienta de automatización de flujos de trabajo.
- Un contenedor de **Caddy**, que gestiona automáticamente los certificados SSL.
- Configuración preparada para producción.
- Soporte para múltiples subdominios y dominios personalizados.

---

## 🛠️ ¿Cómo levantarlo?

Tienes dos formas de levantar el proyecto:

---

### 🔧 Opción 1: Instalación manual

```bash
git clone https://github.com/RaiolaNetworks/n8n-docker-caddy.git
cd n8n-docker-caddy
cp -a .env.sample .env
```

> ✍️ **IMPORTANTE:** Edita el archivo `.env` y ajusta las siguientes variables:
>
> - `DOMAIN_NAME=` → tu dominio principal (ej. `ejemplo.com`)
> - `SUBDOMAIN=` → subdominio donde se levantará n8n (ej. `n8n`)
> - `SSL_EMAIL=` → tu correo electrónico para la generación del certificado SSL

Una vez ajustado el `.env`, puedes levantar los contenedores con:

```bash
docker compose up -d
```

---

### 🤖 Opción 2: Instalación automática (solo Debian 12+)

Hemos creado un script instalador para sistemas **Debian 12 o superior**, que:

- Comprueba si eres root
- Verifica la versión de Debian
- Pide los datos del dominio, subdominio y correo
- Instala Docker y sus dependencias
- Clona este repositorio
- Ajusta el `.env` automáticamente

#### ✅ Para usar el instalador:

```bash
apt update && apt install -y lsb-release apt-transport-https ca-certificates curl
wget -O install_debian.sh https://raw.githubusercontent.com/RaiolaNetworks/n8n-docker-caddy/main/install_debian.sh
chmod +x install_debian.sh
bash install_debian.sh
```

Una vez finalizado, simplemente accede a la carpeta e inicia los contenedores:

```bash
cd /root/n8n-docker-caddy
docker compose up -d
```

---

## 📫 Soporte

Si necesitas ayuda, puedes abrir una *issue* en este repositorio de GitHub y estaremos encantados de ayudarte.

---

## 📜 Licencia

Este proyecto está bajo licencia **MIT**. Puedes usarlo, modificarlo y distribuirlo libremente.
