# Iterator en Rust

## El problema, en código

Tu `BookCollection` guarda los títulos en un `Vec<String>` público, y todo
el código que necesita recorrerlos accede directo a ese vector:

```rust
struct BookCollection {
    pub books: Vec<String>, // expuesto directamente
}

// en cada lugar que recorre la colección:
for i in 0..collection.books.len() {
    println!("{}", collection.books[i]);
}
// si mañana cambiás Vec<String> por otra estructura,
// hay que reescribir cada uno de estos bucles en todo el código
```

El código cliente queda atado a que la colección sea exactamente un
`Vec` indexable; cambiar la estructura interna de `BookCollection` rompe
cada lugar que la recorre con índices manuales.

## Así queda con Iterator aplicado

Mirá [`iterator.rs`](iterator.rs) de esta carpeta: `BookCollection`
(línea 6) no expone `books` como público — `create_iterator()` (línea
19) devuelve un `BookIterator<'a>` (línea 24), que implementa el trait
estándar `Iterator` de Rust (línea 29) con un único método `next()`
(línea 32) que devuelve `Option<&String>`.

El `main` (línea 43) nunca indexa `books` a mano: usa directamente `for
book in collection.create_iterator()` (línea 49), la sintaxis de
iteración nativa del lenguaje, porque `BookIterator` ya cumple el
contrato de `Iterator`. Si `BookCollection` cambiara su almacenamiento
interno de `Vec<String>` a cualquier otra estructura, este `for` no se
entera — sigue funcionando igual mientras `next()` siga devolviendo los
elementos uno por uno.
