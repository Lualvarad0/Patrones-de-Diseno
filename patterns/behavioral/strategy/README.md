# Strategy

**Categoría:** Comportamiento

## Problema

Estás armando el checkout de un e-commerce. Al principio solo aceptabas
tarjeta de crédito, así que la lógica de cobro vivía directamente adentro de
`Checkout()`. El negocio pidió sumar PayPal, y agregaste un
`if (metodo == "paypal")`. Ahora piden sumar criptomonedas y transferencia
bancaria. `Checkout()` ya es un bloque de 80 líneas con un `if/else` (o
`switch`) por cada método de pago, cualquier cambio en la lógica de uno
arriesga romper los demás porque comparten el mismo bloque de código, y
probar un solo método de pago aislado requiere ejecutar igual toda la
función con todas sus ramas.

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

## Dónde lo vas a encontrar en la vida real

- `Array.prototype.sort(compareFn)` en JavaScript o
  `Collections.sort(lista, comparador)` en Java: le pasás el algoritmo de
  comparación como una pieza intercambiable.
- Google Maps dejándote elegir entre ruta "más rápida", "más corta" o
  "evitar peajes" para el mismo origen y destino.
- Un checkout que acepta tarjeta, PayPal o criptomonedas: cada forma de pago
  es una estrategia intercambiable detrás de un mismo "procesar pago".
- Los formatos de compresión dentro de un archivo ZIP: cada archivo interno
  puede comprimirse con una estrategia distinta.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
