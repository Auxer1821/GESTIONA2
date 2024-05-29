
-- Tabla categoria
CREATE TABLE categoria (
    categoria_id INT IDENTITY(1, 1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL
);

-- Tabla subcategoria
CREATE TABLE subcategoria (
    subcategoria_id INT IDENTITY(1, 1) PRIMARY KEY,
    categoria_id INT,
    descripcion NVARCHAR(255) NOT NULL,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

-- Tabla marca
CREATE TABLE marca (
    marca_id INT IDENTITY(1, 1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL
);

-- Tabla producto
CREATE TABLE producto (
    producto_codigo INT IDENTITY(1, 1) PRIMARY KEY,
	nombre NVARCHAR(255) NOT NULL,
    subcategoria_id INT,
    descripcion NVARCHAR(255) NOT NULL,
    precio_unitario DECIMAL(18, 2),
    marca_id INT,
    FOREIGN KEY (subcategoria_id) REFERENCES subcategoria(subcategoria_id),
    FOREIGN KEY (marca_id) REFERENCES marca(marca_id)
);

-- Tabla regla
CREATE TABLE regla (
    regla_id INT IDENTITY(1, 1) PRIMARY KEY,
    misma_marca DECIMAL(18, 0),
    misma_producto DECIMAL(18, 0),
    cant_aplica_descuento DECIMAL(18, 0),
    cant_aplica_regla DECIMAL(18, 0),
    cant_max_prod DECIMAL(18, 0),
    descripcion NVARCHAR(255),
    descuento_aplicable_prod DECIMAL(18, 2)
);

-- Tabla promocion
CREATE TABLE promocion (
    codigo_promocion INT IDENTITY(1, 1) PRIMARY KEY,
    aplica_descuento NVARCHAR(255),
    descripcion NVARCHAR(255),
    fecha_inicio DATETIME,
	fecha_fin DATETIME,
    regla_id INT,
    FOREIGN KEY (regla_id) REFERENCES regla(regla_id)
);

-- Tabla promocion_por_producto
CREATE TABLE promocion_por_producto (
    producto_codigo INT,
    codigo_promocion INT,
    PRIMARY KEY (producto_codigo, codigo_promocion),
    FOREIGN KEY (producto_codigo) REFERENCES producto(producto_codigo),
    FOREIGN KEY (codigo_promocion) REFERENCES promocion(codigo_promocion)
);