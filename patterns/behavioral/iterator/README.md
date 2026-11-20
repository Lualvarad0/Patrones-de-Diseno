# Iterator

**Categoría:** Comportamiento

## Problema

Tienes una colección (lista, árbol, grafo) y quieres recorrer sus
elementos uno por uno **sin exponer su estructura interna** (si es un
array, una lista enlazada, un árbol) al código que la recorre.

## Solución

Extraes la lógica de recorrido a un objeto "iterador" separado, con una
interfaz común (`tieneSiguiente()` / `siguiente()`, o el protocolo nativo
de iteración del lenguaje). La colección expone un método para crear un
iterador sobre sí misma; el cliente recorre usando solo esa interfaz, sin
saber cómo está hecha la colección por dentro.

## Cuándo usarlo

- Casi siempre lo tienes gratis: la mayoría de lenguajes modernos ya
  integran este patrón en su sintaxis (`for...of`, `foreach`, `Iterator`
  trait de Rust, etc.) — vale la pena entenderlo igual para saber qué pasa
  "por debajo" cuando iteras algo.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
