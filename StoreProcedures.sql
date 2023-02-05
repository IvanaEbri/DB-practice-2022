# Crea la base de datos mediante la sentencia CREATE:
DROP DATABASE IF EXISTS base_ejemplo;
CREATE DATABASE base_ejemplo;

# Selecciona la base de datos para así poder ejecutar consultas SQL sobre ella:
USE base_ejemplo;

# Creamos una tabla llamada productos:
DROP TABLE IF EXISTS productos;
CREATE TABLE productos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    coste FLOAT NOT NULL DEFAULT 0.0,
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(id)
);

# Insertamos datos de prueba en la tabla productos
INSERT INTO productos (nombre, coste, precio) VALUES ('Producto A', 4, 8), ('Producto B', 2, 4),('Producto C', 40, 80);

# Verificamos los productos insertados
SELECT * FROM productos;

# Creamos el store procedure
DELIMITER $$
DROP PROCEDURE IF EXISTS sp_agregar_producto;
CREATE PROCEDURE sp_agregar_producto(p_nombre VARCHAR(20), p_coste FLOAT, p_precio FLOAT)
BEGIN
	INSERT INTO productos(nombre, coste, precio)VALUES(p_nombre, p_coste, p_precio);
END;

# Usar el store procedure
CALL sp_agregar_producto('Play Station 5', 5430, 9600);

DELIMITER $$
DROP PROCEDURE IF EXISTS listarProductos;
CREATE PROCEDURE listarProductos()
BEGIN
	SELECT * FROM productos;
	SELECT coste AS COSTOSO FROM productos;
END;

CALL listarProductos();

DROP PROCEDURE listarProductos;



