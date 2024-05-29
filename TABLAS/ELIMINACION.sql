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