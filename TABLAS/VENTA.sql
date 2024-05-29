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
