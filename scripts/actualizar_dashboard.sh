#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

WEB_DIR="/var/www/empresa.local/monitor"
STATUS_FILE="$WEB_DIR/status.json"

CPU_LIMITE=80
RAM_LIMITE=80
DISCO_LIMITE=90

mkdir -p "$WEB_DIR"

obtener_cpu() {
    local cpu usuario nice sistema idle iowait irq softirq steal
    local total1 total2 idle1 idle2 diferencia_total diferencia_idle

    read -r cpu usuario nice sistema idle iowait irq softirq steal _ < /proc/stat

    total1=$((usuario + nice + sistema + idle + iowait + irq + softirq + steal))
    idle1=$((idle + iowait))

    sleep 1

    read -r cpu usuario nice sistema idle iowait irq softirq steal _ < /proc/stat

    total2=$((usuario + nice + sistema + idle + iowait + irq + softirq + steal))
    idle2=$((idle + iowait))

    diferencia_total=$((total2 - total1))
    diferencia_idle=$((idle2 - idle1))

    if [ "$diferencia_total" -gt 0 ]; then
        echo $((100 * (diferencia_total - diferencia_idle) / diferencia_total))
    else
        echo 0
    fi
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

CPU_USO=$(obtener_cpu)
RAM_USO=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
DISCO_USO=$(df -P / | awk 'NR==2 {gsub("%", "", $5); print $5}')

IFS='|' read -r CPU_PID CPU_PROCESO CPU_PROCESO_USO <<< "$(
    ps -eo pid=,comm=,%cpu= --sort=-%cpu |
    awk '
        $2 !~ /^(ps|awk|sleep)$/ &&
        $2 !~ /monitor/ &&
        $2 !~ /actualizar/ {
            print $1 "|" $2 "|" $3
            exit
        }
    '
)"

IFS='|' read -r RAM_PID RAM_PROCESO RAM_PROCESO_USO <<< \
"$(ps -eo pid=,comm=,%mem= --sort=-%mem | awk 'NR==1 {print $1 "|" $2 "|" $3}')"

IFS='|' read -r DISCO_PID DISCO_PROCESO DISCO_BYTES <<< "$(proceso_disco)"

CPU_PROCESO=${CPU_PROCESO//\"/}
RAM_PROCESO=${RAM_PROCESO//\"/}
DISCO_PROCESO=${DISCO_PROCESO//\"/}

ALERTAS=0

[ "$CPU_USO" -ge "$CPU_LIMITE" ] && ALERTAS=$((ALERTAS + 1))
[ "$RAM_USO" -ge "$RAM_LIMITE" ] && ALERTAS=$((ALERTAS + 1))
[ "$DISCO_USO" -ge "$DISCO_LIMITE" ] && ALERTAS=$((ALERTAS + 1))

ESTADO="NORMAL"

if [ "$ALERTAS" -gt 0 ]; then
    ESTADO="ALERTA"
fi

FECHA=$(date "+%Y-%m-%d %H:%M:%S")

cat > "${STATUS_FILE}.tmp" <<EOF
{
  "fecha": "$FECHA",
  "estado": "$ESTADO",
  "alertas": $ALERTAS,
  "cpu": {
    "uso": $CPU_USO,
    "limite": $CPU_LIMITE,
    "proceso": "$CPU_PROCESO",
    "pid": "$CPU_PID",
    "consumo": "$CPU_PROCESO_USO"
  },
  "ram": {
    "uso": $RAM_USO,
    "limite": $RAM_LIMITE,
    "proceso": "$RAM_PROCESO",
    "pid": "$RAM_PID",
    "consumo": "$RAM_PROCESO_USO"
  },
  "disco": {
    "uso": $DISCO_USO,
    "limite": $DISCO_LIMITE,
    "proceso": "$DISCO_PROCESO",
    "pid": "$DISCO_PID",
    "bytes": "$DISCO_BYTES"
  }
}
EOF

mv "${STATUS_FILE}.tmp" "$STATUS_FILE"
chmod 644 "$STATUS_FILE"

exit 0

