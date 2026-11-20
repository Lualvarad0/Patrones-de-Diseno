# Command en Rust

## El problema, en código

Tu control remoto necesita un botón "deshacer". Sin Command, el control
llama directo a los métodos del dispositivo:

```rust
struct RemoteControl;
impl RemoteControl {
    fn press_on_button(&self, light: &Light) { light.turn_on(); }
    fn press_off_button(&self, light: &Light) { light.turn_off(); }
    // no hay dónde guardar "qué se hizo" para poder deshacerlo:
    // el control olvida la acción apenas termina de ejecutarla
}
```

El control nunca guarda un registro de qué se ejecutó, así que no hay
forma de deshacer la última acción sin que el control empiece a conocer
los detalles de cada dispositivo y de cada acción posible.

## Así queda con Command aplicado

Mirá [`command.rs`](command.rs) de esta carpeta: `TurnOnCommand` (línea
19) y `TurnOffCommand` (línea 25) envuelven cada acción como un tipo que
implementa el trait `Command` (línea 14), con `execute()` y `undo()`
simétricos — uno llama `self.light.turn_on()` adentro de `execute()`
(línea 21) y `self.light.turn_off()` adentro de `undo()` (línea 22), y el
otro al revés; ambos comparten el mismo `Light` a través de un `Rc`
(línea 19) para no duplicarlo. `RemoteControl` (línea 33) nunca llama a
`Light` directamente: `submit()` (línea 42) ejecuta el `Box<dyn Command>`
que le pasen y lo guarda en `history` (línea 44), sin saber qué
dispositivo ni qué acción hay detrás.

El `main` (línea 54) manda dos comandos con `submit()` (líneas 58-59) y
después llama `remote.undo_last()` (línea 60): el control saca el último
comando del vector y le pide `undo()` sin necesitar un `match` que
distinga "era un TurnOn o un TurnOff".
