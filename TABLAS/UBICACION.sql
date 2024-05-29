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
