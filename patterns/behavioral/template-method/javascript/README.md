# Template Method en JavaScript

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato termina con su propia clase que copia los
mismos pasos de leer y guardar:

```javascript
class CsvProcessor {
  process() {
    console.log("Reading raw data...");  // copiado
    console.log("Parsing data as CSV");   // el único paso distinto
    console.log("Saving results...");      // copiado
  }
}

class JsonProcessor {
  process() {
    console.log("Reading raw data...");  // copiado otra vez
    console.log("Parsing data as JSON");
    console.log("Saving results...");      // copiado otra vez
  }
}
// si mañana "guardar" necesita loguear algo, hay que acordarse de
// tocar las dos clases (y la tercera, y la cuarta...) por igual
```

Los pasos de leer y guardar están duplicados en cada clase; si algún día
cambian, hay que recordar actualizar cada copia por separado, y es fácil
que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`template-method.js`](template-method.js) de esta carpeta:
`DataProcessor` (línea 4) define `process()` (línea 5) una sola vez,
fijando el orden `readData() → processData() → saveData()`;
`readData()` (línea 12) y `saveData()` (línea 20) tienen una
implementación compartida por defecto, y `processData()` (línea 16)
directamente lanza un error si no se sobreescribe. `CsvProcessor`
(línea 25) y `JsonProcessor` (línea 31) solo sobreescriben
`processData()` — ninguna de las dos repite el código de leer ni de
guardar.

El bloque de demo (línea 38) llama `.process()` en ambas (líneas 38 y
40) y obtiene el mismo "Reading..."/"Saving..." en los dos casos, con
solo el paso de parseo cambiando. Si `saveData()` necesitara loguear
algo nuevo, se edita una sola vez en `DataProcessor` y las dos
subclases lo heredan automáticamente.
