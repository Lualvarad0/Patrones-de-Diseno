# Visitor en JavaScript

## El problema, en código

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Sin Visitor, cada operación nueva es un
método más en cada clase de figura:

```javascript
class Circle {
  getArea() {
    return Math.PI * this.radius ** 2;
  }
  toSvg() {
    return `<circle r="${this.radius}" />`;
  }
  // mañana agregás "exportar a JSON": otro método más acá
}

class Square {
  getArea() {
    return this.side ** 2;
  }
  toSvg() {
    return `<rect width="${this.side}" height="${this.side}" />`;
  }
  // ...y otro método más acá, repetido en TODAS las figuras
}
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agrega como método en cada clase de figura existente; `Circle` y
`Square` terminan conociendo lógica que no tiene nada que ver con "ser
una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`visitor.js`](visitor.js) de esta carpeta: `Circle` (línea 5) y
`Square` (línea 14) solo tienen un método `accept()` (líneas 9 y 18)
que llama de vuelta al visitante (`visitor.visitCircle(this)`) — doble
despacho: `accept()` sabe qué figura es, y así el visitante se entera
sin ningún chequeo de tipo. Las operaciones viven afuera, en
`AreaVisitor` (línea 23) y `SvgExportVisitor` (línea 32), cada una con
un método por tipo de figura.

El bloque de demo (línea 42) recorre el mismo arreglo de `shapes` dos
veces: una con `areaVisitor` (línea 45) y otra con `svgVisitor` (línea
50). Agregar una operación nueva ("exportar a JSON") es una clase
`JsonExportVisitor` más con sus propios `visitCircle`/`visitSquare` —
cero cambios en `Circle` ni en `Square`.
