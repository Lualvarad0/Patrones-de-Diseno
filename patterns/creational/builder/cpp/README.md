# Builder en C++

## El problema, en código

Tu app de delivery de pizzas modela cada pizza con un constructor que
recibe todos los ingredientes como parámetros:

```cpp
class Pizza {
public:
    Pizza(std::string size, bool cheese, bool pepperoni, bool mushrooms,
          bool olives, bool extraCheese, bool thinCrust) {
        // ...
    }
};

// en el código que arma el pedido:
Pizza pizza("large", true, false, true, false, true, false);
```

¿Qué significa ese `true, false, true, false, true, false`? Nadie lo sabe
sin ir a mirar la firma del constructor y contar parámetros con el dedo. Si
el negocio agrega un ingrediente nuevo (aceitunas negras) en el medio de la
lista, **todos** los `Pizza(...)` existentes en el código quedan con sus
argumentos corridos de lugar — y el compilador no te avisa, porque
`true`/`false` encaja en cualquier posición `bool`.

## Así queda con Builder aplicado

Mirá [`builder.cpp`](builder.cpp) de esta carpeta: `PizzaBuilder` (línea
29) tiene un método encadenable por ingrediente (`withSize`, `addCheese`,
`addPepperoni`, `addMushrooms`, líneas 31-49), y cada uno devuelve una
referencia a `*this` (línea 33) para poder seguir encadenando. Un método
final `build()` (línea 51) entrega la `Pizza` ya armada.

El `main` (líneas 60-64) arma la pizza con nombres explícitos en cada paso:
`.withSize("large").addCheese().addPepperoni()` — se lee en voz alta y dice
exactamente qué lleva la pizza, sin contar posiciones. Agregar aceitunas
mañana es un método `addOlives()` nuevo: el código existente que no lo
llama simplemente no lleva aceitunas, nada se corre de lugar.
