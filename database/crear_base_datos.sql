-- =============================================
-- BASE DE DATOS: AEROMAP_DB
-- Proyecto: Sistemas Operativos
-- Autor: Yadiel Garcia
-- =============================================

-- 1. Crear la base de datos
CREATE DATABASE IF NOT EXISTS aeromap_db;
USE aeromap_db;

-- =============================================
-- TABLA: clientes
-- =============================================
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    empresa VARCHAR(100),
    direccion VARCHAR(200),
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- TABLA: servicios
-- =============================================
CREATE TABLE IF NOT EXISTS servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    duracion_estimada VARCHAR(50),
    requiere_drone BOOLEAN DEFAULT TRUE,
    activo BOOLEAN DEFAULT TRUE
);

-- =============================================
-- TABLA: solicitudes
-- =============================================
CREATE TABLE IF NOT EXISTS solicitudes (
    id_solicitud INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_servicio INT NOT NULL,
    fecha_solicitud DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_requerida DATE NOT NULL,
    ubicacion VARCHAR(200),
    hectareas DECIMAL(10,2),
    estado ENUM('pendiente', 'aprobada', 'en_progreso', 'completada', 'cancelada') DEFAULT 'pendiente',
    observaciones TEXT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio) ON DELETE CASCADE
);

-- =============================================
-- TABLA: usuarios
-- =============================================
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    contrasena VARCHAR(255) NOT NULL,
    rol ENUM('admin', 'operador', 'cliente') DEFAULT 'cliente',
    id_cliente INT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente) ON DELETE SET NULL
);

SHOW TABLES;
