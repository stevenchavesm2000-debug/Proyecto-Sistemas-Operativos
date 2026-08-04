-- =============================================
-- DATOS DE PRUEBA - AEROMAP_DB
-- Proyecto: Sistemas Operativos
-- Autor: Yadiel Garcia
-- =============================================

USE aeromap_db;

-- =============================================
-- INSERTAR CLIENTES
-- =============================================
INSERT INTO clientes (nombre, apellido, email, telefono, empresa, direccion) VALUES
('Carlos', 'Rodríguez', 'carlos.rodriguez@agritech.com', '+506 8888-1001', 'AgriTech CR', 'San José, Costa Rica'),
('María', 'Fernández', 'maria.fernandez@topoland.com', '+506 8888-1002', 'TopoLand', 'Alajuela, Costa Rica'),
('Juan', 'Pérez', 'juan.perez@dronemap.com', '+506 8888-1003', 'DroneMap Solutions', 'Heredia, Costa Rica'),
('Laura', 'González', 'laura.gonzalez@geotech.com', '+506 8888-1004', 'GeoTech', 'Cartago, Costa Rica');

-- =============================================
-- INSERTAR SERVICIOS
-- =============================================
INSERT INTO servicios (nombre_servicio, descripcion, precio, duracion_estimada, requiere_drone, activo) VALUES
('Levantamiento Topográfico', 'Captura de datos topográficos con drones para generación de mapas precisos', 450.00, '1 día', TRUE, TRUE),
('Ortomosaico de Alta Resolución', 'Generación de ortomosaicos georreferenciados', 350.00, '2 horas', TRUE, TRUE),
('Agricultura de Precisión', 'Análisis de cultivos con índices NDVI y mapas de vegetación', 420.00, '4 horas', TRUE, TRUE),
('Capacitación en Drones', 'Curso teórico-práctico sobre operación de drones y fotogrametría', 300.00, '2 días', FALSE, TRUE);

-- =============================================
-- INSERTAR SOLICITUDES
-- =============================================
INSERT INTO solicitudes (id_cliente, id_servicio, fecha_requerida, ubicacion, hectareas, estado, observaciones) VALUES
(1, 3, '2026-08-15', 'San Carlos, Alajuela', 50.5, 'aprobada', 'Cultivo de piña - Requiere análisis NDVI'),
(2, 1, '2026-08-20', 'Pérez Zeledón, San José', 120.0, 'pendiente', 'Levantamiento para proyecto urbanístico'),
(3, 2, '2026-08-18', 'Santa Ana, San José', 25.0, 'en_progreso', 'Ortofoto para proyecto inmobiliario');

-- =============================================
-- INSERTAR USUARIOS
-- =============================================
INSERT INTO usuarios (nombre_usuario, contrasena, rol, id_cliente) VALUES
('admin', 'admin2026', 'admin', NULL),
('carlosr', 'carlos123', 'cliente', 1),
('mariaf', 'maria123', 'cliente', 2);

-- =============================================
-- MOSTRAR DATOS INSERTADOS
-- =============================================
SELECT '=== CLIENTES ===' AS '';
SELECT * FROM clientes;

SELECT '=== SERVICIOS ===' AS '';
SELECT * FROM servicios;

SELECT '=== SOLICITUDES ===' AS '';
SELECT * FROM solicitudes;

SELECT '=== USUARIOS ===' AS '';
SELECT * FROM usuarios;
