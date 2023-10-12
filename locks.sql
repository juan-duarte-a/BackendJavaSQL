USE nba;

/* Candado A */
-- Posición
SELECT COUNT(Asistencias_por_partido) posición FROM estadisticas
WHERE Asistencias_por_partido = (
	SELECT MAX(Asistencias_por_partido) FROM estadisticas);
	
-- Clave
SELECT SUM(j.Peso) clave FROM jugadores j, equipos e 
WHERE j.Nombre_equipo = e.Nombre 
AND e.Conferencia = 'East'
AND j.Posicion LIKE '%C%';

/* Candado B */
-- Posición
SELECT COUNT(jugador) posición FROM estadisticas
WHERE Asistencias_por_partido > (
	SELECT COUNT(Nombre_equipo) FROM jugadores
	WHERE Nombre_equipo = 'Heat');

-- Clave
SELECT COUNT(*) clave FROM partidos 
WHERE temporada LIKE '%99%';

/* Candado C */
-- Posición
SET @valor1 = (SELECT COUNT(*) 
FROM jugadores j, equipos e
WHERE j.Procedencia = 'Michigan'
AND j.Nombre_equipo = e.Nombre 
AND e.Conferencia = 'West');

SET @valor2 = (SELECT COUNT(codigo) 
FROM jugadores 
WHERE Peso >= 195);

SELECT @valor1, @valor2, ((@valor1/@valor2) + 0.9945) posición;

-- Clave
WITH calculos AS (
	SELECT 
		AVG(e.Puntos_por_partido) prom_puntos, 
		COUNT(e.Asistencias_por_partido) cont_asistencias, 
		SUM(e.Tapones_por_partido) sum_tapones 
	FROM estadisticas e, jugadores j, equipos eq
	WHERE e.jugador = j.codigo
	AND j.Nombre_equipo = eq.Nombre
	AND eq.Division = 'Central')
SELECT FLOOR(prom_puntos + cont_asistencias + sum_tapones)
FROM calculos;

/* Candado D */
-- Posición
SELECT ROUND(e.Tapones_por_partido) posición FROM estadisticas e, jugadores j
WHERE j.codigo = e.jugador AND j.Nombre = 'Corey Maggette' AND e.temporada = '00/01'; 

-- Clave
SELECT FLOOR(SUM(e.Puntos_por_partido)) clave FROM estadisticas e, jugadores j
WHERE e.jugador = j.codigo AND j.Procedencia = 'Argentina';
