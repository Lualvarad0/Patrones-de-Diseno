# Observer en C#

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `WeatherStation`
conoce a cada display por su tipo concreto y los llama a mano:

```csharp
public class WeatherStation
{
    private PhoneDisplay _phone;
    private TvDisplay _tv;

    public void SetTemperature(double temperature)
    {
        _phone.Update(temperature);
        _tv.Update(temperature);
        // agregar un SmartWatchDisplay significa venir a este método
        // y agregar una línea más — y lo mismo si querés poder quitar uno
    }
}
```

`WeatherStation` termina acoplada a cada tipo concreto de display que
exista; agregar o quitar un display implica editar `SetTemperature()`
cada vez.

## Así queda con Observer aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `PhoneDisplay` (línea
9) y `TvDisplay` (línea 14) implementan la misma interfaz `IObserver`
(línea 4), con un único método `Update()`. `WeatherStation` (línea 20)
no conoce ningún tipo concreto — guarda una lista de `IObserver`
(`_observers`, línea 22) y `SetTemperature()` (línea 27) simplemente
recorre esa lista llamando `Update()` en cada uno, sin saber si es un
teléfono, una TV o cualquier otra cosa.

El `Main` (línea 34) se suscribe con `Subscribe()` (líneas 42-43) y se
desuscribe con `Unsubscribe()` (línea 47); `SetTemperature(23.5)` (línea
45) notifica a los dos, pero después de desuscribir la TV,
`SetTemperature(24.0)` (línea 48) solo notifica al teléfono. Agregar un
tercer display es una clase nueva que implemente `IObserver` y un
`Subscribe()` más — cero cambios en `WeatherStation`.
