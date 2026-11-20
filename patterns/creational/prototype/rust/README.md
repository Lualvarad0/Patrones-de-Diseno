# Prototype en Rust

## El problema, en código

Necesitás una copia independiente de una `Sheep` en varios lugares del
código (un comando de "Duplicar", un endpoint, un test). Sin Prototype,
cada uno de esos lugares arma la copia a mano, campo por campo:

```rust
// en tres archivos distintos del proyecto...
let copy = Sheep { name: original.name.clone(), color: original.color.clone() };
```

Esto funciona hasta que `Sheep` crece: el negocio pide agregar `age` y
`breed`. Vas, agregás los campos al struct... pero acá sí el compilador te
salva en parte (un struct-literal incompleto no compila), aunque igual
tenés que ir a corregir **cada uno** de esos tres lugares a mano, uno por
uno, repitiendo el mismo trabajo tedioso cada vez que el struct cambia.

## Así queda con Prototype aplicado

Mirá [`prototype.rs`](prototype.rs) de esta carpeta: `Sheep` lleva el
atributo `#[derive(Clone)]` (línea 5) — el compilador de Rust genera
automáticamente un método `.clone()` que copia campo por campo, sin que
vos escribas ni mantengas ese código a mano. Si mañana agregás `age` al
struct, no tenés que tocar nada: el `derive` genera de nuevo el método
`clone()` incluyendo el campo nuevo, y todo el código que ya llamaba a
`.clone()` (línea 20) sigue funcionando y recibe la copia completa.

El comentario de las líneas 1-4 también marca algo importante: este
`derive` hace una copia **superficial** campo por campo — funciona perfecto
acá porque `name`/`color` son `String` con dueño propio. Si `Sheep`
tuviera un campo compartido detrás de un `Rc` o un puntero, clonar ese
campo solo duplicaría la referencia, no los datos — y ahí haría falta
implementar `Clone` a mano para decidir qué copiar de verdad.
