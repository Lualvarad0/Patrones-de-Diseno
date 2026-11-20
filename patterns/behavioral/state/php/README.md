# State en PHP

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `TrafficLight` guarda el color como un string y cada método
mira ese valor con un `switch`:

```php
class TrafficLight
{
    private string $color = "Red";

    public function change(): void
    {
        switch ($this->color) {
            case "Red": $this->color = "Green"; break;
            case "Green": $this->color = "Yellow"; break;
            case "Yellow": $this->color = "Red"; break;
        }
        echo "Light is now {$this->color}\n";
    }
    // cualquier otro método que se comporte distinto según el color
    // (¿pueden pasar los autos? ¿cuánto dura esta luz?) repite el mismo switch
}
```

Cada comportamiento que depende del color termina con su propio `switch`
calcado, y agregar un estado nuevo (una luz intermitente, por ejemplo)
significa tocar todos esos `switch` a la vez.

## Así queda con State aplicado

Mirá [`State.php`](State.php) de esta carpeta: `RedState` (línea 11),
`GreenState` (línea 17) y `YellowState` (línea 23) implementan la misma
interfaz `TrafficLightState` (línea 5), y cada una sabe cuál es el
siguiente estado (`next()`, líneas 13, 19 y 25) — no hay ningún `switch`
en ningún lado. `TrafficLight` (línea 31) solo guarda el estado actual
(`$state`, línea 33) y delega: `change()` (línea 45) llama
`$this->state->next($this)`, que es el propio estado el que decide a
cuál cambiar llamando `$light->setState(...)`.

El bloque de demo (línea 52) solo llama `$light->change()` tres veces
(líneas 54-56): Red → Green → Yellow → Red, sin que `TrafficLight` sepa
en ningún momento cuál es "el siguiente color". Agregar un estado nuevo
es una clase más que implemente `TrafficLightState` — cero cambios en
`TrafficLight`.
