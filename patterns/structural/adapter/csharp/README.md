# Adapter en C#

## El problema, en código

Tu app dibuja una lista de figuras llamando a `.Draw()` en cada una, todas
implementando `IShape`. Ahora necesitás integrar `LegacyRectangle`, una
clase de una librería de terceros con una firma completamente distinta
(`OldDraw(x1, y1, x2, y2)`, sin implementar `IShape`). La solución rápida es
meter un caso especial en el bucle de dibujo:

```csharp
foreach (var item in items)
{
    if (item is IShape shape)
        shape.Draw();
    else if (item is LegacyRectangle legacy)
        legacy.OldDraw(0, 0, 10, 20); // coordenadas hardcodeadas acá mismo
    // y si mañana sumás otra librería con otra figura incompatible,
    // otro "else if" más
}
```

El bucle de dibujo, que debería ser genérico, ahora conoce los detalles de
una librería externa puntual. Si integrás una segunda librería con otra
figura rara, tenés que volver a tocar este mismo bucle (y cualquier otro
lugar del código que dibuje figuras) para agregarle otro caso especial más.

## Así queda con Adapter aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `RectangleAdapter` (línea
22) implementa `IShape` (la interfaz que ya espera tu código) y, por
dentro, guarda la `LegacyRectangle` real junto con las coordenadas que
necesita (líneas 24-25). Su método `Draw()` (línea 33) simplemente traduce
la llamada al método real: `_legacyRectangle.OldDraw(_x1, _y1, _x2, _y2)`.

El `Main` (línea 40) crea un `RectangleAdapter` y lo trata como **un
`IShape` más** — el bucle de dibujo de arriba podría iterar esta figura sin
ningún `if`/`else if`, porque `RectangleAdapter.Draw()` es indistinguible
de cualquier otro `IShape`. `LegacyRectangle` en sí no se tocó ni una línea.
