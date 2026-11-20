# Command en C++

## El problema, en código

Tu control remoto necesita un botón "deshacer". Sin Command, el control
llama directo a los métodos del dispositivo:

```cpp
class RemoteControl {
public:
    void pressOnButton(Light& light) { light.turnOn(); }
    void pressOffButton(Light& light) { light.turnOff(); }
    // no hay dónde guardar "qué se hizo" para poder deshacerlo:
    // el control olvida la acción apenas termina de ejecutarla
};
```

El control nunca guarda un registro de qué se ejecutó, así que no hay
forma de deshacer la última acción sin que el control empiece a conocer
los detalles de cada dispositivo y de cada acción posible.

## Así queda con Command aplicado

Mirá [`command.cpp`](command.cpp) de esta carpeta: `TurnOnCommand` (línea
22) y `TurnOffCommand` (línea 31) envuelven cada acción como una clase
que hereda de `Command` (línea 15), con `execute()` y `undo()`
simétricos — uno llama `light.turnOn()` adentro de `execute()` (línea
25) y `light.turnOff()` adentro de `undo()` (línea 26), y el otro al
revés. `RemoteControl` (línea 42) nunca llama a `Light` directamente:
`submit()` (línea 44) ejecuta el `unique_ptr<Command>` que le pasen y lo
guarda en `history` (línea 46), sin saber qué dispositivo ni qué acción
hay detrás.

El `main` (línea 60) manda dos comandos con `submit()` (líneas 64-65) y
después llama `remote.undoLast()` (línea 66): el control saca el último
comando del vector y le pide `undo()` sin necesitar un chequeo de tipo
que distinga "era un TurnOn o un TurnOff".
