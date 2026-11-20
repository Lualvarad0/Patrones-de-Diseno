# Visitor

**Categoría:** Comportamiento

## Problema

Tienes una jerarquía de clases estable (formas: `Círculo`, `Cuadrado`,
`Triángulo`) y necesitas agregar **nuevas operaciones** sobre ellas con
frecuencia (calcular área, exportar a SVG, exportar a JSON...) sin tener
que añadir un método nuevo a cada clase de la jerarquía cada vez.

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

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
