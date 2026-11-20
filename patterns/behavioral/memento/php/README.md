# Memento en PHP

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que el historial lea el contenido directamente:

```php
class History
{
    private array $snapshots = [];

    public function push(TextEditor $editor): void {
        $this->snapshots[] = $editor->content; // lee la propiedad directo
    }
    public function pop(TextEditor $editor): void {
        $editor->content = array_pop($this->snapshots); // ¡y la vuelve a escribir directo!
    }
}
// funciona mientras $content sea pública en TextEditor.
// el día que el editor agregue más estado (cursor, selección, formato),
// History tiene que enterarse y copiar cada campo nuevo a mano
```

`History` necesita acceso de lectura y escritura al estado interno del
editor, así que `$content` no puede ser realmente privada — y cualquier
campo nuevo que el editor agregue tiene que replicarse también en
`History`.

## Así queda con Memento aplicado

Mirá [`Memento.php`](Memento.php) de esta carpeta: `EditorMemento`
(línea 5) es un objeto inmutable y opaco que solo `TextEditor` sabe crear
(`save()`, línea 25) y leer (`restore()`, línea 30, que llama
`$memento->getContent()`). `History` (línea 37) nunca mira dentro del
memento — solo lo guarda y lo devuelve con `push()`/`pop()` (líneas 42 y
47), tratándolo como una caja negra.

El bloque de demo (línea 54) escribe texto, guarda checkpoints con
`$history->push($editor->save())` (líneas 58 y 61), sigue escribiendo, y
deshace con `$editor->restore($history->pop())` (línea 66). Si
`TextEditor` agregara una propiedad nueva (cursor, por ejemplo), solo
`EditorMemento` tendría que crecer — `History` sigue funcionando sin
cambios porque nunca supo qué había adentro.
