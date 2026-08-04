# Base de Datos - AeroMap Solutions

## Descripción

La base de datos `aeromap_db` almacena la información del sistema AeroMap Solutions, incluyendo clientes, servicios ofrecidos y solicitudes de servicios. Este sistema está diseñado para una empresa de topografía con drones y fotogrametría.

## Tecnologías Utilizadas

- **MySQL 8.4.10** - Sistema de gestión de bases de datos
- **SQL** - Lenguaje de consulta estructurado
- **Ubuntu 26.04** - Sistema operativo base

## Estructura de la Base de Datos

### Diagrama de Tablas
clientes servicios solicitudes

id_cliente (PK) id_servicio (PK) id_solicitud (PK)
nombre nombre_servicio id_cliente (FK)
apellido descripcion id_servicio (FK)
email precio fecha_solicitud
telefono duracion_estimada fecha_requerida
empresa requiere_drone ubicacion
direccion activo hectareas
fecha_registro estado
observaciones

usuarios

id_usuario (PK)
nombre_usuario
contrasena
rol
id_cliente (FK)
fecha_creacion


### Tabla: clientes

Almacena información de los clientes de AeroMap Solutions.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id_cliente | INT | Clave primaria, auto-incrementable |
| nombre | VARCHAR(100) | Nombre del cliente |
| apellido | VARCHAR(100) | Apellido del cliente |
| email | VARCHAR(100) | Correo electrónico (único) |
| telefono | VARCHAR(20) | Número de teléfono |
| empresa | VARCHAR(100) | Nombre de la empresa |
| direccion | VARCHAR(200) | Dirección física |
| fecha_registro | DATETIME | Fecha de registro (automática) |

### Tabla: servicios

Catálogo de servicios ofrecidos por la empresa.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id_servicio | INT | Clave primaria, auto-incrementable |
| nombre_servicio | VARCHAR(100) | Nombre del servicio |
| descripcion | TEXT | Descripción detallada |
| precio | DECIMAL(10,2) | Precio en dólares |
| duracion_estimada | VARCHAR(50) | Tiempo estimado de ejecución |
| requiere_drone | BOOLEAN | Indica si requiere drone |
| activo | BOOLEAN | Disponibilidad del servicio |

### Tabla: solicitudes

Registro de solicitudes de servicios realizadas por clientes.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id_solicitud | INT | Clave primaria, auto-incrementable |
| id_cliente | INT | Clave foránea a clientes |
| id_servicio | INT | Clave foránea a servicios |
| fecha_solicitud | DATETIME | Fecha de la solicitud (automática) |
| fecha_requerida | DATE | Fecha solicitada para el servicio |
| ubicacion | VARCHAR(200) | Ubicación donde se requiere el servicio |
| hectareas | DECIMAL(10,2) | Área en hectáreas (si aplica) |
| estado | ENUM | pendiente/aprobada/en_progreso/completada/cancelada |
| observaciones | TEXT | Comentarios adicionales |

### Tabla: usuarios

Control de acceso al sistema.

| Campo | Tipo | Descripción |
|-------|------|-------------|
| id_usuario | INT | Clave primaria, auto-incrementable |
| nombre_usuario | VARCHAR(50) | Nombre de usuario (único) |
| contrasena | VARCHAR(255) | Contraseña (sin hash en este ejemplo) |
| rol | ENUM | admin/operador/cliente |
| id_cliente | INT | Clave foránea a clientes (opcional) |
| fecha_creacion | DATETIME | Fecha de creación |

## Instalación y Configuración

### 1. Instalar MySQL

```bash
sudo apt update
sudo apt install mysql-server -y
sudo systemctl start mysql
sudo mysql_secure_installation
