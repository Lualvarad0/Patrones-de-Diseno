# Abstract Factory

**Categoría:** Creacional

## Problema

Necesitas crear **familias de objetos relacionados** (por ejemplo, botones
y checkboxes de un tema "claro" o de un tema "oscuro") y asegurarte de que
nunca se mezclen objetos de familias distintas en el mismo contexto.

## Solución

Defines una interfaz de fábrica con un método de creación por cada tipo de
producto de la familia (`createButton()`, `createCheckbox()`), y una
implementación concreta de esa fábrica por cada familia. El cliente recibe
una fábrica concreta (normalmente por configuración o inyección) y crea
todo a través de ella, sin saber qué familia es.

## Cuándo usarlo

- Cuando tu sistema debe ser independiente de cómo se crean, componen y
  representan sus productos, y necesitas garantizar consistencia entre
  productos relacionados (mismo tema, mismo motor gráfico, mismo proveedor
  de base de datos).

## Relación con Factory Method

Una Abstract Factory suele implementarse usando varios Factory Methods, uno
por producto.

## En este repositorio

⬜ Pendiente de implementación — ¡contribuciones bienvenidas! Ver
[CONTRIBUTING.md](../../../CONTRIBUTING.md).
