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
    aplica_descuento decimal(18,2),
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
    FOREIGN KEY (caja_numero, sucursal_id) REFERENCES caja(caja_numero, sucursal_id)
);

-- Tabla pago
CREATE TABLE pago (
    pago_id INT PRIMARY KEY,
    fecha DATETIME,
    importe DECIMAL(18, 2),
    mdp_id INT,
	dpmdpa_id INT,
	ticket_numero int,
    FOREIGN KEY (dpmdpa_id) REFERENCES descuento_por_medio_de_pago_aplicado(dpmdpa_id),
    FOREIGN KEY (mdp_id) REFERENCES medio_de_pago(mdp_id),
	FOREIGN KEY (ticket_numero) REFERENCES ticket(ticket_numero)
);
-- Tabla detalle_tarjeta
CREATE TABLE detalle_tarjeta (
    tarjeta_numero NVARCHAR(50),
    cuotas DECIMAL(18, 0),
    pago_id INT PRIMARY KEY,
    FOREIGN KEY (pago_id) REFERENCES pago(pago_id),
	FOREIGN KEY (tarjeta_numero) REFERENCES tarjeta(tarjeta_numero) 
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


-----------------------------------------------------DETALLES
CREATE PROCEDURE ActualizarSubtotalTicket
    @TicketNumero INT
AS
BEGIN
    -- Recalcular el subtotal_productos para el ticket especificado
    UPDATE t
    SET subtotal_productos = (
        SELECT SUM(total)
        FROM detalle
        WHERE ticket_numero = @TicketNumero
    )
    FROM ticket t
    WHERE t.ticket_numero = @TicketNumero;
END;


CREATE TRIGGER modificar_subtotal_ticket_al_insertar_detalle
ON detalle
AFTER INSERT
AS
BEGIN
    DECLARE @TicketNumero INT;
    
    -- Obtener el ticket_numero de los registros insertados
    SELECT @TicketNumero = ticket_numero FROM inserted;
    
    -- Llamar al procedimiento para actualizar el subtotal
    EXEC ActualizarSubtotalTicket @TicketNumero;
END;



CREATE TRIGGER calcular_total_y_subtotal_actualizar
ON detalle
AFTER UPDATE
AS
BEGIN
    DECLARE @TicketNumero INT;
    
    -- Actualización de la tabla 'detalle' con el nuevo total
    UPDATE d
    SET d.total = i.precio_unitario * i.cantidad
    FROM detalle d
    JOIN inserted i ON d.producto_codigo = i.producto_codigo
                   AND d.ticket_numero = i.ticket_numero;

    -- Obtener el ticket_numero de los registros actualizados
    SELECT @TicketNumero = ticket_numero FROM inserted;
    
    -- Llamar al procedimiento para actualizar el subtotal
    EXEC ActualizarSubtotalTicket @TicketNumero;
END;

CREATE TRIGGER ajustar_detalle_precio_unitario_y_total
ON detalle
INSTEAD OF INSERT
AS
BEGIN
	-- Insertar en la tabla 'detalle' ajustando el precio_unitario y 
    INSERT INTO detalle (producto_codigo, ticket_numero, cantidad, precio_unitario, total)
    SELECT 
        i.producto_codigo,
        i.ticket_numero,
        ISNULL(i.cantidad, 0),
        ISNULL(i.precio_unitario, 0),
        ISNULL(i.cantidad * i.precio_unitario, 0)
    FROM inserted i
END; 

CREATE TRIGGER eliminar_detalle_modificar_ticket
ON detalle
AFTER DELETE
AS
BEGIN
    DECLARE @TicketNumero INT;
    
    -- Obtener el ticket_numero de los registros eliminados
    SELECT @TicketNumero = ticket_numero FROM deleted;
    
    -- Llamar al procedimiento para actualizar el subtotal
    EXEC ActualizarSubtotalTicket @TicketNumero;
END;

CREATE TRIGGER ticket_total
ON ticket
AFTER UPDATE
AS
BEGIN
	UPDATE ticket
	SET total_ticket = ISNULL(subtotal_productos, 0) - ISNULL(total_descuento_aplicado, 0) - ISNULL(total_descuento_aplicado_mp, 0)
END;


-------------------------------------------------PROMOCIONES
CREATE FUNCTION dbo.Minimo(@num1 INT, @num2 INT)
RETURNS INT
AS
BEGIN
    DECLARE @min INT;
    
    IF @num1 < @num2
        SET @min = @num1;
    ELSE
        SET @min = @num2;
    
    RETURN @min;
END;

CREATE TRIGGER insert_promocion_aplicada_detalle
ON promociones_aplicadas_al_detalle
AFTER INSERT
AS
BEGIN
     -- Actualización de la tabla 'ticket' con el nuevo subtotal_productos. 
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado +  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN inserted i ON t.ticket_numero = i.ticket_numero
	join promocion p on p.codigo_promocion = i.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = i.producto_codigo
	join detalle d on d.producto_codigo = i.producto_codigo
                   AND d.ticket_numero = i.ticket_numero;
	
END;

/*
CREATE TRIGGER update_promocion_aplicada_detalle
ON promociones_aplicadas_al_detalle
AFTER UPDATE
AS
BEGIN
     -- Actualización de la tabla 'ticket' con el nuevo subtotal_productos. 
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado -  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN deleted dl ON t.ticket_numero = dl.ticket_numero
	join promocion p on p.codigo_promocion = dl.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = dl.producto_codigo
	join detalle d on d.producto_codigo = dl.producto_codigo
                   AND d.ticket_numero = dl.ticket_numero;
    
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado +  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN inserted i ON t.ticket_numero = i.ticket_numero
	join promocion p on p.codigo_promocion = i.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = i.producto_codigo
	join detalle d on d.producto_codigo = i.producto_codigo
                   AND d.ticket_numero = i.ticket_numero;
END;*/

CREATE TRIGGER delete_promocion_aplicada_detalle
ON promociones_aplicadas_al_detalle
AFTER delete
AS
BEGIN
    UPDATE t
    SET t.total_descuento_aplicado = t.total_descuento_aplicado -  dbo.Minimo(r.cant_max_prod, cast((d.cantidad/r.cant_aplica_regla) as int)) * 
																	r.cant_aplica_descuento * 
																	( r.descuento_aplicable_prod/100) * d.precio_unitario
    FROM ticket t
    JOIN deleted dl ON t.ticket_numero = dl.ticket_numero
	join promocion p on p.codigo_promocion = dl.codigo_promocion
	join regla r on r.regla_id = p.regla_id
	join producto pr on pr.producto_codigo = dl.producto_codigo
	join detalle d on d.producto_codigo = dl.producto_codigo
                   AND d.ticket_numero = dl.ticket_numero;
  end; 
------------------------------------------------------PAGO
CREATE TRIGGER	pago_insert
ON pago
AFTER INSERT
AS
BEGIN
		UPDATE t 
		SET total_descuento_aplicado_mp += dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100)
		FROM ticket t
		JOIN inserted i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id
END;

CREATE TRIGGER	pago_update
ON pago
AFTER UPDATE
AS
BEGIN
		UPDATE t 
		SET total_descuento_aplicado_mp +=  dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100)
		FROM ticket t
		JOIN inserted i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id

		UPDATE t 
		SET total_descuento_aplicado_mp -= dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
		FROM ticket t
		JOIN DELETED i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id
END;

CREATE TRIGGER	pago_delete
ON pago
AFTER delete
AS
BEGIN
		UPDATE ticket 
		SET total_descuento_aplicado_mp -=dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
		FROM ticket t
		JOIN DELETED i ON i.ticket_numero = t.ticket_numero
		JOIN descuento_por_medio_de_pago_aplicado mpa ON i.dpmdpa_id = mpa.dpmdpa_id
		JOIN definicion_descuento dd ON dd.definicion_id = mpa.definicion_id
END;
-------------------------------------------------------------------definicion_descuento

CREATE TRIGGER definicion_descuento_update
ON definicion_descuento
AFTER UPDATE
AS
BEGIN
	UPDATE t
	SET total_descuento_aplicado_mp += dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
	FROM ticket t
	JOIN pago p ON p.ticket_numero = t.ticket_numero
	JOIN descuento_por_medio_de_pago_aplicado dpmdpa ON dpmdpa.dpmdpa_id = p.dpmdpa_id
	JOIN inserted i ON i.definicion_id = dpmdpa.definicion_id

	UPDATE t
	SET total_descuento_aplicado_mp -= dbo.Minimo(dd.tope, i.importe) * (dd.porcentaje_descuento/100) 
	FROM ticket t
	JOIN pago p ON p.ticket_numero = t.ticket_numero
	JOIN descuento_por_medio_de_pago_aplicado dpmdpa ON dpmdpa.dpmdpa_id = p.dpmdpa_id
	JOIN deleted i ON i.definicion_id = dpmdpa.definicion_id
END;