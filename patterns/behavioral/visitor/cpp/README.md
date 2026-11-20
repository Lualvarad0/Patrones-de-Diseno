# Visitor en C++

## El problema, en código

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Sin Visitor, cada operación nueva es un
método más en cada clase de figura:

```cpp
class Circle {
public:
    double radius;
    double getArea() const { return M_PI * radius * radius; }
    std::string toSvg() const { return "<circle r=\"" + std::to_string(radius) + "\" />"; }
    // mañana agregás "exportar a JSON": otro método más acá
};

class Square {
public:
    double side;
    double getArea() const { return side * side; }
    std::string toSvg() const { return "<rect width=\"" + std::to_string(side) + "\" .../>"; }
    // ...y otro método más acá, repetido en TODAS las figuras
};
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agrega como método en cada clase de figura existente; `Circle` y
`Square` terminan conociendo lógica que no tiene nada que ver con "ser
una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`visitor.cpp`](visitor.cpp) de esta carpeta: `Circle` (línea 26) y
`Square` (línea 33) solo tienen un método `accept()` (líneas 30 y 37)
que llama de vuelta al visitante (`visitor.visitCircle(*this)`) — doble
despacho: `accept()` sabe qué figura es, y así el visitante se entera
sin ningún `dynamic_cast`. Las operaciones viven afuera, en
`AreaVisitor` (línea 40) y `SvgExportVisitor` (línea 50), cada una
heredando de `Visitor` (línea 13) con un método por tipo de figura.

El `main` (línea 60) recorre el mismo vector de `shapes` dos veces: una
con `areaVisitor` (línea 66) y otra con `svgVisitor` (línea 71). Agregar
una operación nueva ("exportar a JSON") es una clase `JsonExportVisitor`
más que herede de `Visitor` — cero cambios en `Circle` ni en `Square`.
