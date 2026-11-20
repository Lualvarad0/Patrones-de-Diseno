# Composite en C#

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite, el
código que recorre el árbol tiene que preguntar todo el tiempo qué tipo de
cosa tiene en la mano:

```csharp
int GetTotalSize(object item)
{
    if (item is FileItem file) return file.Size;
    if (item is Folder folder)
    {
        int total = 0;
        foreach (var child in folder.Children)
            total += GetTotalSize(child); // recursión manual, con el mismo if/is repetido
        return total;
    }
    throw new Exception("tipo desconocido");
}
```

Cada función que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repite el mismo `if (es archivo) / else (es carpeta)`, y agregar
un tercer tipo de nodo (un symlink, por ejemplo) obliga a tocar todas esas
funciones.

## Así queda con Composite aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `FileItem` (línea 10) y
`Folder` (línea 25) implementan la misma interfaz `IFileSystemItem` (línea
4), con un único método `GetSize()` cada uno. `Folder.GetSize()` (línea 36)
no distingue qué son sus hijos — simplemente llama `child.GetSize()` en
cada uno y suma; si un hijo es otro `Folder`, la recursión ocurre sola
porque ese `Folder` también sabe responder `GetSize()`.

El `Main` (línea 48) arma el árbol con `Add()` (línea 32) y al final solo
llama `root.Print()` (línea 58) una vez — nunca necesita preguntar
`is FileItem` o `is Folder` en ningún lugar del código cliente.
