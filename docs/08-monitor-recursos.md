# Sistema de monitoreo de recursos

## Responsable de implementación final

Steven Chaves Muñoz

## Objetivo

Desarrollar un script Bash que supervise el uso de CPU, memoria RAM y espacio en disco del servidor Ubuntu, identificando procesos responsables y registrando los resultados en un archivo log.

## Archivo del monitor

El script se encuentra en:

```text
scripts/monitor_recursos.sh
```

Se le asignó permiso de ejecución mediante:

```bash
chmod +x scripts/monitor_recursos.sh
```

## Recursos monitoreados

El script utiliza los siguientes límites:

| Recurso | Límite |
|---|---:|
| CPU | 80 % |
| RAM | 80 % |
| Disco | 90 % |

## Herramientas utilizadas

- `/proc/stat`: permite calcular el uso del procesador.
- `free`: obtiene el uso de la memoria RAM.
- `df`: obtiene el porcentaje de espacio utilizado en disco.
- `ps`: identifica los procesos con mayor consumo de CPU y RAM.
- `/proc/PID/io`: obtiene información de lectura y escritura de los procesos.
- `date`: registra la fecha y hora de cada ejecución.

## Funcionamiento normal

El monitor se ejecuta mediante:

```bash
sudo ./scripts/monitor_recursos.sh
```

Cuando los recursos se encuentran por debajo de los límites, el log muestra:

```text
MODO: NORMAL
ESTADO: CPU 5% | RAM 55% | Disco 33%
RESULTADO: Recursos dentro de los límites configurados.
```

## Detección de alertas

Cuando un recurso supera su límite, el script registra:

- Recurso excedido.
- Porcentaje de uso.
- Límite configurado.
- Nombre del proceso.
- PID del proceso.
- Consumo asociado al proceso.
- Fecha y hora.

## Prueba controlada

Para demostrar las alertas sin afectar el funcionamiento de la máquina virtual, se implementó un modo de prueba:

```bash
sudo ./scripts/monitor_recursos.sh --test
```

Este modo utiliza temporalmente límites de 0 %, por lo que genera alertas claramente identificadas como:

```text
MODO: PRUEBA CONTROLADA
```

Durante la prueba se comprobó:

- Alerta de CPU.
- Alerta de RAM.
- Alerta de disco.
- Identificación del proceso.
- Identificación del PID.
- Registro de tres alertas.

## Archivo log

Los resultados se almacenan en:

```text
/var/log/aeromap_monitor.log
```

El log se revisó mediante:

```bash
sudo tail -n 30 /var/log/aeromap_monitor.log
```

## Automatización con cron

La tarea automática se encuentra en:

```text
cron/monitor-cron.txt
```

Configuración utilizada:

```cron
* * * * * root /home/steven/Proyectos/Proyecto-Sistemas-Operativos/scripts/monitor_recursos.sh >> /var/log/aeromap_monitor_cron.log 2>&1
```

Esta expresión ejecuta el monitor cada minuto.

La configuración fue instalada en:

```text
/etc/cron.d/aeromap-monitor
```

Se utilizaron los siguientes comandos:

```bash
sudo cp cron/monitor-cron.txt /etc/cron.d/aeromap-monitor
sudo chown root:root /etc/cron.d/aeromap-monitor
sudo chmod 644 /etc/cron.d/aeromap-monitor
sudo systemctl restart cron
```

## Verificación de cron

El servicio se comprobó mediante:

```bash
sudo systemctl is-active cron
```

También se revisaron las ejecuciones automáticas mediante:

```bash
sudo journalctl -u cron --since "5 minutes ago" |
grep monitor_recursos |
tail -n 10
```

Se observaron ejecuciones en minutos consecutivos, confirmando que cron funciona correctamente.

## Resultado

El monitor revisa CPU, RAM y disco, identifica procesos y PID, genera logs con fecha y hora y se ejecuta automáticamente cada minuto mediante cron.
