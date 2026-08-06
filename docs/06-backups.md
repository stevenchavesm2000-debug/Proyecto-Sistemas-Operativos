# Sistema automatizado de respaldos

## Responsable

Steven Chaves Muñoz

## Objetivo

Desarrollar un script Bash que realice respaldos de la base de datos `aeromap_db`, comprima el resultado y registre cada ejecución en un archivo log.

## Base de datos respaldada

```text
aeromap_db
```

La base contiene información de clientes, servicios, solicitudes y usuarios del sistema AeroMap.

## Script desarrollado

El script se encuentra en:

```text
scripts/backup_db.sh
```

Se le asignó permiso de ejecución mediante:

```bash
chmod +x scripts/backup_db.sh
```

## Funciones principales

El script realiza las siguientes operaciones:

1. Comprueba que se ejecute con permisos administrativos.
2. Verifica la existencia de `mysqldump`.
3. Verifica la existencia de `gzip`.
4. Comprueba que la base `aeromap_db` exista.
5. Crea automáticamente la carpeta de respaldos.
6. Realiza el respaldo mediante `mysqldump`.
7. Comprime directamente el resultado con `gzip`.
8. Agrega fecha y hora al nombre del archivo.
9. Verifica que el archivo tenga contenido.
10. Comprueba que el archivo comprimido no esté dañado.
11. Registra el resultado en un log.
12. Elimina respaldos con más de siete días.

## Directorio de respaldos

Los archivos se almacenan en:

```text
/var/backups/aeromap_db
```

Ejemplo de nombre generado:

```text
backup_aeromap_db_2026-08-05_18-10-37.sql.gz
```

## Archivo de log

El registro de las ejecuciones se almacena en:

```text
/var/log/aeromap_backup.log
```

El log contiene:

- Fecha y hora.
- Inicio del respaldo.
- Resultado exitoso o error.
- Ubicación del archivo.
- Tamaño del respaldo.
- Limpieza de archivos antiguos.

## Verificación de sintaxis

Antes de ejecutar el script se utilizó:

```bash
bash -n scripts/backup_db.sh
```

El código de salida obtenido fue `0`, lo cual confirmó que no existían errores de sintaxis.

## Ejecución manual

El respaldo se ejecutó mediante:

```bash
sudo ./scripts/backup_db.sh
```

## Comprobación del respaldo

Para listar los archivos creados se utilizó:

```bash
sudo ls -lh /var/backups/aeromap_db
```

Para revisar el log se utilizó:

```bash
sudo tail -n 10 /var/log/aeromap_backup.log
```

## Resultado

El script generó correctamente un respaldo comprimido de la base `aeromap_db`, con fecha y hora en el nombre y un registro detallado de la ejecución.
