# Chain of Responsibility en Rust

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, una sola función concentra
todas las reglas de escalamiento:

```rust
fn handle_ticket(severity: u8) {
    if severity <= 1 { println!("Level1 resolved severity {severity}"); }
    else if severity <= 2 { println!("Level2 resolved severity {severity}"); }
    else if severity <= 3 { println!("Level3 resolved severity {severity}"); }
    else { println!("No handler could resolve severity {severity}"); }
    // agregar un Level4 significa editar esta función y
    // repetir el mismo patrón en cualquier otro lugar que escale tickets
}
```

Esta función tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier lugar del código que necesite la misma lógica de escalamiento la
termina copiando.

## Así queda con Chain of Responsibility aplicado

Mirá [`chain_of_responsibility.rs`](chain_of_responsibility.rs) de esta
carpeta: el trait `Handler` (línea 7) define `handle()` (línea 12) una
sola vez con un cuerpo por defecto — si `can_handle()` es verdadero,
resuelve; si no, delega en `self.next()` (línea 15). Cada nivel
(`Level1Support`, línea 23; `Level2Support`, línea 30; `Level3Support`,
línea 37) solo implementa `can_handle`, `resolve` y `next`, sin saber
nada de los demás niveles.

El `main` (línea 44) arma la cadena **de atrás para adelante**
(comentario en línea 45): primero crea `level3` (línea 46), después
`level2` envolviendo a `level3` en un `Box` (línea 47), y así hasta
`level1` (línea 48) — porque en Rust cada `Box<dyn Handler>` necesita su
contenido ya construido, a diferencia de mutar un puntero `next` después.
Agregar un `Level4Support` es un struct nuevo y un paso más en esa cadena
— cero cambios en `handle()`.
