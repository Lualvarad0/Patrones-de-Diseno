# Composite en C++

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite, el
código que recorre el árbol tiene que preguntar todo el tiempo qué tipo de
cosa tiene en la mano:

```cpp
int getTotalSize(void* item, bool isFolder) {
    if (!isFolder) return static_cast<FileItem*>(item)->getSize();
    auto* folder = static_cast<Folder*>(item);
    int total = 0;
    for (auto& child : folder->children)
        total += getTotalSize(child.ptr, child.isFolder); // recursión manual, con el mismo chequeo repetido
    return total;
}
```

Cada función que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repite el mismo chequeo "¿es archivo o carpeta?", y agregar un
tercer tipo de nodo (un symlink, por ejemplo) obliga a tocar todas esas
funciones.

## Así queda con Composite aplicado

Mirá [`composite.cpp`](composite.cpp) de esta carpeta: `FileItem` (línea
16) y `Folder` (línea 30) heredan de la misma clase abstracta
`FileSystemItem` (línea 9), con un único método virtual `getSize()` cada
uno. `Folder::getSize()` (línea 40) no distingue qué son sus hijos —
simplemente llama `child->getSize()` en cada `std::unique_ptr<
FileSystemItem>` del vector y suma; si un hijo es otro `Folder`, la
recursión ocurre sola porque el despacho es virtual.

El `main` (línea 56) arma el árbol con `add()` (línea 34) y al final solo
llama `root.print("")` (línea 65) una vez — nunca necesita un
`dynamic_cast` ni ningún chequeo de tipo en el código cliente.
