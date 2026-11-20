# Prototype en PHP

## El problema, en código

Necesitás una copia independiente de una `Sheep` en varios lugares del
código (un botón de "Duplicar", un endpoint de la API, un test). Sin
Prototype, cada uno de esos lugares arma la copia a mano, campo por campo:

```php
// en tres archivos distintos del proyecto...
$copy = new Sheep($original->name, $original->color);
```

Esto funciona hasta que `Sheep` crece: el negocio pide agregar `$age` y
`$breed`. Vas, agregás los campos a la clase... pero los tres lugares que
copiaban "a mano" siguen copiando solo `name` y `color` — nadie les avisó.
El bug es silencioso: la copia corre perfecto, solo que `$copy->age` queda
en `null` en vez del valor real, y nadie se da cuenta hasta que alguien
nota datos raros en producción.

## Así queda con Prototype aplicado

Mirá [`Prototype.php`](Prototype.php) de esta carpeta: PHP trae este
patrón incorporado al lenguaje con la palabra clave `clone` (línea 21) —
`clone $original` copia automáticamente **todas** las propiedades públicas
del objeto, sin que vos tengas que listarlas a mano. Si mañana agregás
`$age` a la clase, no hay que tocar ningún código de copiado: `clone`
sigue copiando todo, incluido el campo nuevo.

El comentario de las líneas 4-8 también marca algo importante: por defecto
`clone` hace una copia **superficial**, suficiente acá porque `name`/
`color` son strings. Si `Sheep` tuviera una propiedad con un objeto o array
mutable adentro, habría que implementar el método mágico `__clone()` para
copiar también esos datos internos — si no, el original y el clon
terminarían compartiendo (y corrompiendo entre sí) la misma referencia.
