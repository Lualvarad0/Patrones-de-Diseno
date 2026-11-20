# State en COBOL

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `traffic-light` guardaría el color en un campo y cada método
lo miraría con un `if` tras otro:

```cobol
*> si current-color fuera un campo x(10) en vez de un object reference:
method-id. change.
    procedure division.
        if current-color = "Red"
            move "Green" to current-color
        else
            if current-color = "Green"
                move "Yellow" to current-color
            else
                move "Red" to current-color
            end-if
        end-if
        display "Light is now " function trim(current-color)
    end method change.
*> cualquier otro método que se comporte distinto según el color
*> repite el mismo if anidado
```

Cada comportamiento que depende del color terminaría con su propio `if`
anidado calcado, y agregar un estado nuevo (una luz intermitente, por
ejemplo) significaría tocar todos esos `if` a la vez.

## Así queda con State aplicado

Mirá [`state.cbl`](state.cbl) de esta carpeta: `red-state` (línea 7),
`green-state` (línea 34) y `yellow-state` (línea 61) son clases
distintas, y cada una sabe cuál es el siguiente estado en su propio
método `next` (líneas 16-24, 43-51 y 70-78) — no hay ningún `if` de color
en ningún lado. `traffic-light` (línea 88) solo guarda una referencia al
estado actual (`current-state`, línea 97) y delega: `change` (línea 113)
invoca `current-state "next" using self`, que es el propio estado el que
decide a cuál cambiar invocando `light "set-state"`.

El párrafo principal (línea 137) solo invoca `light "change"` tres veces
(líneas 141, 143 y 145): Red → Green → Yellow → Red, sin que
`traffic-light` sepa en ningún momento cuál es "el siguiente color".
Agregar un estado nuevo es una clase más con su propio `next` — cero
cambios en `traffic-light`.
