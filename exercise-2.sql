USE tienda;

-- Numeral 1
SELECT nombre FROM producto; 

-- Numeral 2
SELECT nombre, precio from producto;

-- Numeral 3
SELECT * from producto;

-- Numeral 4
SELECT nombre, ROUND(precio) from producto;

-- Numeral 5
SELECT f.codigo FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante;

-- Numeral 6
SELECT DISTINCT f.codigo FROM fabricante f, producto p
WHERE f.codigo = p.codigo_fabricante;

-- Numeral 7
SELECT nombre FROM fabricante ORDER BY nombre;

-- Numeral 8
SELECT nombre, precio FROM producto ORDER BY nombre, precio DESC;

-- Numeral 9
SELECT * FROM fabricante LIMIT 5;

-- Numeral 10
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;

-- Numeral 11
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;

-- Numeral 12
SELECT nombre FROM producto WHERE precio <= 120;

-- Numeral 13
SELECT * FROM producto WHERE precio BETWEEN 60 AND 200;

-- Numeral 14
SELECT * FROM producto WHERE codigo_fabricante IN (1, 3, 5);

-- Numeral 15
SELECT nombre FROM producto WHERE nombre LIKE '%portátil%';


/* Consultas multitabla */

-- Numeral 1
SELECT p.codigo, p.nombre, p.precio, p.codigo_fabricante, f.nombre
FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo;

-- Numeral 2 
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo ORDER BY f.nombre;

-- Numeral 3
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;

-- Numeral 4
SELECT p.* FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo AND f.nombre LIKE 'lenovo';

-- Numeral 5
SELECT p.* FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo AND f.nombre LIKE 'crucial' AND p.precio > 200;

-- Numeral 6
SELECT p.* FROM producto p, fabricante f
WHERE p.codigo_fabricante = f.codigo AND f.nombre IN ('asus', 'hewlett-packard');

-- Numeral 7
SELECT p.nombre, p.precio, f.nombre FROM producto p, fabricante f 
WHERE p.codigo_fabricante = f.codigo AND p.precio >= 180
ORDER BY p.precio DESC, p.nombre;


/* Consultas multitabla JOIN */

-- Numeral 1
SELECT f.*, p.* FROM fabricante f LEFT JOIN producto p 
ON f.codigo = p.codigo_fabricante;

-- Numeral 2 (Opción 1)
SELECT f.* FROM fabricante f LEFT JOIN producto p 
ON f.codigo = p.codigo_fabricante
WHERE p.codigo IS NULL;

-- Numeral 2 (Opción 2)
SELECT f.* FROM fabricante f LEFT JOIN producto p 
ON f.codigo = p.codigo_fabricante
GROUP BY f.codigo HAVING COUNT(p.codigo) = 0;


/* Subconsultas */

-- Numeral 1

SELECT * FROM producto WHERE codigo_fabricante = (
	SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');

-- Numeral 2
SELECT * FROM producto WHERE precio = (
	SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (
		SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Numeral 3
SELECT nombre FROM producto WHERE precio = (
	SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (
		SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

-- Numeral 4 (Opción 1)
SELECT * FROM producto WHERE codigo_fabricante = (
	SELECT codigo FROM fabricante WHERE nombre = 'Asus')
AND precio > (
	SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (
		SELECT codigo FROM fabricante WHERE nombre = 'Asus'));

-- Numeral 4 (Opción 2)
SET @codigo_asus = (SELECT codigo FROM fabricante WHERE nombre = 'Asus');

SELECT * FROM producto WHERE codigo_fabricante = @codigo_asus AND precio > (
	SELECT AVG(precio) FROM producto WHERE codigo_fabricante = @codigo_asus);


/* Subconsultas con IN y NOT IN */

-- Numeral 1
SELECT DISTINCT f.nombre FROM fabricante f, producto p WHERE f.codigo IN (
	SELECT DISTINCT codigo_fabricante FROM producto); 

-- Numeral 2
SELECT DISTINCT f.nombre FROM fabricante f, producto p WHERE f.codigo NOT IN (
	SELECT DISTINCT codigo_fabricante FROM producto);


/* Subconsultas (En la cláusula HAVING) */

-- Numeral 1 (Con subconsulta)
SELECT f.nombre, COUNT(p.codigo_fabricante) cantidad 
FROM fabricante f, producto p 
WHERE f.codigo = p.codigo_fabricante 
GROUP BY p.codigo_fabricante
HAVING cantidad = (
	SELECT COUNT(p.codigo_fabricante) 
	FROM producto p GROUP BY p.codigo_fabricante 
	HAVING p.codigo_fabricante = (
		SELECT codigo FROM fabricante 
		WHERE nombre = 'Lenovo')); 

-- Numeral 1 (Sin subconsulta)
SET @productos_lenovo = (SELECT COUNT(p.codigo_fabricante) 
FROM producto p GROUP BY p.codigo_fabricante 
HAVING p.codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo'));

SELECT f.nombre, COUNT(p.codigo_fabricante) cantidad 
FROM fabricante f, producto p 
WHERE f.codigo = p.codigo_fabricante 
GROUP BY p.codigo_fabricante
HAVING cantidad = @productos_lenovo; 

