# Visitor en Java

## El problema, en código

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Sin Visitor, cada operación nueva es un
método más en cada clase de figura:

```java
class Circle {
    final double radius;
    double getArea() { return Math.PI * radius * radius; }
    String toSvg() { return "<circle r=\"" + radius + "\" />"; }
    // mañana agregás "exportar a JSON": otro método más acá
}

class Square {
    final double side;
    double getArea() { return side * side; }
    String toSvg() { return "<rect width=\"" + side + "\" height=\"" + side + "\" />"; }
    // ...y otro método más acá, repetido en TODAS las figuras
}
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agrega como método en cada clase de figura existente; `Circle` y
`Square` terminan conociendo lógica que no tiene nada que ver con "ser
una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`VisitorDemo.java`](VisitorDemo.java) de esta carpeta: `Circle`
(línea 14) y `Square` (línea 20) solo tienen un método `accept()`
(líneas 17 y 23) que llama de vuelta al visitante
(`visitor.visitCircle(this)`) — doble despacho: `accept()` sabe qué
figura es, y así el visitante se entera sin ningún `instanceof`. Las
operaciones viven afuera, en `AreaVisitor` (línea 26) y
`SvgExportVisitor` (línea 35), cada una implementando `Visitor` (línea
5) con un método por tipo de figura.

El `main` (línea 44) recorre el mismo arreglo de `shapes` dos veces: una
con `areaVisitor` (línea 49) y otra con `svgVisitor` (línea 54). Agregar
una operación nueva ("exportar a JSON") es una clase `JsonExportVisitor`
más que implemente `Visitor` — cero cambios en `Circle` ni en `Square`.
