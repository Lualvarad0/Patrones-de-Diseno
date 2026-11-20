# Observer en PHP

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `WeatherStation`
conoce a cada display por su tipo concreto y los llama a mano:

```php
class WeatherStation
{
    private PhoneDisplay $phone;
    private TvDisplay $tv;

    public function setTemperature(float $temperature): void
    {
        $this->phone->update($temperature);
        $this->tv->update($temperature);
        // agregar un SmartWatchDisplay significa venir a este método
        // y agregar una línea más — y lo mismo si querés poder quitar uno
    }
}
```

`WeatherStation` termina acoplada a cada tipo concreto de display que
exista; agregar o quitar un display implica editar `setTemperature()`
cada vez.

## Así queda con Observer aplicado

Mirá [`Observer.php`](Observer.php) de esta carpeta: `PhoneDisplay`
(línea 10) y `TvDisplay` (línea 18) implementan la misma interfaz
`Observer` (línea 5), con un único método `update()`. `WeatherStation`
(línea 27) no conoce ningún tipo concreto — guarda un arreglo de
`Observer` (`$observers`, línea 30) y `setTemperature()` (línea 42)
simplemente recorre ese arreglo llamando `update()` en cada uno, sin
saber si es un teléfono, una TV o cualquier otra cosa.

El bloque de demo (línea 51) se suscribe con `subscribe()` (líneas 55-56)
y se desuscribe con `unsubscribe()` (línea 60); `setTemperature(23.5)`
(línea 58) notifica a los dos, pero después de desuscribir la TV,
`setTemperature(24.0)` (línea 61) solo notifica al teléfono. Agregar un
tercer display es una clase nueva que implemente `Observer` y un
`subscribe()` más — cero cambios en `WeatherStation`.
