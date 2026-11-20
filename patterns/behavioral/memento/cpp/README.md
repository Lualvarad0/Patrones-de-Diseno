# Memento en C++

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que el historial lea el contenido directamente:

```cpp
class History {
public:
    void push(const TextEditor& editor) {
        snapshots.push(editor.getContent()); // lee el campo directo
    }
    void pop(TextEditor& editor) {
        editor.setContent(snapshots.top()); // ¡y lo vuelve a escribir directo!
        snapshots.pop();
    }
private:
    std::stack<std::string> snapshots;
};
// funciona mientras el editor solo tenga un std::string "content" expuesto.
// el día que el editor agregue más estado (cursor, selección, formato),
// History tiene que enterarse y copiar cada campo nuevo a mano
```

`History` necesita acceso de lectura y escritura al estado interno del
editor, así que `content` no puede ser realmente privado — y cualquier
campo nuevo que el editor agregue tiene que replicarse también en
`History`.

## Así queda con Memento aplicado

Mirá [`memento.cpp`](memento.cpp) de esta carpeta: `EditorMemento`
(línea 8) es una clase inmutable y opaca que solo `TextEditor` sabe crear
(`save()`, línea 22) y leer (`restore()`, línea 24, que llama
`memento.getContent()`). `History` (línea 31) nunca mira dentro del
memento — solo lo guarda y lo devuelve con `push()`/`pop()` (líneas 33 y
35), tratándolo como una caja negra.

El `main` (línea 45) escribe texto, guarda checkpoints con
`history.push(editor.save())` (líneas 50 y 53), sigue escribiendo, y
deshace con `editor.restore(history.pop())` (línea 58). Si `TextEditor`
agregara un campo nuevo (cursor, por ejemplo), solo `EditorMemento`
tendría que crecer — `History` sigue funcionando sin cambios porque nunca
supo qué había adentro.
