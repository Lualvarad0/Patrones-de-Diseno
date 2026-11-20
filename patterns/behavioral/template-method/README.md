# Template Method

**Categoría:** Comportamiento

## Problema

Varias clases comparten el **mismo esqueleto de algoritmo** (preparar →
procesar → finalizar), pero uno o más de esos pasos varía según la
subclase, y terminas duplicando el esqueleto completo en cada una solo
para cambiar un paso.

## Solución

En la clase base defines el método "plantilla" con el esqueleto completo
del algoritmo, llamando a métodos (algunos con implementación por
defecto, otros abstractos) que las subclases sobrescriben para los pasos
que varían. El orden y la estructura general del algoritmo quedan fijos
en la clase base; solo los pasos "variables" cambian.

## Cuándo usarlo

- Cuando el flujo general de un algoritmo es siempre el mismo y solo
  cambian pasos específicos entre variantes.

## Diferencia con Strategy

Template Method usa herencia (las subclases redefinen pasos del
algoritmo); Strategy usa composición (inyectas un objeto que *es* el
algoritmo completo). Template Method es más rígido pero requiere menos
código para variantes pequeñas.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
