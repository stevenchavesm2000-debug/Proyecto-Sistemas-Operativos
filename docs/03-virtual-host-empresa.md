# Configuración del Virtual Host empresa.local

## Responsable

Steven Chaves Muñoz

## Objetivo

Configurar un sitio web independiente en Apache utilizando el dominio local `empresa.local`.

## Directorio del sitio

Los archivos HTML y CSS del sitio AeroMap Solutions se copiaron al directorio:

```text
/var/www/empresa.local
```

Se asignó como propietario al usuario y grupo de Apache:

```bash
sudo chown -R www-data:www-data /var/www/empresa.local
```

También se configuraron permisos de lectura y acceso para las carpetas y archivos.

## Configuración del Virtual Host

Se creó el archivo:

```text
/etc/apache2/sites-available/empresa.local.conf
```

La configuración utiliza:

- `ServerName empresa.local`: identifica el dominio.
- `ServerAlias www.empresa.local`: agrega un nombre alternativo.
- `DocumentRoot /var/www/empresa.local`: indica dónde se encuentran los archivos.
- `ErrorLog`: registra errores del sitio.
- `CustomLog`: registra accesos al sitio.

## Activación del sitio

El Virtual Host se habilitó mediante:

```bash
sudo a2ensite empresa.local.conf
```

## Resolución del dominio

Como `empresa.local` es un dominio de prueba, se agregó al archivo `/etc/hosts`:

```text
127.0.0.1 empresa.local www.empresa.local
```

Esto permite que Ubuntu dirija el dominio hacia el servidor local.

## Pruebas realizadas

Se verificó la sintaxis de Apache:

```bash
sudo apache2ctl configtest
```

El resultado obtenido fue:

```text
Syntax OK
```

Se comprobó el servicio:

```bash
sudo systemctl is-active apache2
```

El resultado fue:

```text
active
```

Finalmente se probó el dominio:

```bash
curl -I http://empresa.local
```

La respuesta `HTTP/1.1 200 OK` confirmó que el sitio funcionaba correctamente.

## Resultado

El dominio `empresa.local` muestra de manera independiente el sitio AeroMap Solutions, dedicado a topografía, fotogrametría y agricultura de precisión con drones.

