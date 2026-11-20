# Facade en C#

## El problema, en código

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Sin Facade, cada lugar que necesita prender la película repite la
misma secuencia exacta de seis llamadas, en el orden correcto, a tres
clases distintas:

```csharp
var amplifier = new Amplifier();
var projector = new Projector();
var dvdPlayer = new DvdPlayer();

amplifier.On();
amplifier.SetVolume(7);
projector.On();
projector.SetInput("DVD");
dvdPlayer.On();
dvdPlayer.Play("The Matrix");
// y repetís este bloque entero en cada pantalla que quiera "ver una película"
```

Si mañana cambia el orden correcto de encendido, o agregás una cuarta
clase (luces, por ejemplo), tenés que encontrar y corregir cada copia de
esta secuencia en toda la app.

## Así queda con Facade aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `Amplifier`, `DvdPlayer` y
`Projector` (líneas 4, 11 y 18) siguen existiendo igual que antes — nadie
las eliminó, siguen disponibles para quien necesite control fino.
`HomeTheaterFacade` (línea 26) las crea una sola vez (líneas 28-30) y
expone `WatchMovie()` (línea 32), que adentro hace exactamente esa
secuencia de seis llamadas en el orden correcto.

El `Main` (línea 52) ahora solo necesita `homeTheater.WatchMovie("The
Matrix")` (línea 55) — una llamada en vez de seis — y `EndMovie()` (línea
42) apaga todo en el orden inverso correcto sin que el código cliente
tenga que acordarse de cuál.
