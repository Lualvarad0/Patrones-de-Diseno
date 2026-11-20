# Builder en JavaScript

## El problema, en código

Tu app de delivery de pizzas modela cada pizza con una función que recibe
todos los ingredientes como parámetros posicionales:

```js
function createPizza(size, cheese, pepperoni, mushrooms, olives, extraCheese, thinCrust) {
  // ...
}

// en el código que arma el pedido:
const pizza = createPizza("large", true, false, true, false, true, false);
```

¿Qué significa ese `true, false, true, false, true, false`? Nadie lo sabe
sin ir a mirar la firma de la función y contar parámetros con el dedo. Si el
negocio agrega un ingrediente nuevo (aceitunas negras) en el medio de la
lista, **todos** los `createPizza(...)` existentes en el código quedan con
sus argumentos corridos de lugar — y JavaScript no te avisa, porque no hay
ningún chequeo de tipos que lo impida.

## Así queda con Builder aplicado

Mirá [`builder.js`](builder.js) de esta carpeta: `PizzaBuilder` (línea 19)
tiene un método encadenable por ingrediente (`withSize`, `addCheese`,
`addPepperoni`, `addMushrooms`, líneas 22-40), y cada uno devuelve `this`
(línea 24) para poder seguir encadenando. Un método final `build()` (línea
42) entrega la `Pizza` ya armada.

El bloque de demo (línea 48) arma la pizza con nombres explícitos en cada
paso: `.withSize("large").addCheese().addPepperoni()` — se lee en voz alta y
dice exactamente qué lleva la pizza, sin contar posiciones. Agregar
aceitunas mañana es un método `addOlives()` nuevo: el código existente que
no lo llama simplemente no lleva aceitunas, nada se corre de lugar.
