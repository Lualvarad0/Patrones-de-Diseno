# Iterator en COBOL

## El problema, en código

Tu `book-collection` guarda los títulos en una tabla interna, y todo el
código que necesita recorrerlos accedería directo a esa tabla si
estuviera expuesta:

```cobol
*> si book-table fuera accesible directamente desde afuera:
perform varying i from 1 by 1 until i > book-count
    display function trim(book-entry(i))
end-perform
*> cada párrafo que recorre la colección repite este mismo "perform varying",
*> y conoce el nombre exacto de la tabla y su índice
```

El código cliente quedaría atado a que la colección sea exactamente esa
`book-table` con ese índice; cambiar cómo `book-collection` guarda los
títulos por dentro obligaría a tocar cada párrafo que la recorre así.

## Así queda con Iterator aplicado

Mirá [`iterator.cbl`](iterator.cbl) de esta carpeta: `book-collection`
(línea 8) no expone `book-table` — `create-iterator` (línea 43) devuelve
un `book-iterator` (línea 57), que es el único que sabe cómo recorrerla,
con `has-next` (línea 73) y `next` (línea 85). `book-iterator` ni
siquiera toca `book-table` directamente: le pide el total a la colección
con `"get-count"` (línea 77) y cada título con `"get-book"` (línea 88).

El párrafo principal (línea 109) nunca referencia `book-table`: pide un
iterador con `"create-iterator"` (línea 115) y lo recorre con `perform
until has-next-flag = 0` (líneas 118-122), invocando `"has-next"` y
`"next"`. Si `book-collection` cambiara su almacenamiento interno de una
tabla fija a cualquier otra estructura, este párrafo no se entera — sigue
invocando `"has-next"`/`"next"` igual.
