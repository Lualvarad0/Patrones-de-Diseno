# Bridge en Rust

## El problema, en código

Tenés un `RemoteControl` básico y un `AdvancedRemoteControl` (que agrega
`mute()`), y necesitás que ambos funcionen con `Tv` y con `Radio`. Si cada
control conociera directamente el tipo de dispositivo en vez de delegar en
un trait, terminarías con un struct por cada combinación:

```rust
struct TvRemoteControl { tv: Tv }          // conoce Tv por dentro
struct RadioRemoteControl { radio: Radio } // conoce Radio por dentro
struct AdvancedTvRemoteControl { remote: TvRemoteControl }
struct AdvancedRadioRemoteControl { remote: RadioRemoteControl }
// agregás un dispositivo (Speaker) y ya necesitás
// SpeakerRemoteControl + AdvancedSpeakerRemoteControl
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada control
nuevo duplica toda la jerarquía de dispositivos: dos dimensiones que crecen
multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`bridge.rs`](bridge.rs) de esta carpeta: `RemoteControl` (línea 29) no
conoce `Tv` ni `Radio` — guarda un `Box<dyn Device>` (línea 30) y delega en
él (`toggle_power`, línea 34). `AdvancedRemoteControl` (línea 43), en vez de
heredar (Rust no tiene herencia de structs), **envuelve** un
`RemoteControl` (línea 44) y agrega `mute()` (línea 52) reusando ese mismo
`remote.device` por dentro.

El `main` (línea 59) arma las combinaciones que necesita simplemente
metiendo el dispositivo en una `Box`: `RemoteControl { device:
Box::new(Tv { .. }) }` o `AdvancedRemoteControl { remote: RemoteControl {
device: Box::new(Radio { .. }) } }` (líneas 60 y 63). Para sumar un
`Speaker` solo hace falta implementar el trait `Device` — cero structs
nuevos de control.
