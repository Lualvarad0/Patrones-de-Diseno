# Composite en Java

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite, el
código que recorre el árbol tiene que preguntar todo el tiempo qué tipo de
cosa tiene en la mano:

```java
int getTotalSize(Object item) {
    if (item instanceof FileItem file) return file.getSize();
    if (item instanceof Folder folder) {
        int total = 0;
        for (Object child : folder.getChildren())
            total += getTotalSize(child); // recursión manual, con el mismo instanceof repetido
        return total;
    }
    throw new RuntimeException("tipo desconocido");
}
```

Cada función que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repite el mismo `instanceof FileItem / instanceof Folder`, y
agregar un tercer tipo de nodo (un symlink, por ejemplo) obliga a tocar
todas esas funciones.

## Así queda con Composite aplicado

Mirá [`CompositeDemo.java`](CompositeDemo.java) de esta carpeta: `FileItem`
(línea 12) y `Folder` (línea 25) implementan la misma interfaz
`FileSystemItem` (línea 7), con un único método `getSize()` cada uno.
`Folder.getSize()` (línea 35) no distingue qué son sus hijos — simplemente
llama `child.getSize()` en cada uno y suma; si un hijo es otro `Folder`, la
recursión ocurre sola porque ese `Folder` también sabe responder
`getSize()`.

El `main` (línea 48) arma el árbol con `add()` (línea 31) y al final solo
llama `root.print("")` (línea 57) una vez — nunca necesita preguntar
`instanceof FileItem` o `instanceof Folder` en ningún lugar del código
cliente.
