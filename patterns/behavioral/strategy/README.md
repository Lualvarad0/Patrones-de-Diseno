# Strategy

**Categoría:** Comportamiento

## Problema

Tienes varias formas de hacer lo mismo (distintos algoritmos de
ordenamiento, distintas formas de calcular un descuento, distintas rutas
de navegación) y tu código termina lleno de `if/else` o `switch` gigantes
para elegir cuál usar, repetidos en varios lugares.

## Solución

Extraes cada algoritmo a su propia clase que implementa una interfaz común
(`ejecutar()`, `calcular()`). El objeto que necesita el algoritmo recibe
una "estrategia" concreta (por constructor, setter, o parámetro) y la
invoca sin saber cuál es exactamente — simplemente confía en la interfaz.

## Cuándo usarlo

- Cuando tienes múltiples variantes de un mismo algoritmo y quieres poder
  intercambiarlas en tiempo de ejecución.
- Para eliminar condicionales grandes que seleccionan comportamiento.

## Cuándo NO usarlo

- Si solo tienes una o dos variantes que nunca cambian, una función normal
  o un simple `if` es más directo que crear una jerarquía de clases.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
