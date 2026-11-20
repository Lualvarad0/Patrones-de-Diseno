# Observer en COBOL

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `weather-station`
conocería a cada display por su nombre de clase exacto y los invocaría
a mano:

```cobol
*> si weather-station conociera cada display por su clase concreta:
method-id. set-temperature.
    linkage section.
    01 temperature pic 9(3)v9.
    procedure division using temperature.
        invoke the-phone "update" using temperature
        invoke the-tv "update" using temperature
        *> agregar un smart-watch-display significa venir a este
        *> método y agregar una invocación más
    end method set-temperature.
```

`weather-station` terminaría acoplada a cada clase concreta de display
que exista; agregar o quitar un display implicaría editar
`set-temperature` cada vez.

## Así queda con Observer aplicado

Mirá [`observer.cbl`](observer.cbl) de esta carpeta: `phone-display`
(línea 7) y `tv-display` (línea 24) son clases distintas, pero ambas
responden al mismo mensaje `"update"` (líneas 12 y 29) — no hace falta
que `weather-station` conozca sus nombres. `weather-station` (línea 41)
guarda sus referencias en `observer-table` (línea 47) y `set-temperature`
(línea 73) simplemente recorre esa tabla invocando `"update"` en cada
una (línea 79), sin saber si es un teléfono, una TV o cualquier otra
cosa.

El párrafo principal (línea 103) se suscribe con `"subscribe"` (líneas
108-109) y se desuscribe con `"unsubscribe"` (línea 114, que solo marca
el slot como `null` en vez de achicar la tabla, para no mover los
índices de los demás); `"set-temperature" using 23.5` (línea 111)
notifica a los dos, pero después de desuscribir la TV, `"set-temperature"
using 24.0` (línea 115) solo notifica al teléfono. Agregar un tercer
display es una clase nueva con su propio `"update"` y una invocación de
`"subscribe"` más — cero cambios en `weather-station`.
