# Memento en JavaScript

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que el historial lea el contenido directamente:

```javascript
class History {
  #snapshots = [];

  push(editor) {
    this.#snapshots.push(editor.content); // lee el campo directo
  }
  pop(editor) {
    editor.content = this.#snapshots.pop(); // ¡y lo vuelve a escribir directo!
  }
}
// funciona mientras el editor solo tenga un campo "content" accesible.
// el día que el editor agregue más estado (cursor, selección, formato),
// History tiene que enterarse y copiar cada campo nuevo a mano
```

`History` necesita acceso de lectura y escritura al estado interno del
editor, así que `content` no puede ser realmente privado — y cualquier
campo nuevo que el editor agregue tiene que replicarse también en
`History`.

## Así queda con Memento aplicado

Mirá [`memento.js`](memento.js) de esta carpeta: `EditorMemento` (línea
4) es un objeto inmutable y opaco que solo `TextEditor` sabe crear
(`save()`, línea 26) y leer (`restore()`, línea 30, que llama
`memento.getContent()`). `History` (línea 36) nunca mira dentro del
memento — solo lo guarda y lo devuelve con `push()`/`pop()` (líneas 39 y
43), tratándolo como una caja negra.

El bloque de demo (línea 49) escribe texto, guarda checkpoints con
`history.push(editor.save())` (líneas 53 y 56), sigue escribiendo, y
deshace con `editor.restore(history.pop())` (línea 61). Si `TextEditor`
agregara un campo nuevo (cursor, por ejemplo), solo `EditorMemento`
tendría que crecer — `History` sigue funcionando sin cambios porque nunca
supo qué había adentro.
