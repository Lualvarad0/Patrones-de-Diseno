# Command en C#

## El problema, en código

Tu control remoto necesita un botón "deshacer". Sin Command, el control
llama directo a los métodos del dispositivo:

```csharp
public class RemoteControl
{
    public void PressOnButton(Light light) => light.TurnOn();
    public void PressOffButton(Light light) => light.TurnOff();
    // no hay dónde guardar "qué se hizo" para poder deshacerlo:
    // el control olvida la acción apenas termina de ejecutarla
}
```

El control nunca guarda un registro de qué se ejecutó, así que no hay
forma de deshacer la última acción sin que el control empiece a conocer
los detalles de cada dispositivo y de cada acción posible.

## Así queda con Command aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `TurnOnCommand` (línea
18) y `TurnOffCommand` (línea 26) envuelven cada acción como un objeto
que implementa `ICommand` (línea 4), con `Execute()` y `Undo()`
simétricos — uno llama `_light.TurnOn()` adentro de `Execute()` (línea
22) y `_light.TurnOff()` adentro de `Undo()` (línea 23), y el otro al
revés. `RemoteControl` (línea 36) nunca llama a `Light` directamente:
`Submit()` (línea 40) ejecuta el comando que le pasen y lo guarda en
`_history` (línea 43), sin saber qué dispositivo ni qué acción hay
detrás.

El `Main` (línea 54) manda dos comandos con `Submit()` (líneas 59-60) y
después llama `remote.UndoLast()` (línea 61): el control saca el último
comando de la pila y le pide `Undo()` sin necesitar un `if` que distinga
"era un TurnOn o un TurnOff".
