# Template Method en COBOL

## El problema, en código

Tenés que procesar archivos CSV y JSON: leer, parsear y guardar. Sin
Template Method, cada formato terminaría con su propia clase que copia
los mismos párrafos de leer y guardar:

```cobol
*> csv-processor tendría su propio "process" completo:
method-id. process.
    procedure division.
        display "Reading raw data..."     *> copiado
        display "Parsing data as CSV"      *> el único paso distinto
        display "Saving results..."        *> copiado
    end method process.
*> json-processor repetiría exactamente lo mismo, cambiando solo
*> el display del medio — y si "guardar" necesita loguear algo,
*> hay que acordarse de tocar las dos clases (y la tercera...) por igual
```

Los párrafos de leer y guardar quedarían duplicados en cada clase; si
algún día cambian, hay que recordar actualizar cada copia por separado,
y es fácil que alguna quede desincronizada.

## Así queda con Template Method aplicado

Mirá [`template_method.cbl`](template_method.cbl) de esta carpeta:
`data-processor` (línea 8) define el método `process` (línea 14) una
sola vez, fijando el orden `invoke self "read-data"` → `"process-data"`
→ `"save-data"` (líneas 16-18); `read-data` (línea 21) y `save-data`
(línea 32) tienen una implementación compartida, y `process-data`
(línea 27) en la clase base no hace nada (`continue`) — solo existe para
que las subclases la sobreescriban. `csv-processor` (línea 42) y
`json-processor` (línea 54) **heredan** de `data-processor` con
`inherits` y solo sobreescriben `process-data` — ninguna de las dos
repite el código de leer ni de guardar.

El párrafo principal (línea 77) invoca `processor "process"` para cada
uno (líneas 79 y 85) y obtiene el mismo "Reading..."/"Saving..." en los
dos casos, con solo el paso de parseo cambiando. Si `save-data`
necesitara loguear algo nuevo, se edita una sola vez en `data-processor`
y ambas subclases lo heredan automáticamente.
