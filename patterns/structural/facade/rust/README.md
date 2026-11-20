# Facade en Rust

## El problema, en código

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Sin Facade, cada lugar que necesita prender la película repite la
misma secuencia exacta de seis llamadas, en el orden correcto, a tres
tipos distintos:

```rust
let amplifier = Amplifier;
let projector = Projector;
let dvd_player = DvdPlayer;

amplifier.on();
amplifier.set_volume(7);
projector.on();
projector.set_input("DVD");
dvd_player.on();
dvd_player.play("The Matrix");
// y repetís este bloque entero en cada pantalla que quiera "ver una película"
```

Si mañana cambia el orden correcto de encendido, o agregás un cuarto tipo
(luces, por ejemplo), tenés que encontrar y corregir cada copia de esta
secuencia en todo el proyecto.

## Así queda con Facade aplicado

Mirá [`facade.rs`](facade.rs) de esta carpeta: `Amplifier`, `DvdPlayer` y
`Projector` (líneas 4, 11 y 18) siguen existiendo igual que antes — nadie
los eliminó, siguen disponibles para quien necesite control fino.
`HomeTheaterFacade` (línea 26) los agrupa en sus campos (líneas 27-29) y
expone `watch_movie()` (línea 37), que adentro hace exactamente esa
secuencia de seis llamadas en el orden correcto.

El `main` (línea 53) ahora solo necesita `home_theater.watch_movie("The
Matrix")` (línea 55) — una llamada en vez de seis — y `end_movie()`
(línea 46) apaga todo en el orden inverso correcto sin que el código
cliente tenga que acordarse de cuál.
