# Arquitectura general del sistema

## Descripción

El proyecto consiste en una infraestructura de servicios implementada sobre Ubuntu dentro de una máquina virtual de Oracle VirtualBox.

La máquina funciona como servidor para alojar dos sitios web independientes, una base de datos, scripts Bash, tareas automáticas y registros del sistema.

## Componentes principales

### Sistema operativo

- Ubuntu 26.04 LTS
- Máquina virtual: Proyecto_Sistemas_Operativos
- Nombre del equipo: servidor-so
- Red configurada inicialmente como NAT

### Servidor web

Se utiliza Apache para alojar dos sitios independientes:

- empresa.local
- curso.local

Cada sitio posee:

- Su propio directorio
- Archivos HTML y CSS
- Su propio Virtual Host
- Registros de acceso y errores

### Sitio institucional

El dominio `empresa.local` muestra el sitio AeroMap Solutions, relacionado con topografía, fotogrametría y agricultura de precisión mediante drones.

Directorio:

```text
/var/www/empresa.local
