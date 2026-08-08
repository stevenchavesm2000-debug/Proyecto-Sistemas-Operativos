#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

CPU_LIMITE=80
RAM_LIMITE=80
DISCO_LIMITE=90
LOG_FILE="/var/log/aeromap_monitor.log"
MODO_PRUEBA=false

if [ "${1:-}" = "--test" ]; then
    MODO_PRUEBA=true
    CPU_LIMITE=0
    RAM_LIMITE=0
    DISCO_LIMITE=0
fi

registrar() {
    echo "$1" | tee -a "$LOG_FILE"
}

obtener_cpu() {
    local cpu usuario nice sistema idle iowait irq softirq steal guest guest_nice
    local total1 idle1 total2 idle2 diferencia_total diferencia_idle uso

    read -r cpu usuario nice sistema idle iowait irq softirq steal guest guest_nice < /proc/stat

    total1=$((usuario + nice + sistema + idle + iowait + irq + softirq + steal))
    idle1=$((idle + iowait))

    sleep 1

    read -r cpu usuario nice sistema idle iowait irq softirq steal guest guest_nice < /proc/stat

    total2=$((usuario + nice + sistema + idle + iowait + irq + softirq + steal))
    idle2=$((idle + iowait))

    diferencia_total=$((total2 - total1))
    diferencia_idle=$((idle2 - idle1))

    if [ "$diferencia_total" -gt 0 ]; then
        uso=$((100 * (diferencia_total - diferencia_idle) / diferencia_total))
    else
        uso=0
    fi

    echo "$uso"
}

obtener_ram() {
    free | awk '/Mem:/ {printf("%.0f", ($3/$2)*100)}'
}

obtener_disco() {
    df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}'
}

proceso_cpu() {
    ps -eo pid=,comm=,%cpu= --sort=-%cpu |
        awk 'NR==1 {print $1 "|" $2 "|" $3}'
}

proceso_ram() {
    ps -eo pid=,comm=,%mem= --sort=-%mem |
        awk 'NR==1 {print $1 "|" $2 "|" $3}'
}

proceso_disco() {
    local mejor_pid="N/D"
    local mejor_nombre="N/D"
    local mejor_bytes=-1
    local directorio pid bytes nombre

    for directorio in /proc/[0-9]*; do
        [ -r "$directorio/io" ] || continue

        pid="${directorio##*/}"

        bytes=$(awk '
            /^(read_bytes|write_bytes):/ {
                total += $2
            }
            END {
                printf "%.0f", total + 0
            }
        ' "$directorio/io" 2>/dev/null)

        bytes=${bytes:-0}

        if [ "$bytes" -gt "$mejor_bytes" ] 2>/dev/null; then
            mejor_bytes="$bytes"
            mejor_pid="$pid"

            nombre=$(cat "$directorio/comm" 2>/dev/null)
            mejor_nombre=${nombre:-N/D}
        fi
    done

    echo "$mejor_pid|$mejor_nombre|$mejor_bytes"
}

if [ "$EUID" -ne 0 ]; then
    echo "ERROR: Ejecute el monitor con sudo."
    exit 1
fi

touch "$LOG_FILE" || {
    echo "ERROR: No se pudo crear el log $LOG_FILE."
    exit 1
}

chmod 640 "$LOG_FILE"

CPU_USO=$(obtener_cpu)
RAM_USO=$(obtener_ram)
DISCO_USO=$(obtener_disco)
FECHA=$(date "+%Y-%m-%d %H:%M:%S")
ALERTAS=0

registrar "============================================================"
registrar "[$FECHA] MONITOREO DE RECURSOS"

if [ "$MODO_PRUEBA" = true ]; then
    registrar "MODO: PRUEBA CONTROLADA (límites temporales en 0%)"
else
    registrar "MODO: NORMAL"
fi

registrar "ESTADO: CPU ${CPU_USO}% | RAM ${RAM_USO}% | Disco ${DISCO_USO}%"

if [ "$CPU_USO" -ge "$CPU_LIMITE" ]; then
    IFS='|' read -r PID PROCESO PORCENTAJE <<< "$(proceso_cpu)"

    registrar "ALERTA: CPU excedida"
    registrar "Uso actual: ${CPU_USO}% | Límite: ${CPU_LIMITE}%"
    registrar "Proceso: ${PROCESO} | PID: ${PID} | CPU del proceso: ${PORCENTAJE}%"

    ALERTAS=$((ALERTAS + 1))
fi

if [ "$RAM_USO" -ge "$RAM_LIMITE" ]; then
    IFS='|' read -r PID PROCESO PORCENTAJE <<< "$(proceso_ram)"

    registrar "ALERTA: RAM excedida"
    registrar "Uso actual: ${RAM_USO}% | Límite: ${RAM_LIMITE}%"
    registrar "Proceso: ${PROCESO} | PID: ${PID} | RAM del proceso: ${PORCENTAJE}%"

    ALERTAS=$((ALERTAS + 1))
fi

if [ "$DISCO_USO" -ge "$DISCO_LIMITE" ]; then
    IFS='|' read -r PID PROCESO BYTES <<< "$(proceso_disco)"

    registrar "ALERTA: Disco excedido"
    registrar "Uso actual: ${DISCO_USO}% | Límite: ${DISCO_LIMITE}%"
    registrar "Proceso con mayor escritura acumulada: ${PROCESO}"
    registrar "PID: ${PID} | Bytes escritos: ${BYTES}"

    ALERTAS=$((ALERTAS + 1))
fi

if [ "$ALERTAS" -eq 0 ]; then
    registrar "RESULTADO: Recursos dentro de los límites configurados."
else
    registrar "RESULTADO: Se detectaron ${ALERTAS} alerta(s)."
fi

registrar "============================================================"

/home/steven/Proyectos/Proyecto-Sistemas-Operativos/scripts/actualizar_dashboard.sh || true
exit 0
