# State en C#

## El problema, en código

Un semáforo cambia de color y se comporta distinto según en cuál está.
Sin State, `TrafficLight` guarda el color como un string/enum y cada
método mira ese valor con un `switch`:

```csharp
public class TrafficLight
{
    private string _color = "Red";

    public void Change()
    {
        switch (_color)
        {
            case "Red": _color = "Green"; break;
            case "Green": _color = "Yellow"; break;
            case "Yellow": _color = "Red"; break;
        }
        Console.WriteLine($"Light is now {_color}");
    }
    // cualquier otro método que se comporte distinto según el color
    // (¿pueden pasar los autos? ¿cuánto dura esta luz?) repite el mismo switch
}
```

Cada comportamiento que depende del color termina con su propio `switch`
calcado, y agregar un estado nuevo (una luz intermitente, por ejemplo)
significa tocar todos esos `switch` a la vez.

## Así queda con State aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `RedState` (línea 10),
`GreenState` (línea 16) y `YellowState` (línea 22) implementan la misma
interfaz `ITrafficLightState` (línea 4), y cada una sabe cuál es el
siguiente estado (`Next()`, línea 13, 19 y 25) — no hay ningún `switch`
en ningún lado. `TrafficLight` (línea 30) solo guarda el estado actual
(`_state`, línea 32) y delega: `Change()` (línea 36) llama
`_state.Next(this)`, que es el propio estado el que decide a cuál cambiar
llamando `light.SetState(...)`.

El `Main` (línea 43) solo llama `light.Change()` tres veces (líneas
48-50): Red → Green → Yellow → Red, sin que `TrafficLight` sepa en ningún
momento cuál es "el siguiente color". Agregar un estado nuevo es una
clase más que implemente `ITrafficLightState` — cero cambios en
`TrafficLight`.
