USE personal;

-- Numeral 1
SELECT *
FROM empleados;

-- Numeral 2
SELECT *
FROM departamentos;

-- Numeral 3
SELECT nombre_depto
FROM departamentos;

-- Numeral 4
SELECT nombre, sal_emp
FROM empleados;

-- Numeral 5
SELECT comision_emp
FROM empleados;

-- Numeral 6
SELECT *
FROM empleados
WHERE cargo_emp LIKE 'secretaria';

-- Numeral 7
SELECT *
FROM empleados
WHERE cargo_emp LIKE 'vendedor'
ORDER BY nombre;

-- Numeral 8
SELECT nombre,
       cargo_emp
FROM empleados
ORDER BY sal_emp;

-- Numeral 9
SELECT nombre_jefe_depto
FROM departamentos
WHERE ciudad LIKE 'ciudad real';

-- Numeral 10
SELECT nombre AS Nombre, cargo_emp AS Cargo
FROM empleados;

-- Numeral 11
SELECT sal_emp, comision_emp
FROM empleados
WHERE id_depto = 2000
ORDER BY comision_emp;

-- Numeral 12
SELECT nombre,
       (sal_emp + comision_emp + 500000) AS "Sueldo Total"
FROM empleados
WHERE id_depto = 3000
ORDER BY nombre;

-- Numeral 13
SELECT *
FROM empleados
WHERE nombre LIKE 'j%';

-- Numeral 14
SELECT sal_emp, comision_emp,
       (sal_emp + comision_emp) AS 'Salario total',
       nombre
FROM empleados
WHERE comision_emp > 1000000;

-- Numeral 15
SELECT sal_emp, comision_emp,
       (sal_emp + comision_emp) AS 'Salario total',
       nombre
FROM empleados
WHERE comision_emp = 0;

-- Numeral 16
SELECT *
FROM empleados
WHERE comision_emp > sal_emp;

-- Numeral 17
SELECT *
FROM empleados
WHERE comision_emp <= sal_emp * 0.3;

-- Numeral 18
SELECT *
FROM empleados
WHERE nombre NOT LIKE '%ma%';

-- Numeral 19
SELECT nombre_depto
FROM departamentos
WHERE nombre_depto IN ('VENTAS',
                       'INVESTIGACIÓN',
                       'MANTENIMIENTO');

-- Numeral 20
SELECT nombre_depto
FROM departamentos
WHERE nombre_depto NOT IN ('VENTAS',
                           'INVESTIGACIÓN',
                           'MANTENIMIENTO');

-- Numeral 21
SELECT MAX(sal_emp) AS 'Salario máximo'
FROM empleados;

-- Numeral 22
SELECT nombre
FROM empleados
ORDER BY nombre DESC
LIMIT 1;

-- Numeral 23
SELECT MAX(sal_emp) AS 'Salario máximo',
       MIN(sal_emp) AS 'Salario mínimo',
       (MAX(sal_emp) - MIN(sal_emp)) AS Diferencia
FROM empleados;

-- Numeral 24
SELECT e.id_depto, d.nombre_depto, AVG(e.sal_emp)
FROM empleados e, departamentos d WHERE e.id_depto = d.id_depto 
GROUP BY e.id_depto;

-- Numeral 25
SELECT d.nombre_depto, COUNT(e.id_emp) AS cantidad
FROM departamentos d, empleados e
WHERE d.id_depto = e.id_depto
GROUP BY d.id_depto
HAVING cantidad > 3;

-- Numeral 26 (Opción 1)
SELECT d.id_depto, d.nombre_depto
FROM departamentos d
LEFT JOIN empleados e ON d.id_depto = e.id_depto
GROUP BY d.id_depto
HAVING COUNT(e.id_depto) = 0;

-- Numeral 26 (Opción 2)
SELECT d.id_depto, d.nombre_depto
FROM departamentos d
LEFT JOIN empleados e 
ON d.id_depto = e.id_depto
WHERE e.id_depto IS NULL;

-- Numeral 27 (28 en la guía)
SELECT * 
FROM empleados 
WHERE sal_emp > (SELECT AVG(sal_emp) FROM empleados);
