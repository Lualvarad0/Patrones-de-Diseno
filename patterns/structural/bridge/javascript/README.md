# Bridge en JavaScript

## El problema, en código

Tenés un `RemoteControl` básico y un `AdvancedRemoteControl` (que agrega
`mute()`), y necesitás que ambos funcionen con `Tv` y con `Radio`. Si heredás
directo de cada dispositivo en vez de delegar, terminás con una subclase por
cada combinación:

```javascript
class TvRemoteControl { /* conoce Tv por dentro */ }
class RadioRemoteControl { /* conoce Radio por dentro */ }
class AdvancedTvRemoteControl extends TvRemoteControl { mute() { ... } }
class AdvancedRadioRemoteControl extends RadioRemoteControl { mute() { ... } }
// agregás un dispositivo (Speaker) y ya necesitás
// SpeakerRemoteControl + AdvancedSpeakerRemoteControl
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada control
nuevo duplica toda la jerarquía de dispositivos: dos dimensiones que crecen
multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`bridge.js`](bridge.js) de esta carpeta: `RemoteControl` (línea 28) no
hereda de ningún dispositivo — guarda una referencia a `device` en su
constructor (línea 30) y delega en ella (`togglePower`, línea 33).
`AdvancedRemoteControl` (línea 41) extiende `RemoteControl`, no `Tv` ni
`Radio`: agrega `mute()` (línea 42) usando el mismo `this.device` heredado.

El bloque de demo (línea 48) arma las combinaciones que necesita simplemente
pasando el dispositivo al constructor: `new RemoteControl(new Tv())` o
`new AdvancedRemoteControl(new Radio())` (líneas 48 y 51). Para sumar un
`Speaker` solo hace falta un objeto con la misma forma (`on`, `name`,
`turnOn()`, `turnOff()`) — cero clases nuevas de control.
