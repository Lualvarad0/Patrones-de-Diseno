# Bridge en Java

## El problema, en código

Tenés un `RemoteControl` básico y un `AdvancedRemoteControl` (que agrega
`mute()`), y necesitás que ambos funcionen con `Tv` y con `Radio`. Si heredás
directo de cada dispositivo en vez de delegar, terminás con una subclase por
cada combinación:

```java
class TvRemoteControl { /* conoce Tv por dentro */ }
class RadioRemoteControl { /* conoce Radio por dentro */ }
class AdvancedTvRemoteControl extends TvRemoteControl { void mute() { ... } }
class AdvancedRadioRemoteControl extends RadioRemoteControl { void mute() { ... } }
// agregás un dispositivo (Speaker) y ya necesitás
// SpeakerRemoteControl + AdvancedSpeakerRemoteControl
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada control
nuevo duplica toda la jerarquía de dispositivos: dos dimensiones que crecen
multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`BridgeDemo.java`](BridgeDemo.java) de esta carpeta: `RemoteControl`
(línea 29) no hereda de ningún dispositivo — guarda una referencia a
`Device` (línea 30) y delega en ella (`togglePower`, línea 33).
`AdvancedRemoteControl` (línea 40) extiende `RemoteControl`, no `Tv` ni
`Radio`: agrega `mute()` (línea 43) usando el mismo `device` heredado.

El `main` (línea 49) arma las combinaciones que necesita simplemente
pasando el dispositivo al constructor: `new RemoteControl(new Tv())` o
`new AdvancedRemoteControl(new Radio())` (líneas 50 y 53). Para sumar un
`Speaker` solo hace falta una clase que implemente `Device` — cero
clases nuevas de control.
