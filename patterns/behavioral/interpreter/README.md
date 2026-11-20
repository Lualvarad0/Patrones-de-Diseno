# Interpreter

**Categoría:** Comportamiento

## Problema

Necesitas evaluar frases de un lenguaje sencillo y bien definido (una
expresión aritmética, una regla de negocio tipo `"edad > 18 AND pais =
'MX'"`, una query simple) sin escribir un parser/compilador completo a
mano con todas sus herramientas.

## Solución

Modelas cada regla gramatical como una clase con un método `interpretar()`
(o `evaluar()`). Las expresiones se componen como un árbol: expresiones
simples (hojas) y expresiones compuestas (nodos que contienen otras
expresiones, como Composite). Evaluar la expresión raíz dispara
recursivamente la evaluación de todo el árbol.

## Cuándo usarlo

- Lenguajes pequeños y estables (DSLs internos) donde la gramática no
  cambia seguido — para algo complejo o cambiante, usa un parser generator
  en vez de este patrón a mano.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
