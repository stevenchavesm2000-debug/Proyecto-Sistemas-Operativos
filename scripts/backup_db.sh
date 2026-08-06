#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Detiene correctamente el script si falla algún comando de una tubería.
set -o pipefail

# Configuración principal.
DB_NAME="aeromap_db"
BACKUP_DIR="/var/backups/aeromap_db"
LOG_FILE="/var/log/aeromap_backup.log"
RETENTION_DAYS=7

# Fecha y hora utilizadas en el nombre del respaldo.
FECHA=$(date "+%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="${BACKUP_DIR}/backup_${DB_NAME}_${FECHA}.sql.gz"

# Función para registrar mensajes con fecha y hora.
registrar_log() {
    echo "[$(date "+%Y-%m-%d %H:%M:%S")] $1" | tee -a "$LOG_FILE"
}

# El respaldo debe ejecutarse como administrador.
if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Ejecute el script con sudo."
    exit 1
fi

# Verifica que mysqldump esté instalado.
if ! command -v mysqldump > /dev/null 2>&1; then
    registrar_log "ERROR: mysqldump no está instalado."
    exit 1
fi

# Verifica que gzip esté instalado.
if ! command -v gzip > /dev/null 2>&1; then
    registrar_log "ERROR: gzip no está instalado."
    exit 1
fi

# Verifica que la base de datos exista.
if ! mysql -Nse "SHOW DATABASES LIKE '${DB_NAME}';" | grep -qx "$DB_NAME"; then
    registrar_log "ERROR: La base de datos ${DB_NAME} no existe."
    exit 1
fi

# Crea la carpeta de respaldos si no existe.
mkdir -p "$BACKUP_DIR"
chmod 700 "$BACKUP_DIR"

registrar_log "INICIO: Creando respaldo de ${DB_NAME}."

# Realiza el respaldo y lo comprime directamente.
if mysqldump \
    --single-transaction \
    --quick \
    --routines \
    --triggers \
    --events \
    --databases "$DB_NAME" | gzip -9 > "$BACKUP_FILE"; then

    # Comprueba que el archivo exista, tenga contenido y no esté dañado.
    if [ -s "$BACKUP_FILE" ] && gzip -t "$BACKUP_FILE"; then
        chmod 600 "$BACKUP_FILE"

        TAMANO=$(du -h "$BACKUP_FILE" | cut -f1)

        registrar_log \
            "ÉXITO: Respaldo creado en ${BACKUP_FILE}. Tamaño: ${TAMANO}."
    else
        rm -f "$BACKUP_FILE"
        registrar_log "ERROR: El respaldo quedó vacío o dañado."
        exit 1
    fi
else
    rm -f "$BACKUP_FILE"
    registrar_log "ERROR: mysqldump no pudo respaldar ${DB_NAME}."
    exit 1
fi

# Elimina respaldos con más de siete días.
find "$BACKUP_DIR" \
    -type f \
    -name "backup_${DB_NAME}_*.sql.gz" \
    -mtime +"$RETENTION_DAYS" \
    -delete

registrar_log \
    "LIMPIEZA: Se eliminaron respaldos con más de ${RETENTION_DAYS} días."

exit 0
