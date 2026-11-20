# Composite en JavaScript

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite, el
código que recorre el árbol tiene que preguntar todo el tiempo qué tipo de
cosa tiene en la mano:

```javascript
function getTotalSize(item) {
  if (item instanceof FileItem) return item.size;
  if (item instanceof Folder) {
    let total = 0;
    for (const child of item.children)
      total += getTotalSize(child); // recursión manual, con el mismo instanceof repetido
    return total;
  }
  throw new Error("tipo desconocido");
}
```

Cada función que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repite el mismo `instanceof FileItem / instanceof Folder`, y
agregar un tercer tipo de nodo (un symlink, por ejemplo) obliga a tocar
todas esas funciones.

## Así queda con Composite aplicado

Mirá [`composite.js`](composite.js) de esta carpeta: `FileItem` (línea 4) y
`Folder` (línea 19) tienen la misma forma — ambas exponen `getSize()` y
`print()`, sin que ninguna interfaz formal las obligue (JavaScript no la
necesita). `Folder.getSize()` (línea 31) no distingue qué son sus hijos —
simplemente llama `child.getSize()` en cada uno con `reduce` y suma; si un
hijo es otro `Folder`, la recursión ocurre sola porque ese `Folder` también
sabe responder `getSize()`.

El bloque de demo (línea 44) arma el árbol con `add()` (línea 25) y al
final solo llama `root.print()` (línea 52) una vez — nunca necesita
preguntar `instanceof FileItem` o `instanceof Folder` en ningún lugar del
código cliente.
