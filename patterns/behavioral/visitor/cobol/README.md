# Visitor en COBOL

## El problema, en código

Tu programa de dibujo tiene las clases `circle` y `square`, y necesitás
calcular áreas y también exportarlas a SVG. Sin Visitor, cada operación
nueva es un método más en cada clase de figura:

```cobol
*> en la clase circle:
method-id. get-area.
    procedure division returning area.
        compute area = 3.14159265358979 * radius * radius
    end method get-area.
method-id. to-svg.
    *> ...otro método más
*> y lo mismo habría que repetir, calcado, dentro de square
*> mañana agregás "exportar a JSON": otro método más en las DOS clases
```

Cada operación nueva (calcular perímetro, exportar a JSON, validar) se
agregaría como método en cada clase de figura existente; `circle` y
`square` terminarían conociendo lógica que no tiene nada que ver con
"ser una figura" — solo porque alguien necesitaba esa operación en algún
lado.

## Así queda con Visitor aplicado

Mirá [`visitor.cbl`](visitor.cbl) de esta carpeta: `circle` (línea 10) y
`square` (línea 40) solo tienen el método `accept` (líneas 29 y 59) que
invoca de vuelta al visitante (`invoke visitor "visit-circle" using
self`) — doble despacho: `accept` sabe qué figura es, y así el
visitante se entera sin ningún chequeo de clase. Las operaciones viven
afuera, en `area-visitor` (línea 70) y `svg-export-visitor` (línea 109),
cada una con un método `visit-circle`/`visit-square` por tipo de figura
(líneas 80, 92, 119 y 129).

El párrafo principal (línea 160) invoca `"accept"` sobre las mismas
figuras dos veces: una pasando `area-v` (líneas 168-169) y otra pasando
`svg-v` (líneas 175-176). Agregar una operación nueva ("exportar a
JSON") es una clase `json-export-visitor` más con sus propios
`visit-circle`/`visit-square` — cero cambios en `circle` ni en `square`.
