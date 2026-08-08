# Dashboard visual del monitor de recursos

Steven Chaves Muñoz

## Objetivo

Presentar gráficamente la información obtenida por el monitor Bash de recursos del servidor Ubuntu.

El dashboard complementa el script `monitor_recursos.sh`, pero no lo reemplaza. El script sigue siendo responsable de revisar los recursos, generar alertas, identificar procesos y crear los logs.

## Dirección del dashboard

```text
http://empresa.local/monitor/
```

## Archivos utilizados

```text
scripts/monitor_recursos.sh
scripts/actualizar_dashboard.sh
sitios/empresa.local/monitor/index.html
```

## Recursos mostrados

El panel presenta:

- Uso de CPU.
- Uso de memoria RAM.
- Uso de disco.
- Límites configurados.
- Estado normal o alerta.
- Cantidad de alertas.
- Procesos detectados.
- PID de los procesos.
- Consumo asociado.
- Fecha y hora de actualización.

## Generación de datos

El script:

```text
scripts/actualizar_dashboard.sh
```

obtiene la información del sistema y genera:

```text
/var/www/empresa.local/monitor/status.json
```

Este archivo contiene los datos en formato JSON.

## Integración con el monitor

Al finalizar una ejecución, `monitor_recursos.sh` llama al generador del dashboard:

```bash
/home/steven/Proyectos/Proyecto-Sistemas-Operativos/scripts/actualizar_dashboard.sh
```

De esta forma, los datos visuales corresponden a la información real del servidor.

## Automatización

El monitor se ejecuta cada minuto mediante cron:

```cron
* * * * * root /home/steven/Proyectos/Proyecto-Sistemas-Operativos/scripts/monitor_recursos.sh
```

Cada ejecución actualiza el archivo `status.json`.

La página web consulta el archivo cada cinco segundos y muestra los nuevos valores cuando están disponibles.

## Verificación del servicio web

El dashboard se comprobó mediante:

```bash
curl -I http://empresa.local/monitor/
```

El resultado obtenido fue:

```text
HTTP/1.1 200 OK
```

## Verificación de los datos

El archivo generado se comprobó mediante:

```bash
sudo cat /var/www/empresa.local/monitor/status.json
```

También se verificó su fecha de actualización mediante:

```bash
stat -c "Última modificación: %y" /var/www/empresa.local/monitor/status.json
```

## Resultado

Se implementó un panel visual propio conectado con el monitor Bash y cron. El dashboard muestra el estado real del servidor y permite explicar visualmente el monitoreo de CPU, RAM, disco, procesos y PID.
