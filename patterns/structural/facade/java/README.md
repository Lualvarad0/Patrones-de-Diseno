# Facade en Java

## El problema, en código

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Sin Facade, cada lugar que necesita prender la película repite la
misma secuencia exacta de seis llamadas, en el orden correcto, a tres
clases distintas:

```java
Amplifier amplifier = new Amplifier();
Projector projector = new Projector();
DvdPlayer dvdPlayer = new DvdPlayer();

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

Mirá [`FacadeDemo.java`](FacadeDemo.java) de esta carpeta: `Amplifier`,
`DvdPlayer` y `Projector` (líneas 4, 10 y 16) siguen existiendo igual que
antes — nadie las eliminó, siguen disponibles para quien necesite control
fino. `HomeTheaterFacade` (línea 23) las crea una sola vez (líneas 24-26)
y expone `watchMovie()` (línea 28), que adentro hace exactamente esa
secuencia de seis llamadas en el orden correcto.

El `main` (línea 45) ahora solo necesita `homeTheater.watchMovie("The
Matrix")` (línea 47) — una llamada en vez de seis — y `endMovie()` (línea
37) apaga todo en el orden inverso correcto sin que el código cliente
tenga que acordarse de cuál.
