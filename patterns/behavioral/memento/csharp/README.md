# Memento en C#

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que el historial lea el contenido directamente:

```csharp
public class History
{
    private readonly Stack<string> _snapshots = new();

    public void Push(TextEditor editor) => _snapshots.Push(editor.Content); // lee el campo directo
    public void Pop(TextEditor editor) => editor.Content = _snapshots.Pop(); // ¡y lo vuelve a escribir directo!
}
// funciona mientras el editor solo tenga un string "Content" público.
// el día que el editor agregue más estado (cursor, selección, formato),
// History tiene que enterarse y copiar cada campo nuevo a mano
```

`History` necesita acceso de lectura y escritura al estado interno del
editor, así que `Content` no puede ser realmente privado — y cualquier
campo nuevo que el editor agregue tiene que replicarse también en
`History`.

## Así queda con Memento aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `EditorMemento` (línea
4) es un objeto inmutable y opaco que solo `TextEditor` sabe crear
(`Save()`, línea 16) y leer (`Restore()`, línea 18, que accede a
`memento.Content` porque es el mismo tipo). `History` (línea 22) nunca
mira dentro del memento — solo lo guarda y lo devuelve con `Push()`/
`Pop()` (líneas 26 y 28), tratándolo como una caja negra.

El `Main` (línea 31) escribe texto, guarda checkpoints con
`history.Push(editor.Save())` (líneas 39 y 42), sigue escribiendo, y
deshace con `editor.Restore(history.Pop())` (línea 47). Si `TextEditor`
agregara un campo nuevo (cursor, por ejemplo), solo `EditorMemento`
tendría que crecer — `History` sigue funcionando sin cambios porque nunca
supo qué había adentro.
