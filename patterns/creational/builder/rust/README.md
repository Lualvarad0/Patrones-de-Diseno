# Builder en Rust

## El problema, en código

Tu app de delivery de pizzas modela cada pizza con una función constructora
que recibe todos los ingredientes como parámetros posicionales:

```rust
struct Pizza { /* ... */ }

impl Pizza {
    fn new(size: &str, cheese: bool, pepperoni: bool, mushrooms: bool,
           olives: bool, extra_cheese: bool, thin_crust: bool) -> Self {
        // ...
    }
}

// en el código que arma el pedido:
let pizza = Pizza::new("large", true, false, true, false, true, false);
```

¿Qué significa ese `true, false, true, false, true, false`? Nadie lo sabe
sin ir a mirar la firma de `new` y contar parámetros con el dedo. Si el
negocio agrega un ingrediente nuevo (aceitunas negras) en el medio de la
lista, **todos** los `Pizza::new(...)` existentes en el código quedan con
sus argumentos corridos de lugar — y el compilador no te avisa, porque
`true`/`false` encaja en cualquier posición `bool`.

## Así queda con Builder aplicado

Mirá [`builder.rs`](builder.rs) de esta carpeta: `PizzaBuilder` (línea 23)
tiene un método encadenable por ingrediente (`with_size`, `add_cheese`,
`add_pepperoni`, `add_mushrooms`, líneas 35-53). A diferencia de otros
lenguajes, acá cada método toma `self` **por valor** (`mut self`) y devuelve
`Self` (línea 37) — es el estilo idiomático de Rust: cada llamada "mueve"
el builder hacia adelante en vez de mutar una referencia compartida. Un
método final `build()` (línea 55) consume el builder y entrega la `Pizza`.

El `main` (líneas 61-65) arma la pizza con nombres explícitos en cada paso:
`.with_size("large").add_cheese().add_pepperoni()` — se lee en voz alta y
dice exactamente qué lleva la pizza, sin contar posiciones. Agregar
aceitunas mañana es un método `add_olives()` nuevo: el código existente que
no lo llama simplemente no lleva aceitunas, nada se corre de lugar.
