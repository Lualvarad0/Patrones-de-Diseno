# Composite en PHP

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite, el
código que recorre el árbol tiene que preguntar todo el tiempo qué tipo de
cosa tiene en la mano:

```php
function getTotalSize($item) {
    if ($item instanceof FileItem) return $item->getSize();
    if ($item instanceof Folder) {
        $total = 0;
        foreach ($item->getChildren() as $child)
            $total += getTotalSize($child); // recursión manual, con el mismo instanceof repetido
        return $total;
    }
    throw new Exception("tipo desconocido");
}
```

Cada función que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repite el mismo `instanceof FileItem / instanceof Folder`, y
agregar un tercer tipo de nodo (un symlink, por ejemplo) obliga a tocar
todas esas funciones.

## Así queda con Composite aplicado

Mirá [`Composite.php`](Composite.php) de esta carpeta: `FileItem` (línea
11) y `Folder` (línea 23) implementan la misma interfaz `FileSystemItem`
(línea 5), con un único método `getSize()` cada uno. `Folder::getSize()`
(línea 37) no distingue qué son sus hijos — simplemente llama
`$child->getSize()` en cada uno con `array_map` y suma; si un hijo es otro
`Folder`, la recursión ocurre sola porque ese `Folder` también sabe
responder `getSize()`.

El bloque de demo (línea 52) arma el árbol con `add()` (línea 30) y al
final solo llama `$root->print()` (línea 60) una vez — nunca necesita
`instanceof FileItem` o `instanceof Folder` en ningún lugar del código
cliente.
