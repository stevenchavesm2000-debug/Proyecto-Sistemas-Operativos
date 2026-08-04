# Proyecto de Sistemas Operativos

## Integrantes

- Steven Chaves Muñoz
- Yadiel García

## Descripción

Este proyecto consiste en diseñar e implementar una infraestructura de servicios en Linux utilizando una máquina virtual con Ubuntu.

El sistema incluye un servidor web Apache, dos sitios independientes, una base de datos, scripts Bash, tareas automáticas con cron, monitoreo de recursos, registros del sistema y control de versiones mediante GitHub.

## Arquitectura principal

- Sistema operativo Ubuntu
- Servidor web Apache
- Sitio institucional `empresa.local`
- Sitio informativo `curso.local`
- Base de datos MySQL o MariaDB
- Script de respaldos automáticos
- Compresión de respaldos
- Automatización mediante cron
- Monitor de CPU, RAM, disco y procesos
- Logs del servidor y de los scripts
- Documentación técnica en Markdown

## Sitios web

### empresa.local

Sitio institucional desarrollado por Steven Chaves.

Nombre:

```text
AeroMap Solutions
```

Temática:

- Topografía con drones
- Fotogrametría
- Ortomosaicos
- Modelos digitales
- Agricultura de precisión
- Inspección aérea
- Cartografía digital

### curso.local

Sitio informativo desarrollado por Yadiel García.

Temática:

- Drones
- Fotogrametría
- Planificación de vuelos
- Procesamiento de imágenes
- Modelos digitales
- Agricultura de precisión

## Estructura del repositorio

```text
Proyecto-Sistemas-Operativos/
├── apache/
├── database/
├── docs/
├── evidencias/
│   ├── steven/
│   └── yadiel/
├── scripts/
├── sitios/
│   ├── empresa.local/
│   └── curso.local/
├── cron/
├── logs/
└── README.md
```

## Distribución del trabajo

### Steven Chaves Muñoz

- Creación del repositorio
- Instalación de Ubuntu
- Configuración inicial del sistema
- Instalación de Apache
- Sitio `empresa.local`
- Virtual Host de `empresa.local`
- Script de respaldo
- Compresión y logs del respaldo
- Automatización del respaldo con cron
- Documentación y evidencias correspondientes

### Yadiel García

- Sitio `curso.local`
- Virtual Host de `curso.local`
- Instalación de la base de datos
- Creación de tablas y registros
- Script de monitoreo
- Monitoreo de CPU, RAM, disco y procesos
- Automatización del monitor con cron
- Documentación y evidencias correspondientes

## Estado actual

- [x] Repositorio público creado
- [x] Ubuntu instalado
- [x] Git configurado
- [x] Apache instalado
- [x] Sitio `empresa.local` creado
- [x] Virtual Host `empresa.local` funcionando
- [ ] Sitio `curso.local`
- [ ] Base de datos
- [ ] Script de respaldo
- [ ] Cron de respaldos
- [ ] Monitor de recursos
- [ ] Cron del monitor
- [ ] Evidencias finales
- [ ] Presentación
- [ ] Defensa del proyecto

## Pruebas realizadas

Para verificar Apache y el primer dominio se utilizaron:

```bash
sudo apache2ctl configtest
sudo systemctl is-active apache2
curl -I http://empresa.local
```

Resultados esperados y obtenidos:

```text
Syntax OK
active
HTTP/1.1 200 OK
```

## Control de versiones

El proyecto utiliza ramas separadas para cada integrante.

Ejemplos:

```text
steven/configuracion-inicial
steven/servidor-apache
steven/documentacion-general
steven/backups

yadiel/sitio-informativo
yadiel/base-datos
yadiel/monitor-recursos
```

Los cambios se integran a `main` mediante Pull Requests.# Proyecto-Sistemas-Operativos
Servidor Linux con Apache, Virtual Hosts, base de datos, monitoreo de recursos y documentación en Markdown.
