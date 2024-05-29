IF OBJECT_ID('promociones_aplicadas_al_detalle', 'U') IS NOT NULL
DROP TABLE promociones_aplicadas_al_detalle;

-- Tabla detalle
IF OBJECT_ID('detalle', 'U') IS NOT NULL
DROP TABLE detalle;

-- Tabla envio
IF OBJECT_ID('envio', 'U') IS NOT NULL
DROP TABLE envio;

-- Tabla estado_envio
IF OBJECT_ID('estado_envio', 'U') IS NOT NULL
DROP TABLE estado_envio;

-- Tabla ticket
IF OBJECT_ID('ticket', 'U') IS NOT NULL
DROP TABLE ticket;

-- Tabla detalle_tarjeta
IF OBJECT_ID('detalle_tarjeta', 'U') IS NOT NULL
DROP TABLE detalle_tarjeta;

-- Tabla pago
IF OBJECT_ID('pago', 'U') IS NOT NULL
DROP TABLE pago;

-- Tabla descuento_por_medio_de_pago_aplicado
IF OBJECT_ID('descuento_por_medio_de_pago_aplicado', 'U') IS NOT NULL
DROP TABLE descuento_por_medio_de_pago_aplicado;

-- Tabla definicion_descuento
IF OBJECT_ID('definicion_descuento', 'U') IS NOT NULL
DROP TABLE definicion_descuento;

-- Tabla medio_de_pago
IF OBJECT_ID('medio_de_pago', 'U') IS NOT NULL
DROP TABLE medio_de_pago;

-- Tabla tipo_medio_de_pago
IF OBJECT_ID('tipo_medio_de_pago', 'U') IS NOT NULL
DROP TABLE tipo_medio_de_pago;

--Tabla tarjeta
IF OBJECT_ID('tarjeta', 'U') IS NOT NULL
DROP TABLE tarjeta;

-- Tabla promocion_por_producto
IF OBJECT_ID('promocion_por_producto', 'U') IS NOT NULL
DROP TABLE promocion_por_producto;

-- Tabla promocion
IF OBJECT_ID('promocion', 'U') IS NOT NULL
DROP TABLE promocion;

-- Tabla regla
IF OBJECT_ID('regla', 'U') IS NOT NULL
DROP TABLE regla;

-- Tabla producto
IF OBJECT_ID('producto', 'U') IS NOT NULL
DROP TABLE producto;

-- Tabla marca
IF OBJECT_ID('marca', 'U') IS NOT NULL
DROP TABLE marca;

-- Tabla subcategoria
IF OBJECT_ID('subcategoria', 'U') IS NOT NULL
DROP TABLE subcategoria;

-- Tabla categoria
IF OBJECT_ID('categoria', 'U') IS NOT NULL
DROP TABLE categoria;

-- Tabla empleado
IF OBJECT_ID('empleado', 'U') IS NOT NULL
DROP TABLE empleado;

-- Tabla tipo_por_caja
IF OBJECT_ID('tipo_por_caja', 'U') IS NOT NULL
DROP TABLE tipo_por_caja;

-- Tabla tipo
IF OBJECT_ID('tipo', 'U') IS NOT NULL
DROP TABLE tipo;

-- Tabla caja
IF OBJECT_ID('caja', 'U') IS NOT NULL
DROP TABLE caja;

-- Tabla sucursal
IF OBJECT_ID('sucursal', 'U') IS NOT NULL
DROP TABLE sucursal;

-- Tabla supermercado
IF OBJECT_ID('supermercado', 'U') IS NOT NULL
DROP TABLE supermercado;

-- Tabla cliente
IF OBJECT_ID('cliente', 'U') IS NOT NULL
DROP TABLE cliente;

-- Tabla ubicacion
IF OBJECT_ID('ubicacion', 'U') IS NOT NULL
DROP TABLE ubicacion;

-- Tabla Domicilio
IF OBJECT_ID('Domicilio', 'U') IS NOT NULL
DROP TABLE Domicilio;

-- Tabla Localidad
IF OBJECT_ID('Localidad', 'U') IS NOT NULL
DROP TABLE Localidad;

-- Tabla Provincia
IF OBJECT_ID('Provincia', 'U') IS NOT NULL
DROP TABLE Provincia;


--Tabla Provincia
CREATE TABLE Provincia (
    provincia_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL
);

-- Tabla Localidad
CREATE TABLE Localidad (
    localidad_id INT IDENTITY(1,1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    provincia_id INT,
    FOREIGN KEY (provincia_id) REFERENCES Provincia(provincia_id)
);

-- Tabla Domicilio
CREATE TABLE Domicilio (
    domicilio_ID INT IDENTITY(1,1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL,
    localidad_id INT,
    FOREIGN KEY (localidad_id) REFERENCES Localidad(localidad_id)
);

-- Tabla Ubicacion
CREATE TABLE Ubicacion (
    ubicacion_ID INT IDENTITY(1,1) PRIMARY KEY,
    provincia_id INT,
    localidad_id INT,
    domicilio_id INT,
    FOREIGN KEY (provincia_id) REFERENCES Provincia(provincia_id),
    FOREIGN KEY (localidad_id) REFERENCES Localidad(localidad_id),
    FOREIGN KEY (domicilio_id) REFERENCES Domicilio(domicilio_id)
);

-- Tabla cliente
CREATE TABLE cliente (
    dni DECIMAL(18, 0) IDENTITY(1, 1) PRIMARY KEY,
    nombre NVARCHAR(255) NOT NULL,
    apellido NVARCHAR(255) NOT NULL,
    fecha_registro DATETIME  NOT NULL,
    telefono DECIMAL(18, 0),
    fecha_nacimiento DATETIME NOT NULL,
    ubicacion_id INT,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(ubicacion_id)
);

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

-- Tabla tipo_por_caja
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

--Tabla tarjeta
CREATE TABLE tarjeta (
    tarjeta_numero NVARCHAR(50) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL,
	dni DECIMAL(18, 0),
	FOREIGN KEY (dni) REFERENCES cliente(dni)
);


-- Tabla tipo_medio_de_pago
CREATE TABLE tipo_medio_de_pago (
    tipo_mdp_id INT IDENTITY(1, 1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL
);

-- Tabla  medio_de_pago
CREATE TABLE medio_de_pago (
    mdp_id INT IDENTITY(1, 1) PRIMARY KEY,
    tipo_mdp_id INT,
    FOREIGN KEY (tipo_mdp_id) REFERENCES tipo_medio_de_pago(tipo_mdp_id)
);

-- Tabla definicion_descuento
CREATE TABLE definicion_descuento (
    definicion_id INT IDENTITY(1, 1) PRIMARY KEY,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    porcentaje_descuento DECIMAL(18, 2),
	tope DECIMAL(18, 2),
    descripcion NVARCHAR(255),
);

-- Tabla descuento_por_medio_de_pago_aplicado
CREATE TABLE descuento_por_medio_de_pago_aplicado (
    dpmdpa_id INT IDENTITY(1, 1) PRIMARY KEY,
    definicion_id INT,
    mdp_id INT,
    FOREIGN KEY (mdp_id) REFERENCES medio_de_pago(mdp_id),
	FOREIGN KEY (definicion_id) REFERENCES definicion_descuento(definicion_id)
);

-- Tabla pago
CREATE TABLE pago (
    pago_id INT PRIMARY KEY,
    fecha DATETIME,
    importe DECIMAL(18, 2),
    mdp_id INT,
	dpmdpa_id INT,
    FOREIGN KEY (dpmdpa_id) REFERENCES descuento_por_medio_de_pago_aplicado(dpmdpa_id),
    FOREIGN KEY (mdp_id) REFERENCES medio_de_pago(mdp_id)
);

-- Tabla detalle_tarjeta
CREATE TABLE detalle_tarjeta (
    tarjeta_numero NVARCHAR(50),
    cuotas DECIMAL(18, 0),
    pago_id INT PRIMARY KEY,
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id),
	FOREIGN KEY (tarjeta_numero) REFERENCES tarjeta(tarjeta_numero) 
);
	
-- Tabla ticket
CREATE TABLE ticket (
    ticket_numero INT IDENTITY(1, 1) PRIMARY KEY,
    fecha_hora DATETIME,
    tipo_comprobante NVARCHAR(255),
    subtotal_productos DECIMAL(18, 2),
    total_descuento_aplicado DECIMAL(18, 2),
	total_descuento_aplicado_mp DECIMAL(18, 2),
	total_ticket DECIMAL(18, 2),
    caja_numero INT,
	sucursal_id INT,
	pago_id INT,
    FOREIGN KEY (caja_numero, sucursal_id) REFERENCES caja(caja_numero, sucursal_id),
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id)
);
-- Tabla estado_envio
CREATE TABLE estado_envio (
    estado_envio_id INT IDENTITY(1, 1) PRIMARY KEY,
    descripcion NVARCHAR(255) NOT NULL
);
-- Tabla envio
CREATE TABLE envio (
    envio_numero INT IDENTITY(1, 1) PRIMARY KEY,
	costo DECIMAL(18, 2),
    fecha_programada DATETIME,
    hora_inicio DECIMAL(18, 0),
    hora_fin DECIMAL(18, 0),
    fecha_entrega DATE,
    ticket_numero INT NOT NULL,
	estado_envio_id INT,
	dni DECIMAL(18, 0),
    FOREIGN KEY (ticket_numero) REFERENCES ticket(ticket_numero),
	FOREIGN KEY (estado_envio_id) REFERENCES estado_envio(estado_envio_id),
	FOREIGN KEY (dni) REFERENCES cliente(dni),
);
-- Tabla detalle
CREATE TABLE detalle (
    producto_codigo INT,
    ticket_numero INT,
    cantidad INT,
    precio_unitario DECIMAL(18, 2),
	total DECIMAL(18, 2),
    PRIMARY KEY (producto_codigo, ticket_numero),
    FOREIGN KEY (producto_codigo) REFERENCES producto(producto_codigo) ,
    FOREIGN KEY (ticket_numero) REFERENCES ticket(ticket_numero),
);
-- Tabla promociones_aplicadas_al_detalle
CREATE TABLE promociones_aplicadas_al_detalle (
    codigo_promocion INT,
    producto_codigo INT,
    ticket_numero INT,
    PRIMARY KEY (codigo_promocion, producto_codigo, ticket_numero),
    FOREIGN KEY (producto_codigo, codigo_promocion) REFERENCES  promocion_por_producto(producto_codigo, codigo_promocion),
    FOREIGN KEY (ticket_numero) REFERENCES ticket(ticket_numero) 
);
