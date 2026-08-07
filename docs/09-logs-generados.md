# Logs generados por el sistema

## Integrantes

- Steven Chaves Muñoz
- Yadiel García

## Objetivo

Documentar los registros generados por Apache, el sistema de respaldos, cron y el monitor de recursos.

Los logs permiten comprobar que los servicios y scripts se ejecutan correctamente y ayudan a detectar errores.

## Logs de Apache

Cada Virtual Host utiliza registros independientes.

### Sitio empresa.local

```text
/var/log/apache2/empresa.local-access.log
/var/log/apache2/empresa.local-error.log
```

### Sitio curso.local

```text
/var/log/apache2/curso.local-access.log
/var/log/apache2/curso.local-error.log
```

El log de accesos registra:

- Fecha y hora.
- Dirección del cliente.
- Recurso solicitado.
- Método HTTP.
- Código de respuesta.
- Navegador o herramienta utilizada.

Ejemplo de revisión:

```bash
sudo tail -n 15 /var/log/apache2/empresa.local-access.log
```

Las respuestas con código `200` indican que Apache entregó correctamente el recurso solicitado.

Los errores pueden revisarse mediante:

```bash
sudo tail -n 15 /var/log/apache2/empresa.local-error.log
```

## Log del sistema de respaldos

El script de respaldos guarda su registro principal en:

```text
/var/log/aeromap_backup.log
```

Este archivo contiene:

- Inicio del respaldo.
- Resultado exitoso o error.
- Nombre y ubicación del archivo.
- Tamaño del respaldo.
- Eliminación de respaldos antiguos.
- Fecha y hora de cada ejecución.

Se revisa mediante:

```bash
sudo tail -n 15 /var/log/aeromap_backup.log
```

## Log de cron para respaldos

La salida de la tarea automática se almacena en:

```text
/var/log/aeromap_backup_cron.log
```

También se puede comprobar la ejecución de cron mediante:

```bash
sudo journalctl -u cron --since "10 minutes ago"
```

## Log del monitor de recursos

El monitor registra sus resultados en:

```text
/var/log/aeromap_monitor.log
```

El archivo contiene:

- Fecha y hora.
- Uso de CPU.
- Uso de RAM.
- Uso de disco.
- Alertas generadas.
- Nombre del proceso responsable.
- PID del proceso.
- Resultado de cada ejecución.

Se revisa mediante:

```bash
sudo tail -n 30 /var/log/aeromap_monitor.log
```

## Log de cron para el monitor

La salida de la ejecución automática se almacena en:

```text
/var/log/aeromap_monitor_cron.log
```

Para confirmar que cron ejecuta el monitor cada minuto se utilizó:

```bash
sudo journalctl -u cron --since "5 minutes ago" |
grep monitor_recursos |
tail -n 10
```

## Verificación de los logs

Los principales comandos utilizados fueron:

```bash
sudo tail -n 15 /var/log/apache2/empresa.local-access.log
sudo tail -n 15 /var/log/apache2/curso.local-access.log
sudo tail -n 15 /var/log/aeromap_backup.log
sudo tail -n 30 /var/log/aeromap_monitor.log
sudo journalctl -u cron --since "10 minutes ago"
```

## Resultado

El sistema genera registros separados para Apache, respaldos, cron y monitoreo de recursos.

Los logs contienen fecha, hora, resultados, alertas y datos de procesos, lo que permite verificar el funcionamiento del servidor y detectar posibles problemas.
