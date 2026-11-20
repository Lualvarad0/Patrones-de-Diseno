# Command en Java

## El problema, en código

Tu control remoto necesita un botón "deshacer". Sin Command, el control
llama directo a los métodos del dispositivo:

```java
class RemoteControl {
    void pressOnButton(Light light) { light.turnOn(); }
    void pressOffButton(Light light) { light.turnOff(); }
    // no hay dónde guardar "qué se hizo" para poder deshacerlo:
    // el control olvida la acción apenas termina de ejecutarla
}
```

El control nunca guarda un registro de qué se ejecutó, así que no hay
forma de deshacer la última acción sin que el control empiece a conocer
los detalles de cada dispositivo y de cada acción posible.

## Así queda con Command aplicado

Mirá [`CommandDemo.java`](CommandDemo.java) de esta carpeta:
`TurnOnCommand` (línea 18) y `TurnOffCommand` (línea 25) envuelven cada
acción como un objeto que implementa `Command` (línea 7), con `execute()`
y `undo()` simétricos — uno llama `light.turnOn()` adentro de
`execute()` (línea 21) y `light.turnOff()` adentro de `undo()` (línea
22), y el otro al revés. `RemoteControl` (línea 34) nunca llama a `Light`
directamente: `submit()` (línea 37) ejecuta el comando que le pasen y lo
guarda en `history` (línea 39), sin saber qué dispositivo ni qué acción
hay detrás.

El `main` (línea 48) manda dos comandos con `submit()` (líneas 52-53) y
después llama `remote.undoLast()` (línea 54): el control saca el último
comando de la pila y le pide `undo()` sin necesitar un `if` que distinga
"era un TurnOn o un TurnOff".
