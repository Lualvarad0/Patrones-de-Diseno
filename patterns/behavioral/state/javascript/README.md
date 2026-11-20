# State en JavaScript

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `TrafficLight` guarda el color como un string y cada método
mira ese valor con un `switch`:

```javascript
class TrafficLight {
  color = "Red";

  change() {
    switch (this.color) {
      case "Red": this.color = "Green"; break;
      case "Green": this.color = "Yellow"; break;
      case "Yellow": this.color = "Red"; break;
    }
    console.log(`Light is now ${this.color}`);
  }
  // cualquier otro método que se comporte distinto según el color
  // (¿pueden pasar los autos? ¿cuánto dura esta luz?) repite el mismo switch
}
```

Cada comportamiento que depende del color termina con su propio `switch`
calcado, y agregar un estado nuevo (una luz intermitente, por ejemplo)
significa tocar todos esos `switch` a la vez.

## Así queda con State aplicado

Mirá [`state.js`](state.js) de esta carpeta: `RedState` (línea 4),
`GreenState` (línea 11) y `YellowState` (línea 18) tienen todas un
método `next()`, y cada una sabe cuál es el siguiente estado (líneas 6,
13 y 20) — no hay ningún `switch` en ningún lado. `TrafficLight` (línea
27) solo guarda el estado actual (`state`, línea 28) y delega:
`change()` (línea 34) llama `this.state.next(this)`, que es el propio
estado el que decide a cuál cambiar llamando `light.setState(...)`.

El bloque de demo (línea 41) solo llama `light.change()` tres veces
(líneas 42-44): Red → Green → Yellow → Red, sin que `TrafficLight` sepa
en ningún momento cuál es "el siguiente color". Agregar un estado nuevo
es una clase más con su propio `next()` — cero cambios en
`TrafficLight`.
