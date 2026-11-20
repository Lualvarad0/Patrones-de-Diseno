# Interpreter

**Categoría:** Comportamiento

## Problema

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Si evaluás el árbol de la fórmula con una sola función que
distingue el tipo de nodo a mano (`if operador == "+" ... else if
operador == "-" ...`), cada operador nuevo (`*`, `/`, `%`) es otro `if`
dentro de esa misma función — la única que sabe evaluar un nodo, y nada
se puede extender sin tocarla.

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

## Dónde lo vas a encontrar en la vida real

- Los motores de expresiones regulares: interpretan la sintaxis de un regex
  carácter por carácter contra el texto.
- Los motores de plantillas (Handlebars, Blade, Jinja2): interpretan
  `{{ variable }}` reemplazándolo al evaluar una gramática simple.
- Las fórmulas de Excel o Google Sheets (`=SUMA(A1:A5)`): se interpretan
  como una pequeña expresión matemática cada vez que cambia una celda.
- Los validadores de reglas de negocio ("edad > 18 AND país = 'MX'") que se
  evalúan como un árbol de condiciones.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
