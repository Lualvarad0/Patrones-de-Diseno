# Template Method en PHP

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato termina con su propia clase que copia los
mismos pasos de leer y guardar:

```php
class CsvProcessor
{
    public function process(): void
    {
        echo "Reading raw data...\n";   // copiado
        echo "Parsing data as CSV\n";    // el único paso distinto
        echo "Saving results...\n";       // copiado
    }
}

class JsonProcessor
{
    public function process(): void
    {
        echo "Reading raw data...\n";   // copiado otra vez
        echo "Parsing data as JSON\n";
        echo "Saving results...\n";       // copiado otra vez
    }
}
// si mañana "guardar" necesita loguear algo, hay que acordarse de
// tocar las dos clases (y la tercera, y la cuarta...) por igual
```

Los pasos de leer y guardar están duplicados en cada clase; si algún día
cambian, hay que recordar actualizar cada copia por separado, y es fácil
que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`TemplateMethod.php`](TemplateMethod.php) de esta carpeta:
`DataProcessor` (línea 5) define `process()` (línea 7) una sola vez
como `final` (no se puede sobreescribir), fijando el orden
`readData() → processData() → saveData()`; `readData()` (línea 14) y
`saveData()` (línea 21) tienen una implementación compartida por
defecto, y solo `processData()` (línea 19) es `abstract`.
`CsvProcessor` (línea 27) y `JsonProcessor` (línea 32) solo
sobreescriben `processData()` — ninguna de las dos repite el código de
leer ni de guardar.

El bloque de demo (línea 38) llama `->process()` en ambas (líneas 38 y
40) y obtiene el mismo "Reading..."/"Saving..." en los dos casos, con
solo el paso de parseo cambiando. Si `saveData()` necesitara loguear
algo nuevo, se edita una sola vez en `DataProcessor` y las dos
subclases lo heredan automáticamente.
