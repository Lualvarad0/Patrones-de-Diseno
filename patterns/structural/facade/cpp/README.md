# Facade en C++

## El problema, en código

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Sin Facade, cada lugar que necesita prender la película repite la
misma secuencia exacta de seis llamadas, en el orden correcto, a tres
clases distintas:

```cpp
Amplifier amplifier;
Projector projector;
DvdPlayer dvdPlayer;

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
esta secuencia en todo el proyecto.

## Así queda con Facade aplicado

Mirá [`facade.cpp`](facade.cpp) de esta carpeta: `Amplifier`, `DvdPlayer`
y `Projector` (líneas 7, 14 y 21) siguen existiendo igual que antes —
nadie las eliminó, siguen disponibles para quien necesite control fino.
`HomeTheaterFacade` (línea 29) las guarda como miembros privados (líneas
47-49) y expone `watchMovie()` (línea 31), que adentro hace exactamente
esa secuencia de seis llamadas en el orden correcto.

El `main` (línea 52) ahora solo necesita `homeTheater.watchMovie("The
Matrix")` (línea 54) — una llamada en vez de seis — y `endMovie()` (línea
40) apaga todo en el orden inverso correcto sin que el código cliente
tenga que acordarse de cuál.
