# Facade

**Categoría:** Estructural

## Problema

Un subsistema tiene muchas clases, con relaciones e interfaces complejas
entre ellas, y la mayoría del código cliente solo necesita una operación
simple de alto nivel — pero termina teniendo que conocer y coordinar todas
esas clases internas.

## Solución

Creas una clase "fachada" con una interfaz simple que, por dentro, conoce
y coordina las piezas del subsistema complejo. El cliente habla solo con
la fachada; el subsistema sigue existiendo y puede seguir usándose
directamente por quien lo necesite.

## Cuándo usarlo

- Para dar un punto de entrada simple a una librería o subsistema complejo.
- Para desacoplar el código cliente de los detalles internos de un
  subsistema que cambia con frecuencia.

## Cuándo NO usarlo

- Si la fachada termina exponiendo casi todos los métodos del subsistema
  igual, no está simplificando nada — revisa si de verdad reduce la
  complejidad percibida por el cliente.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
