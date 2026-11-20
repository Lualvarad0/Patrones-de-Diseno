# Template Method en C#

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato termina con su propia clase que copia los
mismos pasos de leer y guardar:

```csharp
public class CsvProcessor
{
    public void Process()
    {
        Console.WriteLine("Reading raw data...");   // copiado
        Console.WriteLine("Parsing data as CSV");    // el único paso distinto
        Console.WriteLine("Saving results...");       // copiado
    }
}

public class JsonProcessor
{
    public void Process()
    {
        Console.WriteLine("Reading raw data...");   // copiado otra vez
        Console.WriteLine("Parsing data as JSON");
        Console.WriteLine("Saving results...");       // copiado otra vez
    }
}
// si mañana "guardar" necesita loguear algo, hay que acordarse de
// tocar las dos clases (y la tercera, y la cuarta...) por igual
```

Los pasos de leer y guardar están duplicados en cada clase; si algún día
cambian, hay que recordar actualizar cada copia por separado, y es fácil
que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `DataProcessor` (línea
4) define `Process()` (línea 6) una sola vez, fijando el orden
`ReadData() → ProcessData() → SaveData()`; `ReadData()` (línea 13) y
`SaveData()` (línea 17) tienen una implementación compartida por
defecto, y solo `ProcessData()` (línea 15) es `abstract`. `CsvProcessor`
(línea 20) y `JsonProcessor` (línea 25) solo sobreescriben
`ProcessData()` — ninguna de las dos repite el código de leer ni de
guardar.

El `Main` (línea 30) llama `processor.Process()` en ambas (líneas 35 y
40) y obtiene el mismo "Reading..."/"Saving..." en los dos casos, con
solo el paso de parseo cambiando. Si `SaveData()` necesitara loguear algo
nuevo, se edita una sola vez en `DataProcessor` y las dos subclases lo
heredan automáticamente.
