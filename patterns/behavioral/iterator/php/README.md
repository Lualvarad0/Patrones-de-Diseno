# Iterator en PHP

## El problema, en código

Tu `BookCollection` guarda los títulos en un arreglo público, y todo el
código que necesita recorrerlos accede directo a ese arreglo:

```php
class BookCollection
{
    public array $books = []; // expuesto directamente
}

// en cada lugar que recorre la colección:
for ($i = 0; $i < count($collection->books); $i++) {
    echo $collection->books[$i] . "\n";
}
// si mañana cambiás el arreglo por otra estructura,
// hay que reescribir cada uno de estos bucles en todo el código
```

El código cliente queda atado a que la colección sea exactamente un
arreglo indexable; cambiar la estructura interna de `BookCollection`
rompe cada lugar que la recorre con un `for` indexado.

## Así queda con Iterator aplicado

Mirá [`Iterator.php`](Iterator.php) de esta carpeta: `BookCollection`
(línea 8) mantiene `$books` privado — `createIterator()` (línea 17)
devuelve un `BookIterator` (línea 23), que es el único que sabe cómo
recorrerla, con `hasNext()` (línea 29) y `next()` (línea 34).

El bloque de demo (línea 41) nunca toca `$books` directamente: pide un
iterador con `$collection->createIterator()` (línea 46) y lo recorre con
`while ($iterator->hasNext())` (líneas 47-49). Si `BookCollection`
cambiara su almacenamiento interno de un arreglo a cualquier otra
estructura, este bucle no se entera — sigue llamando
`hasNext()`/`next()` igual.
