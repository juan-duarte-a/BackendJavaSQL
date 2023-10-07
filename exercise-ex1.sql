USE nba;

-- Numeral 1
SELECT Nombre FROM jugadores ORDER BY Nombre;

-- Numeral 2
SELECT Nombre FROM jugadores WHERE Posicion = 'C' AND Peso > 200 ORDER BY Nombre;

-- Numeral 3
SELECT Nombre FROM equipos ORDER BY Nombre;

-- Numeral 4
SELECT Nombre FROM equipos WHERE Conferencia = 'East';

-- Numeral 5
SELECT * FROM equipos WHERE Ciudad LIKE 'C%';

-- Numeral 6
SELECT j.*, e.* FROM jugadores j, equipos e
WHERE j.Nombre_equipo = e.Nombre
ORDER BY e.Nombre;

-- Numeral 7
SELECT * FROM jugadores WHERE Nombre_equipo = 'Raptors' ORDER BY Nombre;

-- Numeral 8
SELECT e.Puntos_por_partido, e.temporada  
FROM estadisticas e, jugadores j
WHERE e.jugador = j.codigo AND j.Nombre = 'Pau Gasol';

-- Numeral 9
SELECT e.Puntos_por_partido, e.temporada  
FROM estadisticas e, jugadores j
WHERE e.jugador = j.codigo AND j.Nombre = 'Pau Gasol'
AND e.temporada = '04/05';

-- Numeral 10
SELECT j.Nombre, AVG(e.Puntos_por_partido) 
FROM estadisticas e, jugadores j
WHERE e.jugador = j.codigo
GROUP BY j.codigo;

-- Numeral 11
SELECT Nombre_equipo, COUNT(codigo) Jugadores FROM jugadores GROUP BY Nombre_equipo;

-- Numeral 12
SELECT j.Nombre, AVG(e.Puntos_por_partido) puntos
FROM estadisticas e, jugadores j
WHERE e.jugador = j.codigo
GROUP BY j.codigo
ORDER BY puntos DESC
LIMIT 1;

-- Numeral 13
SELECT j.Nombre, j.Altura, e.Nombre, e.Conferencia, e.Division
FROM jugadores j, equipos e
WHERE j.Nombre_equipo = e.Nombre 
AND j.Altura = (SELECT MAX(Altura) FROM jugadores);

