# Visitor en C#

## El problema, en código

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Sin Visitor, cada operación nueva es un
método más en cada clase de figura:

```csharp
public class Circle
{
    public double Radius { get; }
    public double GetArea() => Math.PI * Radius * Radius;
    public string ToSvg() => $"<circle r=\"{Radius}\" />";
    // mañana agregás "exportar a JSON": otro método más acá
}

public class Square
{
    public double Side { get; }
    public double GetArea() => Side * Side;
    public string ToSvg() => $"<rect width=\"{Side}\" height=\"{Side}\" />";
    // ...y otro método más acá, repetido en TODAS las figuras
}
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agrega como método en cada clase de figura existente; `Circle` y
`Square` terminan conociendo lógica que no tiene nada que ver con "ser
una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `Circle` (línea 18) y
`Square` (línea 25) solo tienen un método `Accept()` (líneas 22 y 29) que
llama de vuelta al visitante (`visitor.VisitCircle(this)`) — doble
despacho: `Accept()` sabe qué figura es, y así el visitante se entera sin
ningún `if`/casteo. Las operaciones viven afuera, en `AreaVisitor`
(línea 32) y `SvgExportVisitor` (línea 41), cada una implementando
`IVisitor` (línea 7) con un método por tipo de figura.

El `Main` (línea 50) recorre el mismo arreglo de `shapes` dos veces: una
con `areaVisitor` (línea 57) y otra con `svgVisitor` (línea 62). Agregar
una operación nueva ("exportar a JSON") es una clase `JsonExportVisitor`
más que implemente `IVisitor` — cero cambios en `Circle` ni en `Square`.
