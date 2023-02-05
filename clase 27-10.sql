CREATE DATABASE IF NOT EXISTS after_class_practica;

USE after_class_practica;

CREATE TABLE IF NOT EXISTS categoria(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS producto(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	categoria_id INT NOT NULL,
	nombre VARCHAR(255),
	cantidad INT,
	precio decimal(10,2),
	FOREIGN KEY (categoria_id) REFERENCES after_class_practica.categoria(id)
);

INSERT INTO categoria (nombre) VALUES 
('Electrónico'),
('Hogar'),
('Bazar'),
('Decoracion');

INSERT INTO producto (categoria_id,nombre,cantidad,precio) VALUES 
(1,'Toshiba',10,700) , 
(2,'Cooler' , 2 , 100),
(1,'Teclado Gammer',3,90),
(2,'Mouse LG' , 0 , 200), 
(2,'Monitor Samsung 19 "' , 20 , 1900.36);

SELECT * FROM producto;
SELECT * FROM categoria;

# listar productos (mostrar nombre y cantidad) productos con menos de 5 unidades
SELECT producto.nombre, producto.cantidad FROM producto WHERE producto.cantidad <5;

# mostrar toda la informacion de los productos con precios entre 50 y 200
SELECT * FROM producto WHERE precio > 50 AND precio < 200;
#BETWEEN es mas performatico, es decir optimiza recursos
SELECT * FROM producto WHERE precio BETWEEN 50 AND 200;

# muestre los productos con precio mayor a 100 y la categoria a la que pertenecen
SELECT producto.nombre, categoria.nombre, precio 
FROM producto INNER JOIN categoria ON categoria.id=producto.categoria_id 
WHERE precio > 100;

# muestre los productos con un precio mayor a 100 y a que categoria pertenece (nombre_producto,nombre_categoria,precio).
SELECT producto.nombre AS "nombre_producto",categoria.nombre AS "nombre_categoria",producto.precio AS "precio"  
FROM producto inner join categoria on producto.categoria_id = categoria.id WHERE  precio >100; 

#acortando los nombres de las tablas el query queda de la siguiente forma
SELECT p.nombre AS "nombre_producto",c.nombre AS "nombre_categoria",p.precio AS "precio"  
FROm producto AS p inner join categoria AS c on p.categoria_id = c.id WHERE  precio >100;

# muestre los 4 productos mas caros y su cantidad
SELECT producto.nombre, categoria.nombre, producto.precio 
FROM producto INNER JOIN categoria ON categoria.id=producto.categoria_id 
ORDER BY producto.precio DESC LIMIT 4;

# muestre el stock ingresado por categoria
SELECT categoria.nombre AS 'categoria', SUM(producto.cantidad) AS 'cantidad_de_productos' 
FROM producto INNER JOIN categoria ON categoria.id=producto.categoria_id 
GROUP BY (categoria.nombre);

# muestre las categorias en las cuales se han ingresado productos y su cantidad (id, nombre, cantidad)
SELECT categoria.id AS 'id', categoria.nombre AS 'nombre', SUM(producto.cantidad) AS 'cant. producto por categoria', 
COUNT(producto.categoria) AS 'productos ingresados' FROM producto RIGHT JOIN categoria 
ON producto.categoria_id=categoria.id GROUP BY (categoria.nombre);

SELECT categoria.id AS 'id', categoria.nombre AS 'nombre', producto.cantidad AS 'cant. producto por categoria', 
COUNT(producto.categoria) AS 'productos ingresados' FROM producto RIGHT JOIN categoria 
ON producto.categoria_id=categoria.id GROUP BY (categoria.nombre) HAVING producto.cantidad > 0;

# establecer una variable que guarde el total de productos
SET @totalProducto:= (SELECT SUM(producto.cantidad) FROM producto);

# muestre el % de productos por categoria (nombre categoria, porcentaje)
SELECT c.nombre AS 'nombre_categoria', CONCAT((ROUND((SUM(cantidad)/@totalProducto)*100),2),'%') AS 'porcentaje' 
FROM categoria AS c INNER JOIN producto AS p ON p.categoria=c.id GROUP BY c.nombre;