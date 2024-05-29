-- Tabla supermercado
CREATE TABLE supermercado (
    super_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    razon_soc NVARCHAR(255),
    reg_impositiva NVARCHAR(255),
    condicion_fiscal NVARCHAR(255),
    ubicacion_id INT,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);

-- Tabla sucursal
CREATE TABLE sucursal (
    sucursal_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    ubicacion_id INT,
    super_id INT,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id),
    FOREIGN KEY (super_id) REFERENCES supermercado(super_id)
);

-- Tabla caja
CREATE TABLE caja (
    caja_numero INT IDENTITY(1,1),
    sucursal_id INT,
    PRIMARY KEY (caja_numero, sucursal_id),
    FOREIGN KEY (sucursal_id) REFERENCES sucursal(sucursal_id)
);

-- Tabla tipo
CREATE TABLE tipo (
    tipo_id INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL
);

-- Tabla tipoporcaja
CREATE TABLE tipo_por_caja (
    tipo_id INT,
    caja_numero INT,
	sucursal_id INT,
    PRIMARY KEY (tipo_id, caja_numero, sucursal_id),
    FOREIGN KEY (tipo_id) REFERENCES tipo(tipo_id) ,
	FOREIGN KEY (caja_numero, sucursal_id) REFERENCES caja(caja_numero, sucursal_id)
);
-- Tabla empleado
CREATE TABLE empleado (
    legajo_empleado INT IDENTITY(1,1) PRIMARY KEY,
	dni DECIMAL(18, 0),
    nombre NVARCHAR(255) NOT NULL,
    apellido NVARCHAR(255) NOT NULL,
    fecha_registro DATETIME,
    telefono DECIMAL(18, 0),
	mail NVARCHAR(255),
    fecha_nacimiento DATETIME,
    sucursal_id INT,
    FOREIGN KEY (sucursal_id) REFERENCES sucursal(sucursal_id)
);


