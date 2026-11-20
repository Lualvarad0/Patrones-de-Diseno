# Memento en COBOL

## El problema, en código

Tu editor de texto necesita un "deshacer". Sin Memento, la forma obvia de
guardar un checkpoint es que `history` lea el contenido directamente:

```cobol
*> si "the-content" de text-editor fuera accesible directamente:
method-id. push.
    linkage section.
    01 editor-in object reference.
    procedure division using editor-in.
        invoke editor-in "get-content" returning snapshot-entry(...)
        *> history necesitaría conocer el campo exacto y su formato,
        *> y lo mismo al revés en "pop" para reescribirlo
    end method push.
*> el día que text-editor agregue más estado (cursor, selección),
*> history tiene que enterarse y copiar cada campo nuevo a mano
```

`history` necesitaría acceso de lectura y escritura al estado interno
del editor, así que `the-content` no podría ser realmente privado — y
cualquier campo nuevo que el editor agregue tendría que replicarse
también en `history`.

## Así queda con Memento aplicado

Mirá [`memento.cbl`](memento.cbl) de esta carpeta: `editor-memento`
(línea 8) es una clase inmutable y opaca que solo `text-editor` sabe
crear (`save`, línea 66) y leer (`restore`, línea 75, que invoca `memento
"get-content"` porque conoce esa clase). `history` (línea 87) nunca mira
dentro del memento — solo lo guarda y lo devuelve con `push`/`pop`
(líneas 98 y 106), tratándolo como una referencia opaca en
`snapshot-table`.

El párrafo principal (línea 131) escribe texto, guarda checkpoints con
`"save"` seguido de `the-history "push"` (líneas 136-137 y 141-142),
sigue escribiendo, y deshace con `the-history "pop"` seguido de `editor
"restore"` (líneas 149-150). Si `text-editor` agregara un campo nuevo
(cursor, por ejemplo), solo `editor-memento` tendría que crecer —
`history` sigue funcionando sin cambios porque nunca supo qué había
adentro.
