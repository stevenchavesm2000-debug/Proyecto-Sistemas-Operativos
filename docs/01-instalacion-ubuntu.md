# Instalación y configuración inicial de Ubuntu

## Responsable

Steven Chaves Muñoz

## Descripción

Para desarrollar el proyecto de Sistemas Operativos se creó una nueva máquina virtual en Oracle VirtualBox. Esta máquina se utilizará como servidor Linux para instalar Apache, una base de datos, scripts Bash, tareas programadas y herramientas de monitoreo.

## Configuración de la máquina virtual

- Nombre de la máquina virtual: `Proyecto_Sistemas_Operativos`
- Sistema operativo: Ubuntu 26.04 LTS de 64 bits
- Memoria RAM asignada: 4096 MB
- Procesadores: 2
- Disco duro virtual: 40 GB
- Tipo de almacenamiento: dinámico
- Configuración de red: NAT

## Datos del sistema

- Nombre del usuario: `steven`
- Nombre del equipo: `servidor-so`
- Dirección IPv4 inicial: `10.0.2.15`
- Interfaz de red: `enp0s3`

## Instalación

La instalación se realizó manualmente utilizando una imagen ISO de Ubuntu. Durante el proceso se seleccionó el idioma español, el teclado latinoamericano y la opción para borrar únicamente el disco virtual e instalar Ubuntu.

El nombre del equipo se configuró como `servidor-so`, debido a que la máquina funcionará como servidor principal del proyecto.

## Verificación del sistema

Se utilizaron los siguientes comandos:

```bash
whoami
hostname
lsb_release -a
free -h
df -h
