# State en Java

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `TrafficLight` guarda el color como un String/enum y cada
método mira ese valor con un `switch`:

```java
class TrafficLight {
    private String color = "Red";

    void change() {
        switch (color) {
            case "Red": color = "Green"; break;
            case "Green": color = "Yellow"; break;
            case "Yellow": color = "Red"; break;
        }
        System.out.println("Light is now " + color);
    }
    // cualquier otro método que se comporte distinto según el color
    // (¿pueden pasar los autos? ¿cuánto dura esta luz?) repite el mismo switch
}
```

Cada comportamiento que depende del color termina con su propio `switch`
calcado, y agregar un estado nuevo (una luz intermitente, por ejemplo)
significa tocar todos esos `switch` a la vez.

## Así queda con State aplicado

Mirá [`StateDemo.java`](StateDemo.java) de esta carpeta: `RedState`
(línea 9), `GreenState` (línea 14) y `YellowState` (línea 19) implementan
la misma interfaz `TrafficLightState` (línea 4), y cada una sabe cuál es
el siguiente estado (`next()`, línea 11, 16 y 21) — no hay ningún
`switch` en ningún lado. `TrafficLight` (línea 26) solo guarda el estado
actual (`state`, línea 27) y delega: `change()` (línea 31) llama
`state.next(this)`, que es el propio estado el que decide a cuál cambiar
llamando `light.setState(...)`.

El `main` (línea 37) solo llama `light.change()` tres veces (líneas
40-42): Red → Green → Yellow → Red, sin que `TrafficLight` sepa en ningún
momento cuál es "el siguiente color". Agregar un estado nuevo es una
clase más que implemente `TrafficLightState` — cero cambios en
`TrafficLight`.
