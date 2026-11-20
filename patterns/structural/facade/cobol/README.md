# Facade en COBOL

## El problema, en código

Querés agregar un botón "Ver película" en tu programa de control de un
home theater. Sin Facade, cada párrafo que necesita prender la película
repite la misma secuencia exacta de seis invocaciones, en el orden
correcto, a tres clases distintas:

```cobol
invoke the-amplifier "on"
invoke the-amplifier "set-volume" using 7
invoke the-projector "on"
invoke the-projector "set-input" using "DVD"
invoke the-dvd "on"
invoke the-dvd "play" using "The Matrix"
*> y repetís este bloque entero en cada párrafo que quiera "ver una película"
```

Si mañana cambia el orden correcto de encendido, o agregás una cuarta
clase (luces, por ejemplo), tenés que encontrar y corregir cada copia de
esta secuencia en todo el programa.

## Así queda con Facade aplicado

Mirá [`facade.cbl`](facade.cbl) de esta carpeta: `amplifier`, `dvd-player`
y `projector` (líneas 8, 30 y 52) siguen existiendo igual que antes —
nadie las eliminó, siguen disponibles para quien necesite control fino.
`home-theater-facade` (línea 74) las crea una sola vez en `init` (líneas
91-96) y expone `watch-movie` (línea 98), que adentro hace exactamente
esa secuencia de seis invocaciones en el orden correcto.

El párrafo principal (línea 132) ahora solo necesita `invoke home-theater
"watch-movie" using "The Matrix"` (línea 135) — una invocación en vez de
seis — y `"end-movie"` (línea 137, implementado en línea 110) apaga todo
en el orden inverso correcto sin que el código cliente tenga que
acordarse de cuál.
