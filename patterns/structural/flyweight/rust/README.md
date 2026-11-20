# Flyweight en Rust

## El problema, en código

Tu juego dibuja un bosque de un millón de árboles, y solo hay un puñado de
especies distintas (pino, roble...). Sin Flyweight, cada `Tree` guarda su
propia copia del nombre y el sprite:

```rust
struct Tree {
    x: i32,
    y: i32,
    name: String,   // "Pine" repetido 500,000 veces
    sprite: String, // el sprite completo, repetido otras 500,000 veces
}
// un millón de árboles = un millón de copias del nombre y el sprite,
// aunque solo haya 2 o 3 especies distintas de verdad
```

Si el sprite pesa unos cuantos KB, un millón de copias idénticas se come la
memoria por nada — los datos son los mismos, solo cambia la posición de
cada árbol.

## Así queda con Flyweight aplicado

Mirá [`flyweight.rs`](flyweight.rs) de esta carpeta: `TreeType` (línea 8)
guarda el nombre y el sprite — el estado pesado y repetido (intrínseco).
`TreeFactory::get_tree_type()` (línea 30) devuelve siempre el mismo
`Rc<TreeType>` para un mismo nombre: si ya existe, clona el `Rc` (línea
32), que solo suma una referencia, no copia los datos; si no existe, lo
crea una vez (líneas 34-37). `Tree` (línea 43) ya no guarda nombre ni
sprite: solo su posición (`x`, `y`) y un `Rc<TreeType>` compartido (línea
46) — el estado que sí varía por instancia (extrínseco).

El `main` (línea 55) pide dos árboles "Pine" y uno "Oak": el factory crea
`TreeType` solo dos veces (una por especie); el segundo "Pine" (línea 59)
solo incrementa el contador de referencias del `Rc` ya existente, sin
imprimir "Created new TreeType".
