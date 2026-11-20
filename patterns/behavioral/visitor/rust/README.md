# Visitor en Rust

## El problema, en código

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Sin Visitor, cada operación nueva es un
método más en cada tipo de figura:

```rust
impl Circle {
    fn get_area(&self) -> f64 { std::f64::consts::PI * self.radius * self.radius }
    fn to_svg(&self) -> String { format!("<circle r=\"{}\" />", self.radius) }
    // mañana agregás "exportar a JSON": otro método más acá
}

impl Square {
    fn get_area(&self) -> f64 { self.side * self.side }
    fn to_svg(&self) -> String { format!("<rect width=\"{}\" height=\"{}\" />", self.side, self.side) }
    // ...y otro método más acá, repetido en TODAS las figuras
}
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agrega como método en cada tipo de figura existente; `Circle` y
`Square` terminan conociendo lógica que no tiene nada que ver con "ser
una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`visitor.rs`](visitor.rs) de esta carpeta: `Circle` (línea 14) y
`Square` (línea 24) implementan el trait `Shape` (línea 10) solo con
`accept()` (líneas 19 y 29), que llama de vuelta al visitante
(`visitor.visit_circle(self)`) — doble despacho: `accept()` sabe qué
figura es, y así el visitante se entera sin ningún downcasting. Las
operaciones viven afuera, en `AreaVisitor` (línea 34) y
`SvgExportVisitor` (línea 44), cada una implementando el trait `Visitor`
(línea 5) con un método por tipo de figura.

El `main` (línea 54) recorre el mismo vector de `shapes` dos veces: una
con `area_visitor` (líneas 60-63) y otra con `svg_visitor` (líneas
67-70). Agregar una operación nueva ("exportar a JSON") es un struct
`JsonExportVisitor` más que implemente `Visitor` — cero cambios en
`Circle` ni en `Square`.
