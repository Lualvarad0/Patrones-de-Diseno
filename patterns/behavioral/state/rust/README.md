# State en Rust

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `TrafficLight` guardaría el color en un enum y cada método
haría `match` sobre ese valor:

```rust
enum Color { Red, Green, Yellow }

struct TrafficLight { color: Color }

impl TrafficLight {
    fn change(&mut self) {
        self.color = match self.color {
            Color::Red => Color::Green,
            Color::Green => Color::Yellow,
            Color::Yellow => Color::Red,
        };
        // cualquier otro método que se comporte distinto según el color
        // (¿pueden pasar los autos? ¿cuánto dura esta luz?) repite el mismo match
    }
}
```

Cada comportamiento que depende del color termina con su propio `match`
calcado, y agregar un estado nuevo (una luz intermitente, por ejemplo)
significa tocar todos esos `match` a la vez — y revisar que ninguno haya
quedado sin ese brazo nuevo.

## Así queda con State aplicado

Mirá [`state.rs`](state.rs) de esta carpeta: `RedState` (línea 12),
`GreenState` (línea 18) y `YellowState` (línea 24) implementan el mismo
trait `TrafficLightState` (línea 7), y cada una sabe cuál es el
siguiente estado (`next()`, línea 14, 20 y 26) — no hay ningún `match`
en ningún lado (el comentario en línea 4-6 señala a propósito que un
`enum` con `match` también sería válido en Rust, pero este ejemplo usa
objetos para comparar con el mismo patrón en los demás lenguajes).
`TrafficLight` (línea 34) solo guarda el estado actual envuelto en
`Option` (línea 35, necesario porque `next()` consume `self`) y delega:
`change()` (línea 43) saca el estado actual, llama `current.next()`, y
guarda el que devuelve.

El `main` (línea 51) solo llama `light.change()` tres veces (líneas
53-55): Red → Green → Yellow → Red, sin que `TrafficLight` sepa en ningún
momento cuál es "el siguiente color". Agregar un estado nuevo es un
struct más que implemente `TrafficLightState` — cero cambios en
`TrafficLight`.
