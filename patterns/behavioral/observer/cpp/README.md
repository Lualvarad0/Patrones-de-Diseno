# Observer en C++

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `WeatherStation`
conoce a cada display por su tipo concreto y los llama a mano:

```cpp
class WeatherStation {
public:
    void setTemperature(double temperature) {
        phone.update(temperature);
        tv.update(temperature);
        // agregar un SmartWatchDisplay significa venir a este método
        // y agregar una línea más — y lo mismo si querés poder quitar uno
    }
private:
    PhoneDisplay phone;
    TvDisplay tv;
};
```

`WeatherStation` termina acoplada a cada tipo concreto de display que
exista; agregar o quitar un display implica editar `setTemperature()`
cada vez.

## Así queda con Observer aplicado

Mirá [`observer.cpp`](observer.cpp) de esta carpeta: `PhoneDisplay`
(línea 14) y `TvDisplay` (línea 21) heredan de la misma clase abstracta
`Observer` (línea 8), con un único método virtual `update()`.
`WeatherStation` (línea 30) no conoce ningún tipo concreto — guarda un
`vector<Observer*>` (línea 47) y `setTemperature()` (línea 40)
simplemente recorre ese vector llamando `update()` en cada uno por
despacho virtual.

El `main` (línea 50) se suscribe con `subscribe()` (líneas 55-56) y se
desuscribe con `unsubscribe()` (línea 60); `setTemperature(23.5)` (línea
58) notifica a los dos, pero después de desuscribir la TV,
`setTemperature(24.0)` (línea 61) solo notifica al teléfono. Agregar un
tercer display es una clase nueva que herede de `Observer` y un
`subscribe()` más — cero cambios en `WeatherStation`.
