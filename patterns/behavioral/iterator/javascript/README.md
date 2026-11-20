# Iterator en JavaScript

## El problema, en código

Tu `BookCollection` guarda los títulos en un arreglo público, y todo el
código que necesita recorrerlos accede directo a ese arreglo:

```javascript
class BookCollection {
  books = []; // expuesto directamente
}

// en cada lugar que recorre la colección:
for (let i = 0; i < collection.books.length; i++) {
  console.log(collection.books[i]);
}
// si mañana cambiás el arreglo por un Map o una estructura distinta,
// hay que reescribir cada uno de estos bucles en todo el código
```

El código cliente queda atado a que la colección sea exactamente un
arreglo indexable; cambiar la estructura interna de `BookCollection`
rompe cada lugar que la recorre con un `for` indexado.

## Así queda con Iterator aplicado

Mirá [`iterator.js`](iterator.js) de esta carpeta: `BookCollection`
(línea 7) no expone `#books` directamente (es un campo privado) —
`createIterator()` (línea 14) devuelve un `BookIterator` (línea 19), que
es el único que sabe cómo recorrerla, con `hasNext()` (línea 27) y
`next()` (línea 31).

El bloque de demo (línea 37) nunca toca `#books` directamente: pide un
iterador con `collection.createIterator()` (línea 42) y lo recorre con
`while (iterator.hasNext())` (líneas 43-45). Si `BookCollection` cambiara
su almacenamiento interno de un arreglo a cualquier otra estructura, este
bucle no se entera — sigue llamando `hasNext()`/`next()` igual.
