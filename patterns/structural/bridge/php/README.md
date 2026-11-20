# Bridge en PHP

## El problema, en código

Tenés un `RemoteControl` básico y un `AdvancedRemoteControl` (que agrega
`mute()`), y necesitás que ambos funcionen con `Tv` y con `Radio`. Si heredás
directo de cada dispositivo en vez de delegar, terminás con una subclase por
cada combinación:

```php
class TvRemoteControl { /* conoce Tv por dentro */ }
class RadioRemoteControl { /* conoce Radio por dentro */ }
class AdvancedTvRemoteControl extends TvRemoteControl { public function mute() { ... } }
class AdvancedRadioRemoteControl extends RadioRemoteControl { public function mute() { ... } }
// agregás un dispositivo (Speaker) y ya necesitás
// SpeakerRemoteControl + AdvancedSpeakerRemoteControl
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada control
nuevo duplica toda la jerarquía de dispositivos: dos dimensiones que crecen
multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`Bridge.php`](Bridge.php) de esta carpeta: `RemoteControl` (línea 33)
no hereda de ningún dispositivo — recibe un `Device` promovido a propiedad
en el constructor (línea 35) y delega en él (`togglePower`, línea 37).
`AdvancedRemoteControl` (línea 45) extiende `RemoteControl`, no `Tv` ni
`Radio`: agrega `mute()` (línea 47) usando ese mismo `$this->device`
heredado (declarado `protected` en la clase base para que la subclase
llegue a él).

El bloque de demo (línea 54) arma las combinaciones que necesita
simplemente pasando el dispositivo al constructor: `new
RemoteControl(new Tv())` o `new AdvancedRemoteControl(new Radio())`
(líneas 54 y 57). Para sumar un `Speaker` solo hace falta implementar la
interfaz `Device` — cero clases nuevas de control.
