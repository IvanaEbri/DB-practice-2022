# Crea la base de datos mediante la sentencia CREATE:
CREATE DATABASE base_ejemplo;

# Selecciona la base de datos para así poder ejecutar consultas SQL sobre ella:
USE base_ejemplo;

# Creamos una tabla llamada productos:
CREATE TABLE productos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    coste FLOAT NOT NULL DEFAULT 0.0,
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(id)
);

# Insertamos datos de prueba en la tabla productos
INSERT INTO productos (nombre, coste, precio) VALUES ('Producto A', 4, 8), ('Producto B', 2, 4),('Producto C', 40, 80);

SELECT * FROM productos;


# Creamos el trigger que se ejecutará al actualizar un registro.
DELIMITER $$
DROP TRIGGER IF EXISTS actualizarPrecioProducto;
CREATE TRIGGER actualizarPrecioProducto
BEFORE UPDATE ON productos
FOR EACH ROW
BEGIN
  IF NEW.coste <> OLD.coste
    THEN
      SET NEW.precio = NEW.coste * 2;
  END IF;
END;

UPDATE productos SET coste = 10 WHERE id = 2;
SELECT * FROM productos;