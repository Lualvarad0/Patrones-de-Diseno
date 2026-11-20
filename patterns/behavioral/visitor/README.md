# Visitor

**Categoría:** Comportamiento

## Problema

Tu app de dibujo tiene `Circle` y `Square`, y necesitás calcular áreas y
también exportarlas a SVG. Si cada operación nueva se agrega como método
en cada clase de figura (`GetArea()`, `ToSvg()`...), `Circle` y `Square`
terminan conociendo lógica que no tiene nada que ver con "ser una
figura" — y agregar una operación más (exportar a JSON, por ejemplo)
significa editar todas las clases de figura existentes otra vez.

## Solución

Mueves cada nueva operación a una clase "visitante" separada, con un
método `visitar(tipoConcreto)` por cada clase de la jerarquía. Cada clase
de la jerarquía solo necesita un único método genérico (`aceptar(visitor)`)
que llama al método correspondiente del visitante pasándose a sí misma —
esto permite que el visitante sepa exactamente qué tipo concreto recibió
(double dispatch).

## Cuándo usarlo

- Cuando la jerarquía de objetos es estable pero necesitas agregar
  operaciones nuevas sobre ella con frecuencia.

## Cuándo NO usarlo

- Si la jerarquía de clases cambia seguido (se agregan tipos nuevos todo
  el tiempo), cada visitante nuevo tendría que actualizarse por cada tipo
  — en ese caso un método normal en cada clase es más simple de mantener.

## Dónde lo vas a encontrar en la vida real

- Los compiladores y linters (ESLint, Babel): recorren el árbol de sintaxis
  (AST) de tu código con un "visitor" para aplicar una regla o
  transformación, sin tocar las clases que representan cada nodo del código.
- Exportar un mismo documento de diseño a PDF, PNG o SVG: un visitor
  distinto por formato recorre las mismas formas (círculos, rectángulos,
  texto) sin modificar sus clases.
- Calcular impuestos distintos para libros, electrónica y comida dentro de
  un mismo carrito de compras, con un "visitor" de impuestos que sabe tratar
  cada tipo de producto.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
