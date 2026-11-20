# Template Method en Java

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato termina con su propia clase que copia los
mismos pasos de leer y guardar:

```java
class CsvProcessor {
    void process() {
        System.out.println("Reading raw data...");   // copiado
        System.out.println("Parsing data as CSV");     // el único paso distinto
        System.out.println("Saving results...");        // copiado
    }
}

class JsonProcessor {
    void process() {
        System.out.println("Reading raw data...");   // copiado otra vez
        System.out.println("Parsing data as JSON");
        System.out.println("Saving results...");        // copiado otra vez
    }
}
// si mañana "guardar" necesita loguear algo, hay que acordarse de
// tocar las dos clases (y la tercera, y la cuarta...) por igual
```

Los pasos de leer y guardar están duplicados en cada clase; si algún día
cambian, hay que recordar actualizar cada copia por separado, y es fácil
que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`TemplateMethodDemo.java`](TemplateMethodDemo.java) de esta
carpeta: `DataProcessor` (línea 4) define `process()` (línea 5) una sola
vez como `final` (no se puede sobreescribir), fijando el orden
`readData() → processData() → saveData()`; `readData()` (línea 11) y
`saveData()` (línea 15) tienen una implementación compartida por
defecto, y solo `processData()` (línea 13) es `abstract`.
`CsvProcessor` (línea 18) y `JsonProcessor` (línea 22) solo
sobreescriben `processData()` — ninguna de las dos repite el código de
leer ni de guardar.

El `main` (línea 26) llama `processor.process()` en ambas (líneas 29 y
34) y obtiene el mismo "Reading..."/"Saving..." en los dos casos, con
solo el paso de parseo cambiando. Si `saveData()` necesitara loguear
algo nuevo, se edita una sola vez en `DataProcessor` y las dos
subclases lo heredan automáticamente.
