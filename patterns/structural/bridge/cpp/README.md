# Bridge en C++

## El problema, en código

Tenés un `RemoteControl` básico y un `AdvancedRemoteControl` (que agrega
`mute()`), y necesitás que ambos funcionen con `Tv` y con `Radio`. Si heredás
directo de cada dispositivo en vez de delegar, terminás con una subclase por
cada combinación:

```cpp
class TvRemoteControl { /* conoce Tv por dentro */ };
class RadioRemoteControl { /* conoce Radio por dentro */ };
class AdvancedTvRemoteControl : public TvRemoteControl { void mute() { ... } };
class AdvancedRadioRemoteControl : public RadioRemoteControl { void mute() { ... } };
// agregás un dispositivo (Speaker) y ya necesitás
// SpeakerRemoteControl + AdvancedSpeakerRemoteControl
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada control
nuevo duplica toda la jerarquía de dispositivos: dos dimensiones que crecen
multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`bridge.cpp`](bridge.cpp) de esta carpeta: `RemoteControl` (línea 39)
no hereda de ningún dispositivo — guarda un `std::unique_ptr<Device>`
(línea 49) y delega en él (`togglePower`, línea 43).
`AdvancedRemoteControl` (línea 53) hereda de `RemoteControl`, no de `Tv` ni
`Radio`: agrega `mute()` (línea 57) usando el mismo `device` heredado
(protegido, no privado, para que la subclase pueda llegar a él).

El `main` (línea 62) arma las combinaciones que necesita simplemente
pasando el dispositivo al constructor: `RemoteControl(std::make_unique<Tv>())`
o `AdvancedRemoteControl(std::make_unique<Radio>())` (líneas 63 y 66). Para
sumar un `Speaker` solo hace falta heredar de `Device` — cero clases
nuevas de control.
