# State en C++

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `TrafficLight` guarda el color en un string/enum y cada
método mira ese valor con un `switch`:

```cpp
class TrafficLight {
public:
    void change() {
        switch (color) {
            case Color::Red: color = Color::Green; break;
            case Color::Green: color = Color::Yellow; break;
            case Color::Yellow: color = Color::Red; break;
        }
        std::cout << "Light is now " << name() << std::endl;
    }
    // cualquier otro método que se comporte distinto según el color
    // (¿pueden pasar los autos? ¿cuánto dura esta luz?) repite el mismo switch
private:
    Color color = Color::Red;
};
```

Cada comportamiento que depende del color termina con su propio `switch`
calcado, y agregar un estado nuevo (una luz intermitente, por ejemplo)
significa tocar todos esos `switch` a la vez.

## Así queda con State aplicado

Mirá [`state.cpp`](state.cpp) de esta carpeta: `RedState` (línea 32),
`GreenState` (línea 38) y `YellowState` (línea 44) heredan de la misma
clase abstracta `TrafficLightState` (línea 10), y cada una sabe cuál es
el siguiente estado (`next()`, implementado en líneas 50-52) — no hay
ningún `switch` en ningún lado. `TrafficLight` (línea 17) solo guarda el
estado actual (`state`, línea 29) y delega: `change()` (línea 23) llama
`state->next(*this)`, que es el propio estado el que decide a cuál
cambiar llamando `light.setState(...)`.

El `main` (línea 56) solo llama `light.change()` tres veces (líneas
58-60): Red → Green → Yellow → Red, sin que `TrafficLight` sepa en ningún
momento cuál es "el siguiente color". Agregar un estado nuevo es una
clase más que herede de `TrafficLightState` — cero cambios en
`TrafficLight`.
