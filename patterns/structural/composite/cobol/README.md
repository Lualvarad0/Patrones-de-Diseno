# Composite en COBOL

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite, el
párrafo que recorre el árbol necesitaría una bandera que diga qué tipo de
cosa tiene cada entrada y un `if` para decidir cómo tratarla:

```cobol
*> cada entrada del árbol llevaría un campo extra: tipo-entrada = "FILE" o "FOLDER"
perform varying i from 1 by 1 until i > entry-count
    if tipo-entrada(i) = "FILE"
        add file-size(i) to running-size
    else
        *> "FOLDER": habría que volver a invocar este mismo párrafo
        *> recursivamente, repitiendo el if en cada nivel
        perform calcular-tamanio-carpeta
    end-if
end-perform
```

Cada párrafo que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repetiría el mismo `if tipo-entrada = "FILE" / "FOLDER"`, y
agregar un tercer tipo de nodo obligaría a tocar todos esos párrafos.

## Así queda con Composite aplicado

Mirá [`composite.cbl`](composite.cbl) de esta carpeta: `file-item` (línea
8) y `folder` (línea 44) son clases distintas, pero ambas responden al
mismo mensaje `"get-size"` (líneas 26 y 74) y `"print"` (líneas 31 y 86) —
no hay ninguna bandera de tipo. `folder::get-size` (línea 74) no distingue
qué son sus hijos — simplemente hace `invoke child-entry(i) "get-size"
returning child-size` sobre cada referencia guardada en `child-table`
(líneas 79-82) y suma; si un hijo es otra `folder`, la recursión ocurre
sola porque ese objeto también entiende `"get-size"`.

El párrafo principal (línea 125) arma el árbol con `"add"` (líneas 131,
138, 141 y 144) y al final solo invoca `root "print" using blank-indent`
(línea 146) una vez — nunca necesita preguntar de qué clase es cada
`object reference` guardada en `child-table`.
