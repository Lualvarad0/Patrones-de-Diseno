# Builder en C#

## El problema, en código

Tu app de delivery de pizzas modela cada pizza con un constructor que
recibe todos los ingredientes como parámetros:

```csharp
public class Pizza
{
    public Pizza(string size, bool cheese, bool pepperoni, bool mushrooms,
                 bool olives, bool extraCheese, bool thinCrust)
    {
        // ...
    }
}

// en el código que arma el pedido:
var pizza = new Pizza("large", true, false, true, false, true, false);
```

¿Qué significa ese `true, false, true, false, true, false`? Nadie lo sabe
sin ir a mirar la firma del constructor y contar parámetros con el dedo.
Si el negocio agrega un ingrediente nuevo (aceitunas negras) en el medio de
la lista, **todos** los `new Pizza(...)` existentes en el código quedan con
sus argumentos corridos de lugar — y el compilador no te avisa, porque
`true`/`false` encaja en cualquier posición booleana.

## Así queda con Builder aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `PizzaBuilder` (línea 20)
tiene un método encadenable por ingrediente (`WithSize`, `AddCheese`,
`AddPepperoni`, `AddMushrooms`, líneas 24-46), y cada uno devuelve `this`
(línea 27) para poder seguir encadenando. Un método final `Build()` (línea
48) entrega la `Pizza` ya armada.

El `Main` (líneas 55-59) arma la pizza con nombres explícitos en cada paso:
`.WithSize("large").AddCheese().AddPepperoni()` — se lee en voz alta y
dice exactamente qué lleva la pizza, sin contar posiciones. Agregar
aceitunas mañana es un método `AddOlives()` nuevo: el código existente que
no lo llama simplemente no lleva aceitunas, nada se corre de lugar.
