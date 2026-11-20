# Iterator en C#

## El problema, en código

Tu `BookCollection` guarda los títulos en una `List<string>` pública, y
todo el código que necesita recorrerlos accede directo a esa lista:

```csharp
public class BookCollection
{
    public List<string> Books = new(); // expuesta directamente
}

// en cada lugar que recorre la colección:
for (int i = 0; i < collection.Books.Count; i++)
{
    Console.WriteLine(collection.Books[i]);
}
// si mañana cambiás List<string> por un árbol o una base de datos,
// hay que reescribir cada uno de estos bucles en todo el código
```

El código cliente queda atado a que la colección sea exactamente una
`List` indexable; cambiar la estructura interna de `BookCollection` rompe
cada lugar que la recorre con un `for` indexado.

## Así queda con Iterator aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `BookCollection` (línea
6) no expone su lista interna — `CreateIterator()` (línea 12) devuelve un
`BookIterator` (línea 15), que es el único que sabe cómo recorrerla, con
`HasNext()` (línea 22) y `Next()` (línea 24).

El `Main` (línea 27) nunca toca `_books` directamente: pide un iterador
con `collection.CreateIterator()` (línea 36) y lo recorre con `while
(iterator.HasNext())` (líneas 37-40). Si `BookCollection` cambiara su
almacenamiento interno de `List<string>` a cualquier otra estructura,
este bucle no se entera — sigue llamando `HasNext()`/`Next()` igual.
