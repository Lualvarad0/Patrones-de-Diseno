# Builder en COBOL

## El problema, en código

Tu sistema de delivery de pizzas arma cada pedido con un único párrafo que
recibe todos los ingredientes como parámetros posicionales:

```cobol
call "crear-pizza" using "LARGE" 1 0 1 0 1 0
*>                         size  cheese pepperoni mushrooms olives extra-cheese thin-crust
```

¿Qué significa ese `1 0 1 0 1 0`? Nadie lo sabe sin ir a mirar la
definición del párrafo `crear-pizza` y contar parámetros con el dedo. Si el
negocio agrega un ingrediente nuevo (aceitunas negras) en el medio de la
lista, **todos** los `call "crear-pizza"` existentes en el código quedan con
sus argumentos corridos de lugar — y COBOL no te avisa, porque un `pic 9`
encaja en cualquier posición de otro `pic 9`.

## Así queda con Builder aplicado

Mirá [`builder.cbl`](builder.cbl) de esta carpeta: la clase `pizza-builder`
(línea 9) tiene un método encadenable por ingrediente (`with-size`,
`add-cheese`, `add-pepperoni`, `add-mushrooms`, líneas 20-44), y cada uno
devuelve `self` (por ejemplo línea 25) para poder seguir encadenando — en
COBOL OO eso significa pasar `self` como `returning result` y que quien
llama guarde ese resultado para la siguiente invocación. Un método final
`build` (línea 46) arma y devuelve el texto final de la pizza.

El párrafo principal (líneas 93-97) arma la pizza con nombres explícitos en
cada paso: `invoke pz "with-size" using "large" returning pz`, después
`invoke pz "add-cheese" returning pz`, y así — se lee de corrido y dice
exactamente qué lleva la pizza, sin contar posiciones. Agregar aceitunas
mañana es un método `add-olives` nuevo: el código existente que no lo llama
simplemente no lleva aceitunas, nada se corre de lugar.
