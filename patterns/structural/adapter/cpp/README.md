# Adapter en C++

## El problema, en código

Tu app dibuja una lista de figuras llamando a `draw()` en cada una, todas
heredando de `Shape`. Ahora necesitás integrar `LegacyRectangle`, una clase
de una librería de terceros con una firma completamente distinta
(`oldDraw(x1, y1, x2, y2)`, sin heredar de `Shape`). La solución rápida es
meter un caso especial en el bucle de dibujo:

```cpp
for (auto& item : items) {
    if (auto* legacy = dynamic_cast<LegacyRectangle*>(item.get())) {
        legacy->oldDraw(0, 0, 10, 20); // coordenadas hardcodeadas acá mismo
    } else {
        item->draw();
    }
    // y si mañana sumás otra librería con otra figura incompatible,
    // otro "if" más
}
```

El bucle de dibujo, que debería ser genérico, ahora conoce los detalles de
una librería externa puntual, y encima paga el costo de un `dynamic_cast`
en cada vuelta. Si integrás una segunda librería con otra figura rara,
tenés que volver a tocar este mismo bucle para agregarle otro caso especial
más.

## Así queda con Adapter aplicado

Mirá [`adapter.cpp`](adapter.cpp) de esta carpeta: `RectangleAdapter`
(línea 25) hereda de `Shape` (la interfaz que ya espera tu código) y, por
dentro, guarda la `LegacyRectangle` real junto con las coordenadas que
necesita (líneas 35-36). Su método `draw()` (línea 30) simplemente traduce
la llamada al método real: `legacyRectangle.oldDraw(x1, y1, x2, y2)`.

El `main` (línea 40) crea un `RectangleAdapter` y lo guarda en un
`std::unique_ptr<Shape>` — el bucle de dibujo de arriba podría iterar esta
figura sin ningún `dynamic_cast`, porque `RectangleAdapter::draw()` es
indistinguible de cualquier otro `Shape`. `LegacyRectangle` en sí no se
tocó ni una línea.
