# Iterator en Java

## El problema, en código

Tu `BookCollection` guarda los títulos en una `List<String>` pública, y
todo el código que necesita recorrerlos accede directo a esa lista:

```java
class BookCollection {
    public List<String> books = new ArrayList<>(); // expuesta directamente
}

// en cada lugar que recorre la colección:
for (int i = 0; i < collection.books.size(); i++) {
    System.out.println(collection.books.get(i));
}
// si mañana cambiás ArrayList por un árbol o una base de datos,
// hay que reescribir cada uno de estos bucles en todo el código
```

El código cliente queda atado a que la colección sea exactamente una
`List` indexable; cambiar la estructura interna de `BookCollection` rompe
cada lugar que la recorre con un `for` indexado.

## Así queda con Iterator aplicado

Mirá [`IteratorDemo.java`](IteratorDemo.java) de esta carpeta:
`BookCollection` (línea 9) no expone su lista interna —
`createIterator()` (línea 14) devuelve un `BookIterator` (línea 17), que
es el único que sabe cómo recorrerla, con `hasNext()` (línea 23) y
`next()` (línea 25).

El `main` (línea 28) nunca toca `books` directamente: pide un iterador
con `collection.createIterator()` (línea 35) y lo recorre con `while
(iterator.hasNext())` (líneas 36-38). Si `BookCollection` cambiara su
almacenamiento interno de `ArrayList` a cualquier otra estructura, este
bucle no se entera — sigue llamando `hasNext()`/`next()` igual.
