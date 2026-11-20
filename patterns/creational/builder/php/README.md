# Builder en PHP

## El problema, en código

Tu app de delivery de pizzas modela cada pizza con un constructor que
recibe todos los ingredientes como parámetros:

```php
class Pizza
{
    public function __construct(
        string $size, bool $cheese, bool $pepperoni, bool $mushrooms,
        bool $olives, bool $extraCheese, bool $thinCrust
    ) {
        // ...
    }
}

// en el código que arma el pedido:
$pizza = new Pizza("large", true, false, true, false, true, false);
```

¿Qué significa ese `true, false, true, false, true, false`? Nadie lo sabe
sin ir a mirar la firma del constructor y contar parámetros con el dedo. Si
el negocio agrega un ingrediente nuevo (aceitunas negras) en el medio de la
lista, **todos** los `new Pizza(...)` existentes en el código quedan con sus
argumentos corridos de lugar — PHP permite pasar argumentos con nombre
(`size: "large"`), pero nada te obliga a usarlos, y en código viejo
raramente se hace.

## Así queda con Builder aplicado

Mirá [`Builder.php`](Builder.php) de esta carpeta: `PizzaBuilder` (línea 22)
tiene un método encadenable por ingrediente (`withSize`, `addCheese`,
`addPepperoni`, `addMushrooms`, líneas 31-53), y cada uno devuelve `$this`
(línea 34) para poder seguir encadenando. Un método final `build()` (línea
55) entrega la `Pizza` ya armada.

El bloque de demo (líneas 62-66) arma la pizza con nombres explícitos en
cada paso: `->withSize("large")->addCheese()->addPepperoni()` — se lee en
voz alta y dice exactamente qué lleva la pizza, sin contar posiciones.
Agregar aceitunas mañana es un método `addOlives()` nuevo: el código
existente que no lo llama simplemente no lleva aceitunas, nada se corre de
lugar.
