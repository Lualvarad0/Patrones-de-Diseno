# Observer en Java

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `WeatherStation`
conoce a cada display por su tipo concreto y los llama a mano:

```java
class WeatherStation {
    private PhoneDisplay phone;
    private TvDisplay tv;

    void setTemperature(double temperature) {
        phone.update(temperature);
        tv.update(temperature);
        // agregar un SmartWatchDisplay significa venir a este método
        // y agregar una línea más — y lo mismo si querés poder quitar uno
    }
}
```

`WeatherStation` termina acoplada a cada tipo concreto de display que
exista; agregar o quitar un display implica editar `setTemperature()`
cada vez.

## Así queda con Observer aplicado

Mirá [`ObserverDemo.java`](ObserverDemo.java) de esta carpeta:
`PhoneDisplay` (línea 11) y `TvDisplay` (línea 15) implementan la misma
interfaz `Observer` (línea 7), con un único método `update()`.
`WeatherStation` (línea 20) no conoce ningún tipo concreto — guarda una
lista de `Observer` (`observers`, línea 21) y `setTemperature()` (línea
26) simplemente recorre esa lista llamando `update()` en cada uno, sin
saber si es un teléfono, una TV o cualquier otra cosa.

El `main` (línea 34) se suscribe con `subscribe()` (líneas 39-40) y se
desuscribe con `unsubscribe()` (línea 44); `setTemperature(23.5)` (línea
42) notifica a los dos, pero después de desuscribir la TV,
`setTemperature(24.0)` (línea 45) solo notifica al teléfono. Agregar un
tercer display es una clase nueva que implemente `Observer` y un
`subscribe()` más — cero cambios en `WeatherStation`.
