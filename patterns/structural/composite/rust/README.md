# Composite en Rust

## El problema, en código

Necesitás calcular el tamaño total de una carpeta de proyecto, que contiene
archivos sueltos y subcarpetas con más archivos adentro. Sin Composite,
necesitarías un `enum` que distinga los dos casos y una función que haga
`match` en cada lugar donde recorras el árbol:

```rust
enum Node {
    File { size: u32 },
    Folder { children: Vec<Node> },
}

fn total_size(node: &Node) -> u32 {
    match node {
        Node::File { size } => *size,
        Node::Folder { children } => children.iter().map(total_size).sum(), // el mismo match se repite en cada función que recorre el árbol
    }
}
```

Cada función que recorre el árbol (calcular tamaño, imprimir, buscar un
archivo) repite el mismo `match File / Folder`, y agregar un tercer tipo de
nodo (un symlink, por ejemplo) obliga a tocar todas esas funciones y todos
los `match`.

## Así queda con Composite aplicado

Mirá [`composite.rs`](composite.rs) de esta carpeta: `FileItem` (línea 9) y
`Folder` (línea 24) implementan el mismo trait `FileSystemItem` (línea 4),
con un único método `size()` cada uno (líneas 15 y 42). La implementación
de `Folder::size()` (línea 42) no distingue qué son sus hijos — simplemente
llama `child.size()` en cada `Box<dyn FileSystemItem>` del vector y suma; si
un hijo es otro `Folder`, la recursión ocurre sola porque ese `Folder`
también implementa el trait.

El `main` (línea 55) arma el árbol con `add()` (línea 34) metiendo cada
nodo en un `Box::new(...)` y al final solo llama `root.print("")` (línea
64) una vez — nunca necesita un `match` para distinguir archivo de carpeta
en el código cliente.
