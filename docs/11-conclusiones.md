# Conclusiones del proyecto

## Integrantes

- Steven Chaves Muñoz
- Yadiel García

## Conclusión general

El desarrollo de este proyecto permitió implementar una infraestructura de servicios en Linux utilizando Ubuntu dentro de una máquina virtual de Oracle VirtualBox.

Durante el proyecto se instalaron, configuraron y probaron distintos servicios relacionados con la administración de sistemas operativos. Entre ellos se encuentran Apache, MySQL, cron, scripts Bash, Virtual Hosts, logs y monitoreo de recursos.

## Servidor web

Apache permitió alojar dos sitios web independientes dentro del mismo servidor:

- `empresa.local`
- `curso.local`

Cada sitio cuenta con su propio directorio, contenido HTML, estilos CSS, Virtual Host, dominio local y archivos de registro.

Las pruebas realizadas mediante `apache2ctl`, `systemctl`, `curl` y Firefox confirmaron que ambos dominios funcionan correctamente en el puerto 80.

## Base de datos

Se instaló MySQL y se creó la base de datos:

```text
aeromap_db
