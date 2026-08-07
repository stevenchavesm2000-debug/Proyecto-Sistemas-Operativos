# Evidencias del proyecto

## Integrantes

- Steven Chaves Muñoz
- Yadiel García

## Objetivo

Organizar las capturas que demuestran la instalación, configuración y funcionamiento de todos los componentes del proyecto.

## Evidencias de Steven Chaves Muñoz

Las evidencias de Steven deben almacenarse en:

```text
evidencias/steven/
```

### Instalación y configuración inicial

- Creación de la máquina virtual.
- Instalación de Ubuntu.
- Información del sistema operativo.
- Configuración de red.
- Instalación de Git y herramientas básicas.
- Configuración del repositorio.

### Servidor web Apache

- Apache instalado y activo.
- Prueba de `localhost`.
- Configuración del Virtual Host `empresa.local`.
- Resultado `Syntax OK`.
- Respuesta `HTTP/1.1 200 OK`.
- Sitio AeroMap Solutions abierto en Firefox.
- Log de accesos de Apache.

### Base de datos integrada

- MySQL instalado y activo.
- Base de datos `aeromap_db`.
- Tablas creadas.
- Registros de prueba.
- Consultas de verificación.

### Sistema de respaldos

- Script `backup_db.sh`.
- Verificación de sintaxis.
- Respaldo comprimido `.sql.gz`.
- Fecha y hora en el nombre.
- Log de respaldo exitoso.
- Ejecución automática mediante cron.
- Configuración final cada doce horas.

### Monitor de recursos

- Ejecución normal del monitor.
- Uso de CPU, RAM y disco.
- Prueba controlada de alertas.
- Nombre de procesos.
- PID de procesos.
- Log del monitor.
- Ejecución automática cada minuto mediante cron.

### Git y GitHub

- Ramas de trabajo.
- Commits realizados.
- Push de las ramas.
- Pull Requests.
- Integración de cambios en `main`.

## Evidencias de Yadiel García

Las evidencias de Yadiel deben almacenarse en:

```text
evidencias/yadiel/
```

Deben incluir:

- Creación del sitio `curso.local`.
- Diseño HTML y CSS.
- Configuración del Virtual Host.
- Sitio abierto en Firefox.
- Creación de la base de datos.
- Tablas y registros de prueba.
- Commits y Pull Requests realizados con su cuenta.

## Evidencias técnicas principales

Las capturas más importantes para demostrar el funcionamiento son:

1. Ubuntu instalado.
2. Apache activo.
3. `empresa.local` funcionando.
4. `curso.local` funcionando.
5. MySQL activo.
6. Base, tablas y registros.
7. Respaldo comprimido creado.
8. Log del respaldo.
9. Cron del respaldo.
10. Monitor de recursos.
11. Alertas con proceso y PID.
12. Cron del monitor cada minuto.
13. Historial de commits.
14. Pull Requests de ambos integrantes.

## Recomendaciones

Las capturas no deben mostrar:

- Tokens de GitHub.
- Contraseñas.
- Datos personales innecesarios.
- Comandos incompletos.
- Errores que no hayan sido solucionados.

Cada captura debe mostrar claramente el comando ejecutado y el resultado obtenido.

## Resultado

Las evidencias permiten demostrar que los servicios, scripts, cronjobs, dominios, base de datos, logs y componentes del proyecto funcionan correctamente.
