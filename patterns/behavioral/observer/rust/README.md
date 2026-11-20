# Observer en Rust

## El problema, en código

Tu estación meteorológica actualiza un display de celular y uno de TV
cada vez que cambia la temperatura. Sin Observer, `WeatherStation`
conocería a cada display por su tipo concreto y los llamaría a mano:

```rust
struct WeatherStation {
    phone: PhoneDisplay,
    tv: TvDisplay,
}

impl WeatherStation {
    fn set_temperature(&self, temperature: f64) {
        self.phone.update(temperature);
        self.tv.update(temperature);
        // agregar un SmartWatchDisplay significa venir a este método
        // y agregar una línea más — y lo mismo si querés poder quitar uno
    }
}
```

`WeatherStation` terminaría acoplada a cada tipo concreto de display que
exista; agregar o quitar un display implicaría editar `set_temperature()`
cada vez.

## Así queda con Observer aplicado

Mirá [`observer.rs`](observer.rs) de esta carpeta: `PhoneDisplay` (línea
8) y `TvDisplay` (línea 15) implementan el mismo trait `Observer` (línea
4), con un único método `update()`. `WeatherStation` (línea 26) no
conoce ningún tipo concreto — guarda un `Vec<(u32, Box<dyn Observer>)>`
(línea 27), donde el `u32` es un id para poder desuscribir sin comparar
referencias (comentario en línea 24); `set_temperature()` (línea 47)
simplemente recorre esa lista llamando `update()` en cada uno.

El `main` (línea 54) se suscribe con `subscribe()` (líneas 56-57), que
devuelve el id de cada observador, y se desuscribe con `unsubscribe(
tv_id)` (línea 61); `set_temperature(23.5)` (línea 59) notifica a los
dos, pero después de desuscribir la TV, `set_temperature(24.0)` (línea
62) solo notifica al teléfono. Agregar un tercer display es un struct
nuevo que implemente `Observer` y un `subscribe()` más — cero cambios en
`WeatherStation`.
