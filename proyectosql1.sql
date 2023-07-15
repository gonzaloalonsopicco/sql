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




