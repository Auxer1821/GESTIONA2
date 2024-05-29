-- Tabla cliente
CREATE TABLE cliente (
    dni INT IDENTITY(1, 1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    apellido NVARCHAR(255) NOT NULL,
    fecha_registro DATETIME,
    telefono DECIMAL(18, 0),
    fecha_nacimiento DATETIME,
    ubicacion_id INT,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);
