# Facade en PHP

## El problema, en código

Querés agregar un botón "Ver película" en tu app de control de un home
theater. Sin Facade, cada lugar que necesita prender la película repite la
misma secuencia exacta de seis llamadas, en el orden correcto, a tres
clases distintas:

```php
$amplifier = new Amplifier();
$projector = new Projector();
$dvdPlayer = new DvdPlayer();

$amplifier->on();
$amplifier->setVolume(7);
$projector->on();
$projector->setInput("DVD");
$dvdPlayer->on();
$dvdPlayer->play("The Matrix");
// y repetís este bloque entero en cada pantalla que quiera "ver una película"
```

Si mañana cambia el orden correcto de encendido, o agregás una cuarta
clase (luces, por ejemplo), tenés que encontrar y corregir cada copia de
esta secuencia en toda la app.

## Así queda con Facade aplicado

Mirá [`Facade.php`](Facade.php) de esta carpeta: `Amplifier`, `DvdPlayer`
y `Projector` (líneas 5, 12 y 19) siguen existiendo igual que antes —
nadie las eliminó, siguen disponibles para quien necesite control fino.
`HomeTheaterFacade` (línea 27) las crea una sola vez en su constructor
(líneas 33-38) y expone `watchMovie()` (línea 40), que adentro hace
exactamente esa secuencia de seis llamadas en el orden correcto.

El bloque de demo (línea 59) ahora solo necesita `$homeTheater->
watchMovie("The Matrix")` (línea 60) — una llamada en vez de seis — y
`endMovie()` (línea 50) apaga todo en el orden inverso correcto sin que
el código cliente tenga que acordarse de cuál.
