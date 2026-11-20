# Command en PHP

## El problema, en código

Tu control remoto necesita un botón "deshacer". Sin Command, el control
llama directo a los métodos del dispositivo:

```php
class RemoteControl
{
    public function pressOnButton(Light $light): void { $light->turnOn(); }
    public function pressOffButton(Light $light): void { $light->turnOff(); }
    // no hay dónde guardar "qué se hizo" para poder deshacerlo:
    // el control olvida la acción apenas termina de ejecutarla
}
```

El control nunca guarda un registro de qué se ejecutó, así que no hay
forma de deshacer la última acción sin que el control empiece a conocer
los detalles de cada dispositivo y de cada acción posible.

## Así queda con Command aplicado

Mirá [`Command.php`](Command.php) de esta carpeta: `TurnOnCommand` (línea
19) y `TurnOffCommand` (línea 26) envuelven cada acción como un objeto
que implementa `Command` (línea 13), con `execute()` y `undo()`
simétricos — uno llama `$this->light->turnOn()` adentro de `execute()`
(línea 22) y `$this->light->turnOff()` adentro de `undo()` (línea 23), y
el otro al revés. `RemoteControl` (línea 35) nunca llama a `Light`
directamente: `submit()` (línea 40) ejecuta el comando que le pasen y lo
guarda en `$history` (línea 43), sin saber qué dispositivo ni qué acción
hay detrás.

El bloque de demo (línea 56) manda dos comandos con `submit()` (líneas
59-60) y después llama `$remote->undoLast()` (línea 61): el control saca
el último comando del arreglo y le pide `undo()` sin necesitar un `if`
que distinga "era un TurnOn o un TurnOff".
