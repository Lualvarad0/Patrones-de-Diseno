# Memento en Java

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que el historial lea el contenido directamente:

```java
class History {
    private final Deque<String> snapshots = new ArrayDeque<>();

    void push(TextEditor editor) { snapshots.push(editor.getContent()); } // lee el campo directo
    void pop(TextEditor editor) { editor.setContent(snapshots.pop()); }  // ¡y lo vuelve a escribir directo!
}
// funciona mientras el editor solo tenga un String "content".
// el día que el editor agregue más estado (cursor, selección, formato),
// History tiene que enterarse y copiar cada campo nuevo a mano
```

`History` necesita acceso de lectura y escritura al estado interno del
editor, así que `content` no puede ser realmente privado de verdad — y
cualquier campo nuevo que el editor agregue tiene que replicarse también
en `History`.

## Así queda con Memento aplicado

Mirá [`MementoDemo.java`](MementoDemo.java) de esta carpeta:
`EditorMemento` (línea 7) es un objeto inmutable y opaco que solo
`TextEditor` sabe crear (`save()`, línea 20) y leer (`restore()`, línea
22, que accede a `memento.getContent()` porque es el mismo paquete).
`History` (línea 26) nunca mira dentro del memento — solo lo guarda y lo
devuelve con `push()`/`pop()` (líneas 29 y 31), tratándolo como una caja
negra.

El `main` (línea 35) escribe texto, guarda checkpoints con
`history.push(editor.save())` (líneas 40 y 43), sigue escribiendo, y
deshace con `editor.restore(history.pop())` (línea 48). Si `TextEditor`
agregara un campo nuevo (cursor, por ejemplo), solo `EditorMemento`
tendría que crecer — `History` sigue funcionando sin cambios porque nunca
supo qué había adentro.
