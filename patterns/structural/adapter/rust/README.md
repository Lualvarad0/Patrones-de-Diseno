# Adapter en Rust

## El problema, en código

Tu app dibuja una lista de figuras llamando a `.draw()` en cada una, todas
implementando el trait `Shape`. Ahora necesitás integrar `LegacyRectangle`,
un tipo de un crate de terceros con una firma completamente distinta
(`old_draw(x1, y1, x2, y2)`, sin implementar `Shape`). Como no podés
implementar un trait ajeno sobre un tipo ajeno sin un wrapper (la "orphan
rule" de Rust directamente te lo impide), la salida rápida termina siendo un
`enum` con un caso especial en el bucle de dibujo:

```rust
enum DrawItem {
    Normal(Box<dyn Shape>),
    Legacy(LegacyRectangle), // caso especial, fuera del trait Shape
}

for item in &items {
    match item {
        DrawItem::Normal(shape) => shape.draw(),
        DrawItem::Legacy(legacy) => legacy.old_draw(0, 0, 10, 20), // coordenadas hardcodeadas acá
    }
    // y si mañana sumás otro crate con otra figura incompatible, otra variante más
}
```

El bucle de dibujo, que debería ser genérico, ahora conoce los detalles de
un crate externo puntual. Si integrás otra librería con otra figura rara,
tenés que agregar otra variante al `enum` y otro brazo al `match`.

## Así queda con Adapter aplicado

Mirá [`adapter.rs`](adapter.rs) de esta carpeta: `RectangleAdapter` (línea
22) implementa el trait `Shape` (línea 30) — eso sí es compatible con la
orphan rule, porque `RectangleAdapter` es un tipo propio tuyo — y guarda
adentro la `LegacyRectangle` real junto con las coordenadas que necesita
(líneas 23-27). Su método `draw()` (línea 31) simplemente traduce la
llamada al método real:
`self.legacy_rectangle.old_draw(self.x1, self.y1, self.x2, self.y2)`.

El `main` (línea 37) mete el `RectangleAdapter` en un `Box<dyn Shape>` y lo
trata como **cualquier otro `Shape`** — el bucle de dibujo de arriba podría
iterar esta figura sin ningún `match` especial, porque
`RectangleAdapter::draw()` es indistinguible de cualquier otra
implementación de `Shape`. `LegacyRectangle` en sí no se tocó ni una línea.
