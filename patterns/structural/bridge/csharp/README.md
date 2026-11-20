# Bridge en C#

## El problema, en código

Tenés un `RemoteControl` básico y un `AdvancedRemoteControl` (que agrega
`Mute()`), y necesitás que ambos funcionen con `Tv` y con `Radio`. Si heredás
directo de cada dispositivo en vez de delegar, terminás con una subclase por
cada combinación:

```csharp
public class TvRemoteControl { /* conoce Tv por dentro */ }
public class RadioRemoteControl { /* conoce Radio por dentro */ }
public class AdvancedTvRemoteControl : TvRemoteControl { public void Mute() { ... } }
public class AdvancedRadioRemoteControl : RadioRemoteControl { public void Mute() { ... } }
// agregás un dispositivo (Speaker) y ya necesitás
// SpeakerRemoteControl + AdvancedSpeakerRemoteControl
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada control
nuevo duplica toda la jerarquía de dispositivos: dos dimensiones que crecen
multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `RemoteControl` (línea 30)
no hereda de ningún dispositivo — guarda una referencia a `IDevice` (línea
32) y delega en ella (`TogglePower`, línea 35). `AdvancedRemoteControl`
(línea 43) extiende `RemoteControl`, no `Tv` ni `Radio`: agrega `Mute()`
(línea 47) usando el mismo `Device` heredado.

El `Main` (línea 55) arma las combinaciones que necesita simplemente
pasando el dispositivo al constructor: `new RemoteControl(new Tv())` o
`new AdvancedRemoteControl(new Radio())` (líneas 57 y 60). Para sumar un
`Speaker` solo hace falta una clase que implemente `IDevice` — cero
clases nuevas de control.
