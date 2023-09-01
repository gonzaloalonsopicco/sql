USE pc_componentes;

/*creacion de tablas*/

CREATE TABLE usuario (id_usuario INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NOT NULL, 
email VARCHAR(50) NOT NULL, 
celular int(10) NOT NULL,
ciudad VARCHAR(50) NOT NULL, 
provincia VARCHAR(50) NOT NULL);

CREATE TABLE producto (id_producto INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(100) NOT NULL, 
precio int(10) NOT NULL, 
descripcion VARCHAR(200), 
cantidadStock int(10) NOT NULL, 
id_categoria int NOT NULL,
id_marca int NOT NULL,
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria), 
FOREIGN KEY (id_marca) REFERENCES marca(id_marca));

CREATE TABLE categoria (id_categoria INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL);

CREATE TABLE carritoCompra (id_carritoCompra INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
fechaHora DATETIME NOT NULL, 
cantidadProducto int(10),
id_usuario int NOT NULL, 
id_producto int NOT NULL, 
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario), 
FOREIGN KEY (id_producto) REFERENCES producto(id_producto));

CREATE TABLE marca (id_marca INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL);

CREATE TABLE usuarioMetodoPago (id_usuarioMetodoPago INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
id_usuario int NOT NULL,
id_metodoPago int NOT NULL,
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
FOREIGN KEY (id_metodoPago) REFERENCES metodoPago(id_metodoPago));

CREATE TABLE metodoPago (id_metodoPago INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL);

CREATE TABLE pais (id_pais INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL);

CREATE TABLE provincia (id_provincia INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL, 
id_pais int NOT NULL,
FOREIGN KEY (id_pais) REFERENCES pais(id_pais));

CREATE TABLE ciudad (id_ciudad INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
nombre VARCHAR(30) NOT NULL, 
id_provincia int NOT NULL,
FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia));

/* Inserción de datos*/

INSERT INTO usuario(nombre, apellido, email, celular, ciudad, provincia) VALUE 
('Martín', 'López', 'martinlopez@gmail.com', 1112345678, 'Palermo', 'Buenos Aires'), 
('Sofía', 'Rodríguez', ' sofiarodriguez@gmail.com', 1198765432, 'Nueva Córdoba', 'Córdoba'), 
('Alejandro', 'Fernández', 'alejandrofernandez@gmail.com', 1124681357, 'Centro', 'Santa Fe'), 
('Valentina', 'Gómez', 'valentinagomez@gmail.com', 1136914725, 'Godoy Cruz', 'Mendoza'), 
('Tomás', 'Pérez', 'tomasperez@gmail.com', 1185296314, 'La Plata', 'Buenos Aires'),
('Laura', 'González', 'lauragonzalez@gmail.com', 1167890123, 'Yerba Buena', 'Tucumán'),
('Javier', 'Martínez', 'javiermartinez@gmail.com', 1123456789, 'Güemes', 'Salta'),
('María', 'Rodríguez', 'mariarodriguez@gmail.com', 1198765432, 'Rivadavia', 'San Juan'),
('Andrés', 'Pérez', 'andresperez@gmail.com', 1156789012, 'Villa Fabiana', 'Chaco'),
('Carolina', 'López', 'carolinalopez@gmail.com', 1134567890, 'puerto madero', 'Buenos Aires');

INSERT INTO producto(nombre, precio, descripcion, cantidadStock, id_categoria, id_marca) VALUES 
('Intel Core i9-10900K', 449, 'Procesador de 10 núcleos y 20 hilos con una velocidad de reloj base de 3.7 GHz y turbo de hasta 5.3 GHz', 15, 1, 1), 
('AMD Ryzen 9 5900X', 549, 'Procesador de 12 núcleos y 24 hilos con una velocidad de reloj base de 3.7 GHz y turbo de hasta 4.8 GHz', 12, 1, 2),
('Intel Core i5-11600K', 269, 'Procesador de 6 núcleos y 12 hilos con una velocidad de reloj base de 3.9 GHz y turbo de hasta 4.9 GHz', 18, 1, 1),
('AMD Ryzen 7 5800X', 449, 'Procesador de 8 núcleos y 16 hilos con una velocidad de reloj base de 3.8 GHz y turbo de hasta 4.7 GHz', 10, 1, 2),

('NVIDIA GeForce RTX 3090', 1499, 'Tarjeta gráfica con 24 GB de VRAM y arquitectura Ampere para un rendimiento excepcional en juegos y aplicaciones de alta demanda gráfica', 8, 2, 4),
('AMD Radeon RX 6800 XT', 699, 'Tarjeta gráfica con 16 GB de VRAM y arquitectura RDNA 2 para un rendimiento gaming de alta gama', 10, 2, 2),
('NVIDIA GeForce RTX 3070', 699, 'Tarjeta gráfica con 8 GB de VRAM y arquitectura Ampere para un rendimiento gaming avanzado', 15, 2, 4),
('AMD Radeon RX 6700 XT', 499, 'Tarjeta gráfica con 12 GB de VRAM y arquitectura RDNA 2 para un rendimiento gaming de alta calidad', 12, 2, 2),

('Corsair Vengeance LPX 16GB DDR4 3200MHz', 79, 'Kit de memoria DDR4 de 16 GB (2x8 GB) con una velocidad de 3200 MHz', 20, 3, 3),
('Corsair Dominator Platinum RGB 64GB DDR4 4000MHz', 349, 'Kit de memoria DDR4 de 64 GB (4x16 GB) con una velocidad de 4000 MHz y efectos de iluminación RGB', 8, 3, 3),
('Corsair Vengeance RGB Pro 32GB DDR4 3600MHz', 149, 'Kit de memoria DDR4 de 32 GB (2x16 GB) con una velocidad de 3600 MHz y efectos de iluminación RGB personalizables', 18, 3, 3),
('Corsair Dominator Platinum RGB 32GB DDR4 4266MHz', 379, 'Kit de memoria DDR4 de 32 GB (4x8 GB) con una velocidad de 4266 MHz y efectos de iluminación RGB premium', 10, 3, 3),

('NZXT H710i', 169, 'Gabinete de tipo Mid Tower con diseño moderno, panel lateral de vidrio templado y control inteligente de ventiladores', 15, 4, 5),
('Corsair Crystal 680X RGB', 249, 'Gabinete de tipo Mid Tower con paneles de vidrio templado y efectos de iluminación RGB personalizables', 10, 4, 3),
('NZXT H510i', 79, 'Gabinete de tipo Mid Tower con diseño elegante, panel lateral de vidrio templado y excelente gestión de cables', 18, 4, 5),
('Corsair Obsidian 500D RGB SE', 299, 'Gabinete de tipo Mid Tower con diseño premium, paneles de vidrio templado y efectos de iluminación RGB', 8, 4, 3),

('MSI MAG B550 TOMAHAWK', 189, 'Placa madre con socket AM4 compatible con procesadores AMD Ryzen de 3ra y 4ta generación, con soporte PCIe 4.0 y diseño de alta calidad', 10, 5, 2),
('MSI MPG Z590 GAMING EDGE WIFI', 259, 'Placa madre con socket LGA 1200 compatible con procesadores Intel de 10ma y 11va generación, con Wi-Fi 6 y conectividad USB-C', 15, 5, 1),
('EVGA Z590 FTW WIFI', 399, 'Placa madre con socket LGA 1200 compatible con procesadores Intel de 10ma y 11va generación, con Wi-Fi 6 y diseño de alta gama', 8, 5, 4),
('ASRock B450 Pro4', 129, 'Placa madre con socket AM4 compatible con procesadores AMD Ryzen de 1ra, 2da y 3ra generación, con características esenciales para gaming y productividad', 12, 5, 2),

('Corsair RM750x', 129, 'Fuente de alimentación modular de 750W con certificación 80 PLUS Gold y cables planos para una gestión limpia', 10, 6, 3),
('EVGA Supernova 850 G5', 149, 'Fuente de alimentación modular de 850W con certificación 80 PLUS Gold y diseño compacto', 8, 6, 4),
('NZXT C750', 129, 'Fuente de alimentación modular de 750W con certificación 80 PLUS Gold y control digital para ajustes precisos', 12, 6, 5),
('Corsair RM850i', 139, 'Fuente de alimentación modular de 850W con certificación 80 PLUS Gold y monitoreo digital', 12, 6, 3);

INSERT INTO categoria(nombre) VALUE 
('procesadores'), 
('placas de video'), 
('memorias ram'), 
('gabinetes'), 
('placas madre'), 
('Fuentes');

INSERT INTO carritoCompra(fechaHora, cantidadProducto, id_usuario, id_producto) VALUE 
('2021-01-10 20:00:00', 2, 3, 49), 
('2020-10-25 12:30:20', 1, 5, 60),
('2023-12-30 19:45:20', 2, 1, 70);

INSERT INTO marca(nombre) VALUE 
('intel'), 
('amd'), 
('corsair'), 
('nvidia'), 
('nzxt');

INSERT INTO usuarioMetodoPago(id_usuario, id_metodoPago) VALUE 
(1, 3), (5, 2), (1, 2);

INSERT INTO metodoPago(nombre) VALUE 
('Tarjeta de crédito'),
('PayPal'),
('Transferencia bancaria');

INSERT INTO pais(nombre) VALUE 
('Agentina');

INSERT INTO provincia(nombre, id_pais) VALUE 
('Buenos Aires', 1), ('Catamarca', 1), ('Chaco', 1), ('Chubut', 1), ('Córdoba', 1),
('Corrientes', 1), ('Entre Ríos', 1), ('Formosa', 1), ('Jujuy', 1), ('La Pampa', 1),
('La Rioja', 1), ('Mendoza', 1), ('Misiones', 1), ('Neuquén', 1), ('Río Negro', 1),
('Salta', 1), ('San Juan', 1), ('San Luis', 1), ('Santa Cruz', 1), ('Santa Fe', 1), 
('Santiago del Estero', 1), ('Tierra del Fuego', 1), ('Tucumán', 1);

INSERT INTO ciudad(nombre, id_provincia) VALUE 
('Palermo', 1), ('Nueva Córdoba', 5), ('Centro', 20), ('Godoy Cruz', 12),
('Yerba Buena', 23), ('La Plata', 1), ('Güemes', 16), ('Rivadavia', 17),
('Villa Fabiana', 3), ('Confluencia', 14), ('Pellegrini', 6), ('Miguel Lanús', 13),
('General Pico', 10), ('Alto Comedero', 9), ('Paracao', 7),('San Francisco', 8), 
( 'Banda del Río Salí', 21), ('Valle Andorra', 22), ('Centro Río Gallegos', 19), ('puerto madero', 1);

/* funciones*/

/*Función para Obtener la Cantidad de Productos en una Categoría*/

DELIMITER //
CREATE FUNCTION cantidadProductosCategoria(nombreCategoria VARCHAR(30)) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE productCount INT;
    
    SELECT COUNT(*) INTO productCount
    FROM producto p
    JOIN categoria c ON p.id_categoria = c.id_categoria
    WHERE c.nombre = nombreCategoria;
    
    RETURN productCount;
END;
//
DELIMITER ;

-- SELECT cantidadProductosCategoria('procesadores');

/*Función para calcular el total gastado por un usuario en sus compras*/
-- La función realiza un cálculo para calcular el precio total del usuario.
 -- El resultado del cálculo se almacena en la variable total_gastado y se devuelve como resultado de la función.

DELIMITER //
CREATE FUNCTION calcular_total_gastado(idUsuario INT)
RETURNS DECIMAL(10, 2) DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10, 2);
    
    SELECT SUM(p.precio * cc.cantidadProducto) INTO total
    FROM carritoCompra cc
    JOIN producto p ON cc.id_producto = p.id_producto
    WHERE cc.id_usuario = idUsuario;
    
    RETURN total;
END //
DELIMITER ;

-- SELECT calcular_total_gastado(1) AS total_gastado;

/*vistas*/

/*Vista de Usuarios con Ciudad y Provincia*/
-- Esta vista mostrará información detallada de los usuarios, incluyendo la ciudad y la provincia en la que se encuentran

CREATE VIEW vistaUsuarios AS
SELECT u.id_usuario, u.nombre, u.apellido, u.email, u.celular, u.ciudad, u.provincia, p.nombre AS pais
FROM usuario u
JOIN provincia pr ON u.provincia = pr.nombre
JOIN pais p ON pr.id_pais = p.id_pais;

-- SELECT * FROM vistaUsuarios;

/*Vista de Productos con Categoría y Marca*/
-- Esta vista mostrará información detallada de los productos, incluyendo la categoría y la marca a la que pertenecen

CREATE VIEW vistaProductos AS
SELECT p.id_producto, p.nombre, p.precio, p.descripcion, p.cantidadStock, c.nombre AS categoria, m.nombre AS marca
FROM producto p
JOIN categoria c ON p.id_categoria = c.id_categoria
JOIN marca m ON p.id_marca = m.id_marca;
 
-- SELECT * FROM vistaProductos;

/*Vista de Usuarios y sus Compras*/
-- Esta vista mostrará los detalles de los usuarios junto con la información de las compras que han realizado

CREATE VIEW vistaUsuariosCompras AS
SELECT u.id_usuario, u.nombre AS nombre_usuario, u.apellido, u.email,
       c.id_carritoCompra, c.fechaHora, c.cantidadProducto,
       p.nombre AS nombre_producto, p.precio
FROM usuario u
JOIN carritoCompra c ON u.id_usuario = c.id_usuario
JOIN producto p ON c.id_producto = p.id_producto;

-- SELECT * FROM vistaUsuariosCompras;

/*Vista de Métodos de Pago por Usuario*/
-- Esta vista mostrará los métodos de pago utilizados por cada usuario

CREATE VIEW vistaMetodosPago AS
SELECT ump.id_usuarioMetodoPago, u.nombre AS usuario, mp.nombre AS metodo_pago
FROM usuarioMetodoPago ump
JOIN usuario u ON ump.id_usuario = u.id_usuario
JOIN metodoPago mp ON ump.id_metodoPago = mp.id_metodoPago;

-- SELECT * FROM vistaMetodosPago;

/*Vista de Usuarios por Provincia*/
-- Esta vista mostrará la cantidad de usuarios por provincia

CREATE VIEW vistaUsuariosPorProvincia AS
SELECT pr.nombre AS provincia, COUNT(u.id_usuario) AS cantidad_usuarios
FROM usuario u
JOIN provincia pr ON u.provincia = pr.nombre
GROUP BY pr.nombre;

-- SELECT * FROM vistaUsuariosPorProvincia;

/*Stored Procedure*/

/* se creó para proporcionar una forma reutilizable y
 eficiente de obtener una lista de productos que pertenecen a una categoría específica en la base de datos.*/

DELIMITER //
CREATE PROCEDURE mostrarProductosPorCategoria(IN nombre_categoria VARCHAR(30))
BEGIN
    SELECT p.nombre, p.precio, p.descripcion, p.cantidadStock, c.nombre AS categoria
    FROM producto p
    INNER JOIN categoria c ON p.id_categoria = c.id_categoria
    WHERE c.nombre = nombre_categoria;
END;
//
DELIMITER ;

-- CALL mostrarProductosPorCategoria('procesadores');

/* fue creado con el objetivo de mostrar el detalle de una compra específica
 realizada en la base de datos. */

DELIMITER //
CREATE PROCEDURE mostrarDetalleCompra(IN id_carritoCompra INT)
BEGIN
    SELECT u.nombre AS nombre_usuario, u.email, u.celular, u.ciudad, u.provincia, 
    p.nombre AS nombre_producto, p.precio, cc.cantidadProducto,
           cc.fechaHora
    FROM carritoCompra cc
    INNER JOIN usuario u ON cc.id_usuario = u.id_usuario
    INNER JOIN producto p ON cc.id_producto = p.id_producto
    WHERE cc.id_carritoCompra = id_carritoCompra;
END;
//
DELIMITER ;

-- CALL mostrarDetalleCompra(13);

/*tabla log usuarios*/

CREATE TABLE log (
  id_log INT PRIMARY KEY AUTO_INCREMENT,
  tabla_afectada VARCHAR(50) NOT NULL,
  accion VARCHAR(20) NOT NULL,
  fecha_hora DATETIME NOT NULL,
  detalle VARCHAR(200)
);

/*triggers*/

-- Creamos un Trigger AFTER INSERT en la tabla "usuario" para registrar las inserciones en el log
DELIMITER //
CREATE TRIGGER after_insert_usuario
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
  INSERT INTO log (tabla_afectada, accion, fecha_hora, detalle)
  VALUES ('usuario', 'INSERT', NOW(), CONCAT('ID de usuario insertado: ', NEW.id_usuario));
END;
//
DELIMITER ;

-- Creamos un Trigger AFTER UPDATE en la tabla "usuario" para registrar las actualizaciones en el log
DELIMITER //
CREATE TRIGGER after_update_usuario
AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
  INSERT INTO log (tabla_afectada, accion, fecha_hora, detalle)
  VALUES ('usuario', 'UPDATE', NOW(), CONCAT('ID de usuario actualizado: ', NEW.id_usuario));
END;
//
DELIMITER ;

-- Creamos un Trigger AFTER DELETE en la tabla "usuario" para registrar las eliminaciones en el log
DELIMITER //
CREATE TRIGGER after_delete_usuario
AFTER DELETE ON usuario
FOR EACH ROW
BEGIN
  INSERT INTO log (tabla_afectada, accion, fecha_hora, detalle)
  VALUES ('usuario', 'DELETE', NOW(), CONCAT('ID de usuario eliminado: ', OLD.id_usuario));
END;
//
DELIMITER ;

-- select * from log;

/*tabla log usuarios*/

CREATE TABLE logCarritoCompra (
  id_logCarritoCompra INT PRIMARY KEY AUTO_INCREMENT,
  accion VARCHAR(20) NOT NULL,
  fecha_hora DATETIME NOT NULL,
  id_usuario int NOT NULL,
  id_producto int NOT NULL
);

-- Creamos un Trigger AFTER INSERT en la tabla "carritoCompra" para registrar las inserciones en el log
DELIMITER //
CREATE TRIGGER after_insert_carritoCompra
AFTER INSERT ON carritoCompra
FOR EACH ROW
BEGIN
    INSERT INTO logCarritoCompra (accion, fechaHora, id_usuario, id_producto)
    VALUES ('Inserción', NOW(), NEW.id_usuario, NEW.id_producto);
END;
//
DELIMITER ;

-- select * from logCarritoCompra;
