# Facade en JavaScript

## El problema, en código

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Sin Facade, cada lugar que necesita prender la película repite la
misma secuencia exacta de seis llamadas, en el orden correcto, a tres
clases distintas:

```javascript
const amplifier = new Amplifier();
const projector = new Projector();
const dvdPlayer = new DvdPlayer();

amplifier.on();
amplifier.setVolume(7);
projector.on();
projector.setInput("DVD");
dvdPlayer.on();
dvdPlayer.play("The Matrix");
// y repetís este bloque entero en cada pantalla que quiera "ver una película"
```

Si mañana cambia el orden correcto de encendido, o agregás una cuarta
clase (luces, por ejemplo), tenés que encontrar y corregir cada copia de
esta secuencia en toda la app.

## Así queda con Facade aplicado

Mirá [`facade.js`](facade.js) de esta carpeta: `Amplifier`, `DvdPlayer` y
`Projector` (líneas 4, 16 y 28) siguen existiendo igual que antes — nadie
las eliminó, siguen disponibles para quien necesite control fino.
`HomeTheaterFacade` (línea 41) las crea una sola vez, guardadas en campos
privados (líneas 42-44), y expone `watchMovie()` (línea 46), que adentro
hace exactamente esa secuencia de seis llamadas en el orden correcto.

El bloque de demo (línea 63) ahora solo necesita `homeTheater.watchMovie(
"The Matrix")` (línea 64) — una llamada en vez de seis — y `endMovie()`
(línea 55) apaga todo en el orden inverso correcto sin que el código
cliente tenga que acordarse de cuál.
