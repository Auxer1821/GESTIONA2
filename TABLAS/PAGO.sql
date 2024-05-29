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
 
	