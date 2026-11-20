# Template Method en Rust

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato terminaría con su propia función que copia
los mismos pasos de leer y guardar:

```rust
fn process_csv() {
    println!("Reading raw data...");   // copiado
    println!("Parsing data as CSV");    // el único paso distinto
    println!("Saving results...");       // copiado
}

fn process_json() {
    println!("Reading raw data...");   // copiado otra vez
    println!("Parsing data as JSON");
    println!("Saving results...");       // copiado otra vez
}
// si mañana "guardar" necesita loguear algo, hay que acordarse de
// tocar las dos funciones (y la tercera, y la cuarta...) por igual
```

Los pasos de leer y guardar quedarían duplicados en cada función; si
algún día cambian, hay que recordar actualizar cada copia por separado, y
es fácil que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`template_method.rs`](template_method.rs) de esta carpeta: el
trait `DataProcessor` (línea 4) define `process()` (línea 5) con un
cuerpo por defecto una sola vez, fijando el orden `read_data() →
process_data() → save_data()`; `read_data()` (línea 12) y `save_data()`
(línea 18) también tienen una implementación compartida por defecto, y
solo `process_data()` (línea 16) no tiene cuerpo — cada implementador
está obligado a darle uno. `CsvProcessor` (línea 23) y `JsonProcessor`
(línea 30) solo implementan `process_data()` — ninguna de las dos
repite el código de leer ni de guardar.

El `main` (línea 37) llama `.process()` en ambas (líneas 38 y 40) y
obtiene el mismo "Reading..."/"Saving..." en los dos casos, con solo el
paso de parseo cambiando. Si `save_data()` necesitara loguear algo
nuevo, se edita una sola vez en el trait y ambos tipos lo heredan
automáticamente.
