# Visitor en PHP

## El problema, en código

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Sin Visitor, cada operación nueva es un
método más en cada clase de figura:

```php
class Circle
{
    public function getArea(): float { return M_PI * $this->radius ** 2; }
    public function toSvg(): string { return "<circle r=\"{$this->radius}\" />"; }
    // mañana agregás "exportar a JSON": otro método más acá
}

class Square
{
    public function getArea(): float { return $this->side ** 2; }
    public function toSvg(): string { return "<rect width=\"{$this->side}\" height=\"{$this->side}\" />"; }
    // ...y otro método más acá, repetido en TODAS las figuras
}
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agrega como método en cada clase de figura existente; `Circle` y
`Square` terminan conociendo lógica que no tiene nada que ver con "ser
una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`Visitor.php`](Visitor.php) de esta carpeta: `Circle` (línea 17) y
`Square` (línea 23) solo tienen un método `accept()` (líneas 20 y 26)
que llama de vuelta al visitante (`$visitor->visitCircle($this)`) —
doble despacho: `accept()` sabe qué figura es, y así el visitante se
entera sin ningún chequeo de tipo. Las operaciones viven afuera, en
`AreaVisitor` (línea 29) y `SvgExportVisitor` (línea 42), cada una
implementando `Visitor` (línea 6) con un método por tipo de figura.

El bloque de demo (línea 56) recorre el mismo arreglo de `$shapes` dos
veces: una con `$areaVisitor` (línea 59) y otra con `$svgVisitor`
(línea 64). Agregar una operación nueva ("exportar a JSON") es una clase
`JsonExportVisitor` más que implemente `Visitor` — cero cambios en
`Circle` ni en `Square`.
