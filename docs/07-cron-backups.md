# Automatización de respaldos mediante cron

## Responsable

Steven Chaves Muñoz

## Objetivo

Automatizar la ejecución del script de respaldo de la base de datos `aeromap_db` mediante el servicio cron de Ubuntu.

## Servicio cron

Se comprobó que el servicio se encontraba activo mediante:

```bash
sudo systemctl is-active cron
```

El resultado obtenido fue:

```text
active
```

## Prueba de ejecución

Para demostrar el funcionamiento de la automatización, inicialmente se configuró una tarea que ejecutaba el respaldo cada minuto:

```cron
* * * * * root /home/steven/Proyectos/Proyecto-Sistemas-Operativos/scripts/backup_db.sh >> /var/log/aeromap_backup_cron.log 2>&1
```

La configuración se copió al directorio:

```text
/etc/cron.d/aeromap-backup
```

Posteriormente se asignaron los permisos necesarios:

```bash
sudo chmod 644 /etc/cron.d/aeromap-backup
```

Finalmente se reinició el servicio:

```bash
sudo systemctl restart cron
```

## Verificación de la ejecución automática

La actividad de cron se comprobó mediante:

```bash
sudo journalctl -u cron --since "10 minutes ago"
```

Los registros mostraron la ejecución automática del script en diferentes minutos.

También se verificó la creación de nuevos respaldos en:

```text
/var/backups/aeromap_db
```

## Configuración definitiva

Después de demostrar el funcionamiento, la tarea se configuró para ejecutarse cada doce horas:

```cron
0 */12 * * * root /home/steven/Proyectos/Proyecto-Sistemas-Operativos/scripts/backup_db.sh >> /var/log/aeromap_backup_cron.log 2>&1
```

La expresión significa:

- Minuto `0`.
- Cada doce horas.
- Todos los días del mes.
- Todos los meses.
- Todos los días de la semana.

Por lo tanto, el respaldo se ejecutará diariamente a las 00:00 y a las 12:00.

## Registro de cron

La salida de la tarea se guarda en:

```text
/var/log/aeromap_backup_cron.log
```

El script también mantiene su propio registro detallado en:

```text
/var/log/aeromap_backup.log
```

## Resultado

Cron ejecutó correctamente el script durante la prueba y quedó configurado para generar respaldos automáticos cada doce horas.
