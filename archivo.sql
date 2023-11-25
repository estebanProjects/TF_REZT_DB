
-- Crear tabla Establecimientos
CREATE TABLE Establecimientos (
    EstablecimientoID INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Ubicacion VARCHAR(255)
);
-- Crear tabla Mesas
CREATE TABLE Mesas (
    MesaID INT PRIMARY KEY,
    NumeroMesa INT,
    EstablecimientoID INT,
    FOREIGN KEY (EstablecimientoID) REFERENCES Establecimientos(EstablecimientoID)
);


-- Crear tabla Usuarios
CREATE TABLE Usuarios (
    UsuarioID INT PRIMARY KEY,
    Nombre VARCHAR(255),
    CorreoElectronico VARCHAR(255),
    Contrasena VARCHAR(255),
    MesaAsignadaID INT,
    FOREIGN KEY (MesaAsignadaID) REFERENCES Mesas(MesaID)
);

CREATE TABLE Tarjetas (
    TarjetaID INT PRIMARY KEY,
    NumeroTarjeta VARCHAR(16) NOT NULL,
    FechaVencimiento VARCHAR(7) NOT NULL, -- Formato MM/YYYY
    CVV VARCHAR(3) NOT NULL, -- Código de seguridad de la tarjeta
    UsuarioID INT,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)
);

-- Crear tabla Pedidos
CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY,
    UsuarioID INT,
    EstablecimientoID INT,
    MesaID INT,
    FechaHoraPedido DATETIME,
    EstadoPedido VARCHAR(50),
    DetalleFinanciero DECIMAL(10,2),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (EstablecimientoID) REFERENCES Establecimientos(EstablecimientoID),
    FOREIGN KEY (MesaID) REFERENCES Mesas(MesaID)
);


-- Crear tabla Categorias
CREATE TABLE Categorias (
    CategoriaID INT PRIMARY KEY,
    NombreCategoria VARCHAR(255)
);
-- Crear tabla Productos
CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY,
    Nombre VARCHAR(255),
    Precio DECIMAL(10,2),
    EstablecimientoID INT,
    CategoriaID INT,
    FOREIGN KEY (EstablecimientoID) REFERENCES Establecimientos(EstablecimientoID),
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)
);

-- Crear tabla Promociones
CREATE TABLE Promociones (
    PromocionID INT PRIMARY KEY,
    EstablecimientoID INT,
    Descuento DECIMAL(5,2),
    FechaInicioFin DATETIME,
    FOREIGN KEY (EstablecimientoID) REFERENCES Establecimientos(EstablecimientoID)
);

-- Crear tabla Valoraciones
CREATE TABLE Valoraciones (
    ValoracionID INT PRIMARY KEY,
    UsuarioID INT,
    EstablecimientoID INT,
    Comentario TEXT,
    Puntuacion INT,
    FechaValoracion DATETIME,
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (EstablecimientoID) REFERENCES Establecimientos(EstablecimientoID)
);

/***************************************************/
/***************************************************/
-- Crear tabla Roles
CREATE TABLE Roles (
    RolID INT PRIMARY KEY,
    NombreRol VARCHAR(50)
);

-- Insertar roles iniciales
INSERT INTO Roles (RolID, NombreRol) VALUES
(1, 'Consumidor'),
(2, 'Dueño');

-- Modificar tabla Usuarios
ALTER TABLE Usuarios
ADD RolID INT;

-- Agregar valores iniciales a la columna RolID si es necesario
-- UPDATE Usuarios SET RolID = 1;  -- Consumidor
-- UPDATE Usuarios SET RolID = 2 WHERE AlgunCriterio;  -- Dueño

-- Agregar la restricción de clave externa (foreign key)
ALTER TABLE Usuarios
ADD CONSTRAINT FK_Usuarios_Roles
FOREIGN KEY (RolID) REFERENCES Roles(RolID);

-- Crear tabla Publicidad
CREATE TABLE Publicidad (
    PublicidadID INT PRIMARY KEY,
    EstablecimientoID INT,
    Contenido TEXT,
    FechaInicioFin DATETIME,
    FOREIGN KEY (EstablecimientoID) REFERENCES Establecimientos(EstablecimientoID)
);

/**************************************************/
/*************************************************/
-- Insertar datos en la tabla Establecimientos con nombres de departamentos del Perú
INSERT INTO Establecimientos (EstablecimientoID, Nombre, Ubicacion)
VALUES 
    (1, 'Restaurante Uno', 'Lima'),
    (2, 'Cafetería Dos', 'Arequipa'),
    (3, 'Pizzería Tres', 'Cusco'),
    (4, 'Nombre Cuatro', 'Piura'), 
    (5, 'Nombre Cinco', 'Junín'),   
    (6, 'Nombre Seis', 'Lambayeque'),    
    (7, 'Parrilla Siete', 'Tacna'),
    (8, 'Bar Ocho', 'Callao'),
    (9, 'Taquería Nueve', 'La Libertad'),
    (10, 'Sushi Diez', 'Amazonas'),
    (11, 'Cafetería Once', 'Ucayali'),
    (12, 'Pizzería Doce', 'Ayacucho'),
    (13, 'Vegano Trece', 'Ica'),
    (14, 'Restaurante Catorce', 'Ancash'),
    (15, 'Cervecería Quince', 'Madre de Dios'),
    (16, 'Buffet Dieciséis', 'San Martín'),
    (17, 'Asador Diecisiete', 'Loreto'),
    (18, 'Bar de Vinos Dieciocho', 'Huánuco'),
    (19, 'Pastelería Diecinueve', 'Pasco'),
    (20, 'Cocina Fusión Veinte', 'Moquegua');

-- Insertar datos de mesas
INSERT INTO Mesas (MesaID, NumeroMesa, EstablecimientoID)
VALUES 
    (1, 101, 1),
    (2, 102, 1),
    (3, 201, 2),
    (4, 301, 3),
    (5, 401, 4),
    (6, 501, 5),
    (7, 401, 7),
    (8, 201, 8),
    (9, 101, 9),
    (10, 301, 10),
    (11, 501, 11),
    (12, 601, 12),
    (13, 701, 13),
    (14, 801, 14),
    (15, 901, 15),
    (16, 501, 16),
    (17, 201, 17),
    (18, 301, 18),
    (19, 401, 19),
    (20, 601, 20);

-- Insertar datos de Consumidores con valores explícitos para UsuarioID y asignación de mesas
INSERT INTO Usuarios (UsuarioID, Nombre, CorreoElectronico, Contrasena, RolID)
VALUES 
    (1, 'Consumidor1', 'consumidor1@example.com', 'contrasena1', 1),
    (2, 'Consumidor2', 'consumidor2@example.com', 'contrasena2', 1),
    (3, 'Consumidor3', 'consumidor3@example.com', 'contrasena3', 1),
    (4, 'Usuario4', 'usuario4@example.com', 'contrasena4', 1),
    (5, 'Usuario5', 'usuario5@example.com', 'contrasena5', 1),
    (6, 'Usuario6', 'usuario6@example.com', 'contrasena6', 1),
    (7, 'Usuario7', 'usuario7@example.com', 'contrasena7', 1),
    (8, 'Usuario8', 'usuario8@example.com', 'contrasena8', 1),
    (9, 'Usuario9', 'usuario9@example.com', 'contrasena9', 1),
    (10, 'Dueño3', 'dueno3@example.com', 'contrasena10', 2),
    (11, 'Usuario11', 'usuario11@example.com', 'contrasena11', 1),
    (12, 'Usuario12', 'usuario12@example.com', 'contrasena12', 1),
    (13, 'Usuario13', 'usuario13@example.com', 'contrasena13', 1),
    (14, 'Dueño4', 'dueno4@example.com', 'contrasena14', 2),
    (15, 'Usuario15', 'usuario15@example.com', 'contrasena15', 1),
    (16, 'Usuario16', 'usuario16@example.com', 'contrasena16', 1),
    (17, 'Usuario17', 'usuario17@example.com', 'contrasena17', 1),
    (18, 'Dueño5', 'dueno5@example.com', 'contrasena18', 2),
    (19, 'Usuario19', 'usuario19@example.com', 'contrasena19', 1),
    (20, 'Usuario20', 'usuario20@example.com', 'contrasena20', 1);


-- Insertar datos en la tabla Publicidad
INSERT INTO Publicidad (PublicidadID, EstablecimientoID, Contenido, FechaInicioFin)
VALUES
    (1, 1, '¡Descuento del 20% en todos los platillos!', '2023-11-25 00:00:00'),
    (2, 2, '¡Happy hour de 5 PM a 7 PM!', '2023-11-30 00:00:00'),
    (3, 3, 'Texto de la publicidad 3', '2023-12-03 00:00:00'),
    (4, 4, 'Texto de la publicidad 4', '2023-12-07 00:00:00'),
    (5, 5, '¡Oferta especial en cervezas!', '2023-12-01 00:00:00'),
    (6, 6, '¡Pizza del día a mitad de precio!', '2023-12-05 00:00:00'),
    (7, 7, '¡Descubre nuestros platillos veganos!', '2023-12-10 00:00:00'),
    (8, 8, '¡Hora feliz en vinos de la casa!', '2023-12-15 00:00:00'),
    (9, 9, '¡Martes de tacos a $1!', '2023-12-20 00:00:00'),
    (10, 10, '¡Sushi fresco y variado!', '2023-12-25 00:00:00'),
    (11, 11, '¡Café y pastelería para tu día!', '2023-12-30 00:00:00'),
    (12, 12, '¡Pizza gourmet con descuento!', '2024-01-05 00:00:00'),
    (13, 13, '¡Experiencia vegana única!', '2024-01-10 00:00:00'),
    (14, 14, '¡Menú especial para eventos!', '2024-01-15 00:00:00'),
    (15, 15, '¡Asados de calidad para tu reunión!', '2024-01-20 00:00:00'),
    (16, 16, '¡Variedad en vinos para todos los gustos!', '2024-01-25 00:00:00'),
    (17, 17, '¡Postres artesanales y deliciosos!', '2024-02-01 00:00:00'),
    (18, 18, '¡Fusión de sabores en cada platillo!', '2024-02-05 00:00:00'),
    (19, 19, '¡Dulces tentaciones para tu paladar!', '2024-02-10 00:00:00'),
    (20, 20, '¡Platos únicos en nuestra cocina!', '2024-02-15 00:00:00');

-- Insertar datos en la tabla Tarjetas
INSERT INTO Tarjetas (TarjetaID, NumeroTarjeta, FechaVencimiento, CVV, UsuarioID)
VALUES
(1, '1234567890123456', '12/25', '123', 1),
(2, '9876543210987654', '06/24', '456', 2),
(3, '3333444455556666', '03/23', '111', 3),
(4, '4444555566667777', '07/22', '222', 4),
(5, '1111222233334444', '09/23', '789', 5),
(6, '5555666677778888', '03/22', '456', 6),
(7, '9999888877776666', '12/24', '123', 7),
(8, '1234123412341234', '06/25', '567', 8),
(9, '9876987698769876', '01/24', '890', 9),
(10, '4567456745674567', '08/23', '234', 10),
(11, '1111222233334444', '09/23', '789', 11),
(12, '5555666677778888', '03/22', '456', 12),
(13, '9999888877776666', '12/24', '123', 13),
(14, '1234123412341234', '06/25', '567', 14),
(15, '9876987698769876', '01/24', '890', 15),
(16, '4567456745674567', '08/23', '234', 16),
(17, '1111222233334444', '09/23', '789', 17),
(18, '5555666677778888', '03/22', '456', 18),
(19, '9999888877776666', '12/24', '123', 19),
(20, '1234123412341234', '06/25', '567', 20);

-- Insertar datos en la tabla Valoraciones
INSERT INTO Valoraciones (ValoracionID, UsuarioID, EstablecimientoID, Comentario, Puntuacion, FechaValoracion)
VALUES
(1, 1, 1, 'Excelente comida y servicio', 5, '2023-11-25 14:30:00'),
(2, 2, 2, 'Ambiente agradable, pero la comida puede mejorar', 3, '2023-11-26 12:45:00'),
(3, 3, 3, 'Buen lugar, pero podría mejorar la atención', 4, '2023-12-01 16:00:00'),
(4, 4, 4, 'Experiencia agradable en general', 3, '2023-12-02 14:30:00'),
(5, 5, 5, '¡Gran parrillada!', 5, '2023-12-03 12:45:00'),
(6, 6, 6, 'Ambiente animado, buenas bebidas', 4, '2023-12-04 18:00:00'),
(7, 7, 7, '¡Gran parrillada!', 5, '2023-12-02 14:30:00'),
(8, 8, 8, 'Ambiente animado, buenas bebidas', 4, '2023-12-03 12:45:00'),
(9, 9, 9, 'Auténticos tacos mexicanos', 5, '2023-12-04 18:00:00'),
(10, 10, 10, 'Sushi fresco y bien presentado', 4, '2023-12-05 20:15:00'),
(11, 11, 11, 'Café de alta calidad', 5, '2023-12-06 09:30:00'),
(12, 12, 12, 'Pizza con ingredientes premium', 4, '2023-12-07 19:45:00'),
(13, 13, 13, 'Platos veganos deliciosos', 5, '2023-12-08 15:00:00'),
(14, 14, 14, 'Menú variado y exquisito', 4, '2023-12-09 13:15:00'),
(15, 15, 15, 'Amplia selección de cervezas', 5, '2023-12-10 17:30:00'),
(16, 16, 16, 'Buffet con opciones para todos', 4, '2023-12-11 11:45:00'),
(17, 17, 17, 'Asado argentino de calidad', 5, '2023-12-12 14:30:00'),
(18, 18, 18, 'Vinos excelentes a buen precio', 4, '2023-12-13 18:00:00'),
(19, 19, 19, 'Postres artesanales y deliciosos', 5, '2023-12-14 20:15:00'),
(20, 20, 20, 'Fusión de sabores única', 4, '2023-12-15 12:45:00');

-- Insertar datos en la tabla Categorias
INSERT INTO Categorias (CategoriaID, NombreCategoria)
VALUES 
    (1, 'Entradas'),
    (2, 'Platos Principales'),
    (3, 'Postres'),
    (4, 'Aperitivos'),
    (5, 'Café'),
    (6, 'Pizza'),
    (7, 'Bebidas Alcohólicas'),
    (8, 'Bocadillos'),
    (9, 'Desayunos'),
    (10, 'Comida Rápida'),
    (11, 'Ensaladas'),
    (12, 'Parrilladas'),
    (13, 'Sushi'),
    (14, 'Postres'),
    (15, 'Vegano'),
    (16, 'Cervezas Artesanales'),
    (17, 'Buffet'),
    (18, 'Asados'),
    (19, 'Vinos'),
    (20, 'Repostería');

-- Insertar datos en la tabla Pedidos
INSERT INTO Pedidos (PedidoID, UsuarioID, EstablecimientoID, MesaID, FechaHoraPedido, EstadoPedido, DetalleFinanciero)
VALUES 
    (1, 1, 1, 1, '2023-11-25 12:00:00', 'En proceso', 30.50),
    (2, 2, 1, 2, '2023-11-25 12:30:00', 'Entregado', 45.75),
    (3, 3, 2, 3, '2023-11-25 13:00:00', 'En proceso', 22.00),
    (4, 4, 4, 4, '2023-12-16 13:30:00', 'En proceso', 18.75),
    (5, 5, 5, 5, '2023-12-17 14:00:00', 'Entregado', 15.99),
    (6, 6, 6, 6, '2023-12-18 14:30:00', 'En proceso', 28.00),
    (7, 7, 7, 7, '2023-12-16 13:00:00', 'En proceso', 25.50),
    (8, 8, 8, 8, '2023-12-17 14:30:00', 'Entregado', 40.25),
    (9, 9, 9, 9, '2023-12-18 18:00:00', 'En proceso', 15.75),
    (10, 10, 10, 10, '2023-12-19 20:15:00', 'Entregado', 22.50),
    (11, 11, 11, 11, '2023-12-20 09:30:00', 'En proceso', 30.00),
    (12, 12, 12, 12, '2023-12-21 19:45:00', 'Entregado', 18.25),
    (13, 13, 13, 13, '2023-12-22 15:00:00', 'En proceso', 27.80),
    (14, 14, 14, 14, '2023-12-23 13:15:00', 'Entregado', 35.90),
    (15, 15, 15, 15, '2023-12-24 17:30:00', 'En proceso', 20.50),
    (16, 16, 16, 16, '2023-12-25 11:45:00', 'Entregado', 42.75),
    (17, 17, 17, 17, '2023-12-26 14:30:00', 'En proceso', 28.40),
    (18, 18, 18, 18, '2023-12-27 18:00:00', 'Entregado', 15.90),
    (19, 19, 19, 19, '2023-12-28 20:15:00', 'En proceso', 33.25),
    (20, 20, 20, 20, '2023-12-29 12:45:00', 'Entregado', 50.00);

-- Insertar datos en la tabla Productos
INSERT INTO Productos (ProductoID, Nombre, Precio, EstablecimientoID, CategoriaID)
VALUES 
    (1, 'Ensalada César', 10.99, 1, 1),
    (2, 'Pizza Margherita', 15.50, 2, 2),
    (3, 'Brownie de Chocolate', 8.75, 3, 3),
    (4, 'Tacos Al Pastor', 9.99, 4, 9),
    (5, 'Sushi Tempura Roll', 22.50, 5, 13),
    (6, 'Café Americano', 3.75, 6, 9),
    (7, 'Cóctel Margarita', 8.99, 7, 7),
    (8, 'Nachos con Queso', 12.50, 8, 8),
    (9, 'Desayuno Continental', 9.75, 9, 9),
    (10, 'Hamburguesa Clásica', 6.99, 10, 10),
    (11, 'Ensalada Caprese', 11.25, 11, 11),
    (12, 'Parrillada Mixta', 40.00, 12, 12),
    (13, 'Sushi Deluxe', 28.50, 13, 13),
    (14, 'Tarta de Fresas', 7.99, 14, 14),
    (15, 'Plato Vegano Variado', 15.50, 15, 15),
    (16, 'Selección de Cervezas Artesanales', 18.75, 16, 16),
    (17, 'Buffet Internacional', 25.99, 17, 17),
    (18, 'Asado Argentino para Dos', 35.00, 18, 18),
    (19, 'Selección de Vinos Premium', 50.00, 19, 19),
    (20, 'Tarta de Chocolate y Avellanas', 12.99, 20, 20);

-- Insertar datos en la tabla Promociones
INSERT INTO Promociones (PromocionID, EstablecimientoID, Descuento, FechaInicioFin)
VALUES 
    (1, 1, 0.10, '2023-11-25 00:00:00'),
    (2, 2, 0.15, '2023-11-30 00:00:00'),
    (3, 3, 0.20, '2023-12-01 00:00:00'),
    (4, 4, 0.10, '2023-12-02 00:00:00'),
    (5, 5, 0.25, '2023-12-03 00:00:00'),
    (6, 6, 0.15, '2023-12-04 00:00:00'),
    (7, 7, 0.15, '2023-12-05 00:00:00'),
    (8, 8, 0.10, '2023-12-17 00:00:00'),
    (9, 9, 0.20, '2023-12-18 00:00:00'),
    (10, 10, 0.25, '2023-12-19 00:00:00'),
    (11, 11, 0.15, '2023-12-20 00:00:00'),
    (12, 12, 0.10, '2023-12-21 00:00:00'),
    (13, 13, 0.30, '2023-12-22 00:00:00'),
    (14, 14, 0.25, '2023-12-23 00:00:00'),
    (15, 15, 0.15, '2023-12-24 00:00:00'),
    (16, 16, 0.10, '2023-12-25 00:00:00'),
    (17, 17, 0.20, '2023-12-26 00:00:00'),
    (18, 18, 0.25, '2023-12-27 00:00:00'),
    (19, 19, 0.15, '2023-12-28 00:00:00'),
    (20, 20, 0.10, '2023-12-29 00:00:00');

-- Asignar mesas a usuarios de manera específica
UPDATE Usuarios SET MesaAsignadaID = 1 WHERE UsuarioID IN (1, 2, 3);
UPDATE Usuarios SET MesaAsignadaID = 2 WHERE UsuarioID IN (4, 5, 6);
UPDATE Usuarios SET MesaAsignadaID = 3 WHERE UsuarioID IN (7, 8);
UPDATE Usuarios SET MesaAsignadaID = 4 WHERE UsuarioID IN (11, 12);
UPDATE Usuarios SET MesaAsignadaID = 5 WHERE UsuarioID IN (13, 15);
UPDATE Usuarios SET MesaAsignadaID = 6 WHERE UsuarioID IN (16, 17, 19, 9);
UPDATE Usuarios SET MesaAsignadaID = 7 WHERE UsuarioID IN (20);

/***************************************************************************************/
/***************************************************************************************/

-- 1.Calcular Promedio de Valoraciones por Establecimiento

CREATE FUNCTION CalcularPromedioValoracionesPorEstablecimiento(@EstablecimientoID INT)
RETURNS DECIMAL(5, 2)
AS
BEGIN
    DECLARE @PromedioValoraciones DECIMAL(5, 2);

    SELECT @PromedioValoraciones = AVG(Puntuacion)
    FROM Valoraciones
    WHERE EstablecimientoID = @EstablecimientoID;

    RETURN ISNULL(@PromedioValoraciones, 0);
END;

-- Llamada a la función para calcular el promedio de valoraciones para un establecimiento específico
DECLARE @EstablecimientoID INT = 1;
SELECT dbo.CalcularPromedioValoracionesPorEstablecimiento(@EstablecimientoID) AS PromedioValoraciones;

-- 2.Obtener Último Pedido Realizado por un Usuario
CREATE FUNCTION ObtenerUltimoPedidoUsuario(@UsuarioID INT)
RETURNS TABLE
AS
RETURN (
    SELECT TOP 1 *
    FROM Pedidos
    WHERE UsuarioID = @UsuarioID
    ORDER BY FechaHoraPedido DESC
);

-- Llamada a la función para obtener el último pedido realizado por un usuario específico
DECLARE @UsuarioID INT = 1;
SELECT * FROM dbo.ObtenerUltimoPedidoUsuario(@UsuarioID);


-- 3. Calcular Total de Ventas por Mes para un Establecimiento
CREATE FUNCTION CalcularTotalVentasPorMes(@EstablecimientoID INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        YEAR(FechaHoraPedido) AS Anio,
        MONTH(FechaHoraPedido) AS Mes,
        SUM(DetalleFinanciero) AS TotalVentas
    FROM Pedidos
    WHERE EstablecimientoID = @EstablecimientoID
    GROUP BY YEAR(FechaHoraPedido), MONTH(FechaHoraPedido)
);

-- Llamada a la función para calcular el total de ventas por mes para un establecimiento específico
DECLARE @EstablecimientoID INT = 1;
SELECT * FROM dbo.CalcularTotalVentasPorMes(@EstablecimientoID);

-- 4 Obtener Promedio Puntuacion Por Categoria
CREATE FUNCTION ObtenerPromedioPuntuacionPorCategoria(@CategoriaID INT)
RETURNS DECIMAL(3,2)
AS
BEGIN
    DECLARE @PromedioPuntuacion DECIMAL(3,2)
    
    SELECT @PromedioPuntuacion = AVG(v.Puntuacion)
    FROM Valoraciones v
    JOIN Productos p ON v.EstablecimientoID = p.EstablecimientoID
    JOIN Categorias c ON p.CategoriaID = c.CategoriaID
    WHERE p.CategoriaID = @CategoriaID

    RETURN @PromedioPuntuacion
END;

-- Supongamos que quieres el promedio de puntuación para la categoría con CategoriaID 1
DECLARE @PromedioPuntuacionCategoria DECIMAL(3,2)
SET @PromedioPuntuacionCategoria = dbo.ObtenerPromedioPuntuacionPorCategoria(1)
SELECT @PromedioPuntuacionCategoria AS PromedioPuntuacionCategoria;

-- 5 // Calcular Total Gastado Por Usuario
CREATE FUNCTION CalcularTotalGastadoPorUsuario(@UsuarioID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalGastado DECIMAL(10,2)
    
    SELECT @TotalGastado = SUM(DetalleFinanciero)
    FROM Pedidos
    WHERE UsuarioID = @UsuarioID

    RETURN @TotalGastado
END;

-- Supongamos que quieres calcular el total gastado por el usuario con UsuarioID 456
DECLARE @TotalGastado DECIMAL(10,2)
SET @TotalGastado = dbo.CalcularTotalGastadoPorUsuario(456)
SELECT @TotalGastado AS TotalGastado;


-- 6 Obtener Ultimos Pedidos Por Usuario
CREATE FUNCTION ObtenerUltimosPedidosPorUsuario(@UsuarioID INT, @Cantidad INT)
RETURNS TABLE
AS
RETURN
(
    SELECT TOP (@Cantidad) PedidoID, FechaHoraPedido, EstadoPedido, DetalleFinanciero
    FROM Pedidos
    WHERE UsuarioID = @UsuarioID
    ORDER BY FechaHoraPedido DESC
);

-- Supongamos que quieres los últimos 3 pedidos para el usuario con UsuarioID 456
SELECT *
FROM dbo.ObtenerUltimosPedidosPorUsuario(6, 3);

-- 7 .Encontrar Establecimiento Mas Popular

CREATE FUNCTION EncontrarEstablecimientoMasPopular()
RETURNS VARCHAR(255)
AS
BEGIN
    DECLARE @EstablecimientoMasPopular VARCHAR(255);

    SELECT TOP 1 @EstablecimientoMasPopular = E.Nombre
    FROM Establecimientos E
    JOIN Pedidos P ON E.EstablecimientoID = P.EstablecimientoID
    GROUP BY E.Nombre
    ORDER BY COUNT(P.PedidoID) DESC;

    RETURN @EstablecimientoMasPopular;
END;

-- Llamada a la función para encontrar el establecimiento más popular
SELECT dbo.EncontrarEstablecimientoMasPopular() AS EstablecimientoMasPopular;


-- 8. Calcular el Total de Pedidos para un Usuario

CREATE FUNCTION CalcularTotalPedidos(@UsuarioID INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @Total DECIMAL(10, 2);

    SELECT @Total = SUM(DetalleFinanciero)
    FROM Pedidos
    WHERE UsuarioID = @UsuarioID;

    RETURN ISNULL(@Total, 0);
END;

--reemplaza el int con el usuario que desees visualizar
DECLARE @UsuarioID INT = 1;
SELECT dbo.CalcularTotalPedidos(@UsuarioID) AS TotalPedidos;

-- 9 .Obtener Productos más Populares por Categoría

CREATE FUNCTION ObtenerProductosPopularesPorCategoria()
RETURNS TABLE
AS
RETURN (
    SELECT 
        NombreCategoria,
        NombreProducto,
        CantidadPedidos
    FROM (
        SELECT 
            C.NombreCategoria,
            P.Nombre AS NombreProducto,
            COUNT(PE.PedidoID) AS CantidadPedidos,
            RANK() OVER (PARTITION BY C.NombreCategoria ORDER BY COUNT(PE.PedidoID) DESC) AS Ranking
        FROM Pedidos PE
        JOIN Productos P ON PE.EstablecimientoID = P.EstablecimientoID
        JOIN Categorias C ON P.CategoriaID = C.CategoriaID
        GROUP BY C.NombreCategoria, P.Nombre
    ) Ranked
    WHERE Ranking = 1
);

-- Llamada a la función para obtener productos más populares por categoría
SELECT * FROM ObtenerProductosPopularesPorCategoria();


-- 10 Contar Usuarios Por Establecimiento
CREATE FUNCTION ContarUsuariosPorEstablecimiento(@EstablecimientoID INT)
RETURNS INT
AS
BEGIN
    DECLARE @CantidadUsuarios INT

    SELECT @CantidadUsuarios = COUNT(DISTINCT UsuarioID)
    FROM Pedidos
    WHERE EstablecimientoID = @EstablecimientoID

    RETURN @CantidadUsuarios
END;

-- Supongamos que quieres contar los usuarios para el establecimiento con EstablecimientoID 12
DECLARE @CantidadUsuarios INT
SET @CantidadUsuarios = dbo.ContarUsuariosPorEstablecimiento(12)
SELECT @CantidadUsuarios AS CantidadUsuarios;

-- 11 Encontrar Mesa Con Mas Usuarios
CREATE FUNCTION EncontrarMesaConMasUsuarios()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 1 MesaAsignadaID AS MesaID, COUNT(UsuarioID) AS CantidadUsuarios
    FROM Usuarios
    WHERE MesaAsignadaID IS NOT NULL -- Excluir usuarios sin mesa asignada
    GROUP BY MesaAsignadaID
    ORDER BY CantidadUsuarios DESC
);


-- Supongamos que quieres encontrar la mesa con más usuarios
SELECT *
FROM dbo.EncontrarMesaConMasUsuarios();

-- 12 Calcular Promedio Usuarios Por Mesa
CREATE FUNCTION CalcularPromedioUsuariosPorMesa()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @PromedioUsuarios DECIMAL(10, 2)

    SELECT @PromedioUsuarios = AVG(CantidadUsuarios)
    FROM (
        SELECT COUNT(UsuarioID) AS CantidadUsuarios
        FROM Usuarios
        WHERE MesaAsignadaID IS NOT NULL -- Excluir usuarios sin mesa asignada
        GROUP BY MesaAsignadaID
    ) AS MesaUsuarios;

    RETURN @PromedioUsuarios;
END;

-- Supongamos que quieres calcular el promedio de usuarios por mesa
DECLARE @PromedioUsuariosPorMesa DECIMAL(10, 2)
SET @PromedioUsuariosPorMesa = dbo.CalcularPromedioUsuariosPorMesa()
SELECT @PromedioUsuariosPorMesa AS PromedioUsuariosPorMesa;

-- 13 mesas sin usuarios
SELECT MesaID
FROM Mesas
WHERE MesaID NOT IN (SELECT DISTINCT MesaAsignadaID FROM Usuarios WHERE MesaAsignadaID IS NOT NULL);

-- 14. Calcular Promedio Pedidos Por Mes
CREATE FUNCTION CalcularPromedioPedidosPorMes()
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @PromedioPedidos DECIMAL(10, 2)

    SELECT @PromedioPedidos = AVG(CantidadPedidos)
    FROM (
        SELECT COUNT(PedidoID) AS CantidadPedidos
        FROM Pedidos
        WHERE MONTH(FechaHoraPedido) = MONTH(GETDATE()) AND YEAR(FechaHoraPedido) = YEAR(GETDATE())
        GROUP BY YEAR(FechaHoraPedido), MONTH(FechaHoraPedido)
    ) AS PedidosPorMes;

    RETURN @PromedioPedidos;
END;

-- Supongamos que quieres calcular el promedio de pedidos para el mes actual
DECLARE @PromedioPedidosPorMes DECIMAL(10, 2)
SET @PromedioPedidosPorMes = dbo.CalcularPromedioPedidosPorMes()
SELECT @PromedioPedidosPorMes AS PromedioPedidosPorMes;

-- 15. Cuántos usuarios tienen el rol de "Dueño"

SELECT COUNT(UsuarioID) AS CantidadDueños
FROM Usuarios
WHERE RolID = 2; -- Suponiendo que el ID del rol de "Dueño" es 2

-- 16 Promedio de descuento por establecimiento

SELECT AVG(Descuento) AS PromedioDescuento
FROM Promociones;

-- 17. el establecimiento con el descuento más alto

SELECT TOP 1 e.Nombre AS Establecimiento, p.Descuento
FROM Establecimientos e
JOIN Promociones p ON e.EstablecimientoID = p.EstablecimientoID
ORDER BY p.Descuento DESC;

-- 18 .el establecimiento con más mesas

SELECT TOP 1 e.Nombre AS Establecimiento, COUNT(m.MesaID) AS CantidadMesas
FROM Establecimientos e
JOIN Mesas m ON e.EstablecimientoID = m.EstablecimientoID
GROUP BY e.Nombre
ORDER BY CantidadMesas DESC;
