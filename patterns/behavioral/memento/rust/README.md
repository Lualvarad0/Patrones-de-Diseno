# Memento en Rust

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que el historial lea el contenido directamente:

```rust
struct History {
    snapshots: Vec<String>,
}

impl History {
    fn push(&mut self, editor: &TextEditor) {
        self.snapshots.push(editor.content.clone()); // lee el campo directo
    }
    fn pop(&mut self, editor: &mut TextEditor) {
        editor.content = self.snapshots.pop().unwrap(); // ¡y lo vuelve a escribir directo!
    }
}
// funciona mientras "content" sea accesible desde afuera del módulo.
// el día que el editor agregue más estado (cursor, selección, formato),
// History tiene que enterarse y copiar cada campo nuevo a mano
```

`History` necesita acceso de lectura y escritura al estado interno del
editor, así que `content` no puede ser realmente privado del módulo — y
cualquier campo nuevo que el editor agregue tiene que replicarse también
en `History`.

## Así queda con Memento aplicado

Mirá [`memento.rs`](memento.rs) de esta carpeta: `EditorMemento` (línea
4) es un struct inmutable y opaco que solo `TextEditor` sabe crear
(`save()`, línea 21) y leer (`restore()`, línea 25, que mueve
`memento.content` porque viven en el mismo módulo). `History` (línea 31)
nunca mira dentro del memento — solo lo guarda y lo devuelve con
`push()`/`pop()` (líneas 40 y 44), tratándolo como una caja negra (de
hecho `pop()` devuelve `Option<EditorMemento>` sin inspeccionarlo).

El `main` (línea 49) escribe texto, guarda checkpoints con
`history.push(editor.save())` (líneas 54 y 57), sigue escribiendo, y
deshace con `editor.restore(memento)` dentro del `if let` (líneas 62-64).
Si `TextEditor` agregara un campo nuevo (cursor, por ejemplo), solo
`EditorMemento` tendría que crecer — `History` sigue funcionando sin
cambios porque nunca supo qué había adentro.
