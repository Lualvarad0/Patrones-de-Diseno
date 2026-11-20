# Observer en JavaScript

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `WeatherStation`
conoce a cada display por su tipo concreto y los llama a mano:

```javascript
class WeatherStation {
  setTemperature(temperature) {
    this.phone.update(temperature);
    this.tv.update(temperature);
    // agregar un SmartWatchDisplay significa venir a este método
    // y agregar una línea más — y lo mismo si querés poder quitar uno
  }
}
```

`WeatherStation` termina acoplada a cada tipo concreto de display que
exista; agregar o quitar un display implica editar `setTemperature()`
cada vez.

## Así queda con Observer aplicado

Mirá [`observer.js`](observer.js) de esta carpeta: `PhoneDisplay` (línea
4) y `TvDisplay` (línea 10) solo necesitan tener la misma forma (un
método `update()`), sin ninguna interfaz formal. `WeatherStation` (línea
17) no conoce ningún tipo concreto — guarda un arreglo de observadores
(`#observers`, línea 18) y `setTemperature()` (línea 28) simplemente
recorre ese arreglo llamando `update()` en cada uno, sin saber si es un
teléfono, una TV o cualquier otra cosa.

El bloque de demo (línea 36) se suscribe con `subscribe()` (líneas 40-41)
y se desuscribe con `unsubscribe()` (línea 45); `setTemperature(23.5)`
(línea 43) notifica a los dos, pero después de desuscribir la TV,
`setTemperature(24.0)` (línea 46) solo notifica al teléfono. Agregar un
tercer display es una clase nueva con su propio `update()` y un
`subscribe()` más — cero cambios en `WeatherStation`.
