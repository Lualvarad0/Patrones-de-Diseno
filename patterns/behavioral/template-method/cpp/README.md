# Template Method en C++

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato termina con su propia clase que copia los
mismos pasos de leer y guardar:

```cpp
class CsvProcessor {
public:
    void process() const {
        std::cout << "Reading raw data..." << std::endl;  // copiado
        std::cout << "Parsing data as CSV" << std::endl;    // el único paso distinto
        std::cout << "Saving results..." << std::endl;       // copiado
    }
};

class JsonProcessor {
public:
    void process() const {
        std::cout << "Reading raw data..." << std::endl;  // copiado otra vez
        std::cout << "Parsing data as JSON" << std::endl;
        std::cout << "Saving results..." << std::endl;       // copiado otra vez
    }
};
// si mañana "guardar" necesita loguear algo, hay que acordarse de
// tocar las dos clases (y la tercera, y la cuarta...) por igual
```

Los pasos de leer y guardar están duplicados en cada clase; si algún día
cambian, hay que recordar actualizar cada copia por separado, y es fácil
que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`template_method.cpp`](template_method.cpp) de esta carpeta:
`DataProcessor` (línea 6) define `process()` (línea 8) una sola vez
(sin `virtual`, no se puede sobreescribir), fijando el orden
`readData() → processData() → saveData()`; `readData()` (línea 17) y
`saveData()` (línea 21) son virtuales con una implementación compartida
por defecto, y solo `processData()` (línea 19) es `= 0` (puro virtual).
`CsvProcessor` (línea 24) y `JsonProcessor` (línea 29) solo
sobreescriben `processData()` — ninguna de las dos repite el código de
leer ni de guardar.

El `main` (línea 34) llama `.process()` en ambas (líneas 36 y 41) y
obtiene el mismo "Reading..."/"Saving..." en los dos casos, con solo el
paso de parseo cambiando. Si `saveData()` necesitara loguear algo
nuevo, se edita una sola vez en `DataProcessor` y las dos subclases lo
heredan automáticamente.
