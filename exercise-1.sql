USE personal;

SELECT *
FROM empleados;

SELECT *
FROM departamentos;

SELECT nombre_depto
FROM departamentos;

SELECT nombre, sal_emp
FROM empleados;

SELECT comision_emp
FROM empleados;

SELECT *
FROM empleados
WHERE cargo_emp LIKE 'secretaria';

SELECT *
FROM empleados
WHERE cargo_emp LIKE 'vendedor'
ORDER BY nombre;

SELECT nombre,
       cargo_emp
FROM empleados
ORDER BY sal_emp;

SELECT nombre_jefe_depto
FROM departamentos
WHERE ciudad LIKE 'ciudad real';

SELECT nombre AS Nombre, cargo_emp AS Cargo
FROM empleados;

SELECT sal_emp, comision_emp
FROM empleados
WHERE id_depto = 2000
ORDER BY comision_emp;

SELECT nombre,
       (sal_emp + comision_emp + 500000) AS "Sueldo Total"
FROM empleados
WHERE id_depto = 3000
ORDER BY nombre;

SELECT *
FROM empleados
WHERE nombre LIKE 'j%';

SELECT sal_emp, comision_emp,
       (sal_emp + comision_emp) AS 'Salario total',
       nombre
FROM empleados
WHERE comision_emp > 1000000;

SELECT sal_emp, comision_emp,
       (sal_emp + comision_emp) AS 'Salario total',
       nombre
FROM empleados
WHERE comision_emp = 0;

SELECT *
FROM empleados
WHERE comision_emp > sal_emp;

SELECT *
FROM empleados
WHERE comision_emp <= sal_emp * 0.3;

SELECT *
FROM empleados
WHERE nombre NOT LIKE '%ma%';

SELECT nombre_depto
FROM departamentos
WHERE nombre_depto IN ('VENTAS',
                       'INVESTIGACIÓN',
                       'MANTENIMIENTO');

SELECT nombre_depto
FROM departamentos
WHERE nombre_depto NOT IN ('VENTAS',
                           'INVESTIGACIÓN',
                           'MANTENIMIENTO');

SELECT MAX(sal_emp) AS 'Salario máximo'
FROM empleados;

SELECT nombre
FROM empleados
ORDER BY nombre DESC
LIMIT 1;

SELECT MAX(sal_emp) AS 'Salario máximo',
       MIN(sal_emp) AS 'Salario mínimo',
       (MAX(sal_emp) - MIN(sal_emp)) AS Diferencia
FROM empleados;

SELECT e.id_depto, d.nombre_depto, AVG(e.sal_emp)
FROM empleados e, departamentos d WHERE e.id_depto = d.id_depto 
GROUP BY e.id_depto;

SELECT d.nombre_depto, COUNT(e.id_emp) AS cantidad
FROM departamentos d, empleados e
WHERE d.id_depto = e.id_depto
GROUP BY d.id_depto
HAVING cantidad > 3;

SELECT d.id_depto, d.nombre_depto
FROM departamentos d
LEFT JOIN empleados e ON d.id_depto = e.id_depto
GROUP BY d.id_depto
HAVING COUNT(e.id_depto) = 0;

SELECT * 
FROM empleados 
WHERE sal_emp > (SELECT AVG(sal_emp) FROM empleados);
