# Instalación y verificación del servidor Apache

## Responsable

Steven Chaves Muñoz

## Objetivo

Instalar y comprobar el funcionamiento del servidor web Apache dentro de la máquina virtual Ubuntu utilizada para el proyecto.

## Instalación de Apache

El servidor web se instaló mediante el administrador de paquetes de Ubuntu:

```bash
sudo apt install apache2 -y

```

El parámetro `-y` permitió confirmar automáticamente la instalación de los paquetes necesarios.

## Verificación del servicio

Para comprobar que Apache se encontraba activo se utilizaron los siguientes comandos:

```bash
sudo systemctl status apache2
sudo systemctl is-active apache2
```

El sistema mostró el estado `active`, lo cual confirmó que el servicio estaba ejecutándose correctamente.

## Versión instalada

La versión del servidor se consultó mediante:

```bash
apache2 -v
```

## Prueba desde la terminal

Se realizó una solicitud local mediante:

```bash
curl -I http://localhost
```

La respuesta `HTTP/1.1 200 OK` confirmó que Apache podía recibir y responder solicitudes web.

## Prueba desde el navegador

Se abrió Firefox dentro de Ubuntu y se ingresó la dirección:

```text
http://localhost
```

El navegador mostró la página predeterminada de Apache, confirmando que el servidor web quedó instalado y funcionando.

## Resultado

Apache quedó preparado para alojar los dos sitios web independientes solicitados en el proyecto. En las siguientes etapas se crearán sus directorios y se configurarán los Virtual Hosts.
