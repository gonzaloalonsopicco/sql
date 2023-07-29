USE pc_componentes;

CREATE TABLE usuario (id_usuario INT PRIMARY KEY NOT NULL, 
nombre VARCHAR(30) NOT NULL, 
email VARCHAR(50) NOT NULL, 
contrasena VARCHAR(30), 
celular int(10) NOT NULL, 
direccion VARCHAR(50));

CREATE TABLE producto (id_producto INT PRIMARY KEY NOT NULL, 
nombre VARCHAR(30) NOT NULL, 
precio int(10) NOT NULL, 
descripcion VARCHAR(200), 
cantidadStock int(10) NOT NULL, 
id_categoria int NOT NULL,
FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria));

CREATE TABLE categoria (id_categoria INT PRIMARY KEY NOT NULL, 
nombre VARCHAR(30) NOT NULL);

CREATE TABLE carritoCompra (id_carritoCompra INT PRIMARY KEY NOT NULL, 
fechaHora DATETIME NOT NULL, 
cantidadProducto int(10),
id_usuario int NOT NULL, 
id_producto int NOT NULL, 
FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario), 
FOREIGN KEY (id_producto) REFERENCES producto(id_producto));

INSERT INTO usuario(id_usuario, nombre, email, contrasena, celular, direccion) VALUE 
(1, 'Martín López', 'martinlopez@gmail.com', 'Argentina2023!', 1112345678, 'Av. Libertador 123, Buenos Aires'), 
(2, 'Sofía Rodríguez', ' sofiarodriguez@gmail.com', 'ArG3nt1na$!', 1198765432, 'Calle San Martín 456, Córdoba'), 
(3, 'Alejandro Fernández', 'alejandrofernandez@gmail.com', 'BuenosAires789!!', 1124681357, 'Av. Rivadavia 789, Buenos Aires'), 
(4, 'Valentina Gómez', 'valentinagomez@gmail.com', 'LaPlata456$', 1136914725, 'Calle 12 de Octubre 321, La Plata'), 
(5, 'Tomás Pérez', 'tomasperez@gmail.com', 'Patagonia852!', 1185296314, 'Ruta 40, San Carlos de Bariloche');

INSERT INTO producto(id_producto, nombre, precio, descripcion, cantidadStock, id_categoria) VALUE 
(1, 'Intel Core i7-10700K', 349, 'Procesador de 10 núcleos y 16 hilos con una velocidad de reloj base de 3.8 GHz y turbo de hasta 5.1 GHz', 20, 1), 
(2, 'NVIDIA GeForce RTX 3080', 999, 'Tarjeta gráfica con 10 GB de VRAM y arquitectura Ampere para un rendimiento excepcional en juegos y aplicaciones de alta demanda gráfica', 10, 2), 
(3, 'Corsair Vengeance RGB Pro', 99, 'Módulo de memoria DDR4 de 16 GB (2x8 GB) con una velocidad de 3200 MHz y efectos de iluminación RGB personalizables', 25, 3), 
(4, 'NZXT H510', 79, 'Gabinete de tipo Mid Tower con un diseño elegante, panel lateral de vidrio templado y excelente gestión de cables', 15, 4), 
(5, 'ASUS ROG Strix B550-F Gaming', 199, 'Placa madre con socket AM4 compatible con procesadores AMD Ryzen de 3ra y 4ta generación, con soporte para overclocking y conectividad PCIe 4.0', 10, 5);

INSERT INTO categoria(id_categoria, nombre) VALUE 
(1, 'procesadores'), 
(2, 'placas de video'), 
(3, 'memorias ram'), 
(4, 'gabinetes'), 
(5, 'placas madre'), 
(6, 'Fuentes');

INSERT INTO carritoCompra(id_carritoCompra, fechaHora, cantidadProducto,  id_usuario, id_producto) VALUE 
(1, '2021-01-10 20:00:00', 2, 3, 2), 
(2, '2020-10-25 12:30:20', 1, 5, 1),
(3, '2023-12-30 19:45:20', 2, 1, 3);

/* funciones*/

/*Obtener todos los productos con su categoría correspondiente:*/

SELECT p.nombre, p.precio, c.nombre AS categoria
FROM producto p
INNER JOIN categoria c ON p.id_categoria = c.id_categoria;

/* es una función llamada calcularDescuento que recibe dos parámetros de entrada: precio y descuento. 
La función realiza un cálculo para aplicar un descuento al precio dado.
 El resultado del cálculo se almacena en la variable precio_final y se devuelve como resultado de la función.*/

DELIMITER //

CREATE FUNCTION calcularDescuento(precio INT, descuento FLOAT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE precio_final INT;
    
    if precio < 300 then
    SET precio_final = precio;
    
    ELSEIF precio >= 300 then
    SET precio_final = precio - (precio * descuento);
    end if;
    RETURN precio_final;
END
//

DELIMITER ;

SELECT calcularDescuento(500, 0.2) AS precio_con_descuento;

/*vistas*/

/* La vista "vista_productos" muestra información detallada de los
 productos, incluyendo su ID, nombre, precio, cantidad en stock y el nombre de la categoría a la que pertenecen. */


CREATE VIEW vista_productos AS
SELECT id_producto, nombre, precio, cantidadStock, nombre AS categoria
FROM producto
JOIN categoria ON producto.id_categoria = categoria.id_categoria;

SELECT * FROM vista_productos;


/*La vista "vista_carrito_compra" muestra información detallada de los registros del
 carrito de compra, incluyendo su ID, fecha y hora, cantidad de productos, el nombre del usuario que realizó la compra y 
 el nombre del producto comprado.*/

CREATE VIEW vista_carrito_compra AS
SELECT c.id_carritoCompra, c.fechaHora, c.cantidadProducto, u.nombre AS nombre_usuario, p.nombre AS nombre_producto
FROM carritoCompra c
JOIN usuario u ON c.id_usuario = u.id_usuario
JOIN producto p ON c.id_producto = p.id_producto;

SELECT * FROM vista_carrito_compra;

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

CALL mostrarProductosPorCategoria('procesadores');

/* fue creado con el objetivo de mostrar el detalle de una compra específica
 realizada en la base de datos. */

DELIMITER //

CREATE PROCEDURE mostrarDetalleCompra(IN id_carritoCompra INT)
BEGIN
    SELECT u.nombre AS nombre_usuario, u.email, u.celular, u.direccion,
           p.nombre AS nombre_producto, p.precio, cc.cantidadProducto,
           cc.fechaHora
    FROM carritoCompra cc
    INNER JOIN usuario u ON cc.id_usuario = u.id_usuario
    INNER JOIN producto p ON cc.id_producto = p.id_producto
    WHERE cc.id_carritoCompra = id_carritoCompra;
END;

//

DELIMITER ;

CALL mostrarDetalleCompra(1);


/*tabla log*/

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

INSERT INTO usuario (id_usuario, nombre, email, contrasena, celular, direccion) 
VALUES (6 , 'Juan Pérez', 'juanperez@example.com', 'Password123', 1234567890, 'Calle 123, Ciudad');

DELETE FROM usuario WHERE id_usuario = 6;

select * from log;



/*transacciones*/

-- agregar  usuario

START TRANSACTION;

    -- Insertar registros en la tabla "usuario"
    INSERT INTO usuario (id_usuario, nombre, email, contrasena, celular, direccion)
    VALUES (6, 'Nuevo Usuario 1', 'usuario1@gmail.com', 'contrasena1', 1234567890, 'Dirección 1');
    INSERT INTO usuario (id_usuario, nombre, email, contrasena, celular, direccion)
    VALUES (7, 'Nuevo Usuario 2', 'usuario2@gmail.com', 'contrasena2', 987654321, 'Dirección 2');

select * from usuario;

-- ROLLBACK;

-- COMMIT;



-- insertar registros en la tabla carritoCompra

-- Inicio de la transacción
START TRANSACTION;

-- Insertar nuevos registros en la tabla "carritoCompra"
INSERT INTO carritoCompra (id_carritoCompra, fechaHora, cantidadProducto, id_usuario, id_producto)
VALUES (4, '2023-07-15 10:00:00', 3, 3, 1), 
 (5, '2023-07-15 11:00:00', 1, 2, 5), 
 (6, '2023-07-15 12:00:00', 2, 1, 3);

-- Agregar el primer savepoint después de la inserción del registro 
SAVEPOINT savepoint_1;

INSERT INTO carritoCompra (id_carritoCompra, fechaHora, cantidadProducto, id_usuario, id_producto)
VALUES (7, '2023-07-15 13:00:00', 2, 4, 4), 
(8, '2023-07-15 14:00:00', 1, 5, 2);

-- Agregar el segundo savepoint después de la inserción del registro 
SAVEPOINT savepoint_2;

-- eliminación del savepoint de los primeros 3 registros insertados
-- RELEASE SAVEPOINT savepoint_1;

select * from carritoCompra;

 -- ROLLBACK;

-- COMMIT;



