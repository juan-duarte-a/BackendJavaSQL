USE pokemondb;

-- Numeral 1
SELECT nombre FROM pokemon;

-- Numeral 2
SELECT * FROM pokemon WHERE peso < 10; 

-- Numeral 3
SELECT p.nombre, t.nombre tipo 
FROM pokemon p, pokemon_tipo pt, tipo t
WHERE p.numero_pokedex = pt.numero_pokedex
AND pt.id_tipo = t.id_tipo 
AND t.nombre = 'Agua';

-- Numeral 4
SELECT p.nombre, t.nombre tipo 
FROM pokemon p, pokemon_tipo pt, tipo t
WHERE p.numero_pokedex = pt.numero_pokedex
AND pt.id_tipo = t.id_tipo 
AND t.nombre IN ('Agua', 'Fuego', 'Tierra')
ORDER BY t.nombre;

-- Numeral 5
SELECT p.nombre, t.nombre tipo 
FROM pokemon p, pokemon_tipo pt, tipo t 
WHERE p.numero_pokedex = pt.numero_pokedex
AND pt.id_tipo = t.id_tipo
AND t.nombre IN ('Fuego', 'Volador');

-- Numeral 6
SELECT p.nombre, e.ps 
FROM pokemon p, estadisticas_base e
WHERE p.numero_pokedex = e.numero_pokedex
AND e.ps > 200;

-- Numeral 7
SELECT nombre, peso, altura FROM pokemon
WHERE numero_pokedex = (
	SELECT pokemon_origen FROM evoluciona_de
	WHERE pokemon_evolucionado = (
		SELECT numero_pokedex FROM pokemon 
		WHERE nombre = 'Arbok'));

-- Numeral 8
SELECT p.* 
FROM 
	pokemon p, 
    pokemon_forma_evolucion pfe, 
    forma_evolucion fe,
    tipo_evolucion te
WHERE p.numero_pokedex = pfe.numero_pokedex
AND pfe.id_forma_evolucion = fe.id_forma_evolucion
AND fe.tipo_evolucion = te.id_tipo_evolucion
AND te.tipo_evolucion = 'Intercambio';

-- Numeral 9
SELECT nombre FROM movimiento
ORDER BY prioridad DESC LIMIT 1;

-- Numeral 10
SELECT * FROM pokemon
ORDER BY peso DESC LIMIT 1;

-- Numeral 11
SELECT ta.tipo, m.nombre 
FROM tipo_ataque ta, tipo t, movimiento m
WHERE ta.id_tipo_ataque = t.id_tipo_ataque
AND t.id_tipo = m.id_tipo
AND m.potencia = (
	SELECT potencia FROM movimiento
    ORDER BY potencia DESC LIMIT 1);

-- Numeral 12 (Por tipo de Pokémon)
SELECT t.nombre, COUNT(m.id_tipo) 
FROM movimiento m, tipo t
WHERE m.id_tipo = t.id_tipo
GROUP BY m.id_tipo;

-- Numeral 12 (Por tipo de ataque)
SELECT ta.tipo, COUNT(m.id_tipo)
FROM movimiento m, tipo t, tipo_ataque ta
WHERE m.id_tipo = t.id_tipo
AND t.id_tipo_ataque = ta.id_tipo_ataque
GROUP BY t.id_tipo_ataque;

-- Numeral 13
SELECT id_movimiento, nombre, descripcion FROM movimiento
WHERE descripcion LIKE '%enven%';

-- Numeral 14
SELECT id_movimiento, nombre, descripcion FROM movimiento
WHERE descripcion LIKE '%causa daño%' 
ORDER BY nombre;

-- Numeral 15
SELECT DISTINCT m.*
FROM
	movimiento m,
    pokemon_movimiento_forma pmf,
    pokemon p
WHERE m.id_movimiento = pmf.id_movimiento
AND pmf.numero_pokedex = p.numero_pokedex
AND p.nombre = 'Pikachu';

-- Numeral 16
SELECT m.*
FROM
	movimiento m,
    pokemon_movimiento_forma pmf,
    forma_aprendizaje fa,
    pokemon p,
    MT
WHERE m.id_movimiento = pmf.id_movimiento
AND pmf.id_forma_aprendizaje = fa.id_forma_aprendizaje
AND pmf.numero_pokedex = p.numero_pokedex
AND p.nombre = 'Pikachu'
AND fa.id_forma_aprendizaje = MT.id_forma_aprendizaje;

-- Numeral 17
SELECT DISTINCT m.*, t.nombre tipo
FROM 
	pokemon p,
    pokemon_movimiento_forma pmf,
    movimiento m,
    tipo t
WHERE p.nombre = 'Pikachu'
AND p.numero_pokedex = pmf.numero_pokedex
AND pmf.id_movimiento = m.id_movimiento
AND m.id_tipo = t.id_tipo
AND t.nombre = 'Normal';

-- Numeral 18
SELECT m.*, mef.probabilidad
FROM
	movimiento m, 
    movimiento_efecto_secundario mef, 
    efecto_secundario es
WHERE m.id_movimiento = mef.id_movimiento
AND mef.id_efecto_secundario = es.id_efecto_secundario
AND mef.probabilidad > 30;

-- Numeral 19
SELECT p.* 
FROM
	pokemon p,
    pokemon_forma_evolucion pfe,
    forma_evolucion fe,
    piedra
WHERE p.numero_pokedex = pfe.numero_pokedex
AND pfe.id_forma_evolucion = fe.id_forma_evolucion
AND fe.id_forma_evolucion = piedra.id_forma_evolucion;

-- Numeral 20
SELECT DISTINCT(p.numero_pokedex), p.nombre 
FROM pokemon p, evoluciona_de e
WHERE p.numero_pokedex NOT IN (
	SELECT pokemon_origen FROM evoluciona_de);

-- Numeral 21
SELECT t.nombre tipo, COUNT(p.numero_pokedex) cantidad
FROM tipo t, pokemon_tipo pt, pokemon p
WHERE p.numero_pokedex = pt.numero_pokedex
AND pt.id_tipo = t.id_tipo
GROUP BY t.id_tipo;
