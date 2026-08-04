# Sitio Informativo - curso.local

## Descripción del Sitio

El sitio `curso.local` es un portal educativo diseñado para proporcionar información sobre drones, fotogrametría y topografía. Este sitio forma parte del proyecto AeroMap Solutions y está alojado en el servidor Apache configurado en Ubuntu.

## Estructura del Sitio

El sitio contiene las siguientes secciones:

1. **Inicio**: Página principal con introducción al mundo de los drones y la fotogrametría
2. **Fotogrametría**: Explicación detallada de la ciencia y sus aplicaciones
3. **Planificación de Vuelos**: Metodología para planificar vuelos con drones
4. **Procesamiento de Imágenes**: Pasos del procesamiento fotogramétrico
5. **Ortomosaicos y Modelos**: Creación de ortomosaicos y modelos digitales
6. **Agricultura de Precisión**: Aplicaciones en el sector agrícola
7. **Descripción del Proyecto**: Información sobre AeroMap Solutions
8. **Contacto**: Datos de contacto del equipo

## Tecnologías Utilizadas

- **HTML5**: Estructura semántica del sitio
- **CSS3**: Estilos modernos y responsive design
- **Apache 2.4**: Servidor web
- **Virtual Host**: Configuración personalizada para `curso.local`

## Configuración del Virtual Host

El archivo de configuración `curso.local.conf` se encuentra en la carpeta `apache/`. La configuración establece:

- Puerto: 80 (HTTP)
- ServerName: curso.local
- DocumentRoot: /var/www/curso.local
- Logs personalizados para acceso y errores

## Instalación y Despliegue

1. Copiar los archivos del sitio a `/var/www/curso.local`
2. Habilitar el Virtual Host:
   ```bash
   sudo a2ensite curso.local.conf
   sudo systemctl reload apache2
