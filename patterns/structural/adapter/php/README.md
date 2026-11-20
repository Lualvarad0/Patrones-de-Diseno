# Adapter en PHP

## El problema, en código

Tu app dibuja una lista de figuras llamando a `->draw()` en cada una, todas
implementando `Shape`. Ahora necesitás integrar `LegacyRectangle`, una
clase de una librería de terceros con una firma completamente distinta
(`oldDraw($x1, $y1, $x2, $y2)`, sin implementar `Shape`). La solución
rápida es meter un caso especial en el bucle de dibujo:

```php
foreach ($items as $item) {
    if ($item instanceof LegacyRectangle) {
        $item->oldDraw(0, 0, 10, 20); // coordenadas hardcodeadas acá mismo
    } else {
        $item->draw();
    }
    // y si mañana sumás otra librería con otra figura incompatible,
    // otro "if" más
}
```

El bucle de dibujo, que debería ser genérico, ahora conoce los detalles de
una librería externa puntual. Si integrás una segunda librería con otra
figura rara, tenés que volver a tocar este mismo bucle (y cualquier otro
lugar del código que dibuje figuras) para agregarle otro caso especial más.

## Así queda con Adapter aplicado

Mirá [`Adapter.php`](Adapter.php) de esta carpeta: `RectangleAdapter`
(línea 23) implementa `Shape` (la interfaz que ya espera tu código) y, por
dentro, guarda la `LegacyRectangle` real junto con las coordenadas que
necesita, como propiedades promovidas en el constructor (líneas 25-31). Su
método `draw()` (línea 33) simplemente traduce la llamada al método real:
`$this->legacyRectangle->oldDraw($this->x1, $this->y1, $this->x2, $this->y2)`.

El bloque de demo (línea 40) crea un `RectangleAdapter` y lo trata como
**un `Shape` más** — el bucle de dibujo de arriba podría iterar esta figura
sin ningún `instanceof`, porque `RectangleAdapter::draw()` es
indistinguible de cualquier otro `Shape`. `LegacyRectangle` en sí no se
tocó ni una línea.
