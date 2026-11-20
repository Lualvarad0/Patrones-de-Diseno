# Iterator en C++

## El problema, en código

Tu `BookCollection` guarda los títulos en un `std::vector<std::string>`
público, y todo el código que necesita recorrerlos accede directo a ese
vector:

```cpp
class BookCollection {
public:
    std::vector<std::string> books; // expuesto directamente
};

// en cada lugar que recorre la colección:
for (size_t i = 0; i < collection.books.size(); i++) {
    std::cout << collection.books[i] << std::endl;
}
// si mañana cambiás vector por una lista enlazada,
// hay que reescribir cada uno de estos bucles en todo el código
```

El código cliente queda atado a que la colección sea exactamente un
`vector` indexable; cambiar la estructura interna de `BookCollection`
rompe cada lugar que la recorre con índices manuales.

## Así queda con Iterator aplicado

Mirá [`iterator.cpp`](iterator.cpp) de esta carpeta: `BookCollection`
(línea 23) mantiene `books` privado — `createIterator()` (línea 27)
devuelve un `BookIterator` (línea 10), que es el único que sabe cómo
recorrerla, con `hasNext()` (línea 14) y `next()` (línea 16).

El `main` (línea 33) nunca toca `books` directamente: pide un iterador
con `collection.createIterator()` (línea 39) y lo recorre con `while
(iterator.hasNext())` (líneas 40-42). Si `BookCollection` cambiara su
almacenamiento interno de `vector` a cualquier otra estructura, este
bucle no se entera — sigue llamando `hasNext()`/`next()` igual.
