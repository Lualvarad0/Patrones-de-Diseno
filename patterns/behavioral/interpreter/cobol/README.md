# Interpreter en COBOL

## El problema, en código

Tu programa de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, un único párrafo evaluaría el árbol
distinguiendo el tipo de nodo con un `if` tras otro:

```cobol
*> un único párrafo con todos los operadores mezclados
if node-type = "NUMBER"
    move node-value to result
else
    if node-op = "+"
        *> evaluar left, evaluar right, sumar
    else
        if node-op = "-"
            *> evaluar left, evaluar right, restar
        *> agregar "*" significa meter otro "if" acá adentro
        end-if
    end-if
end-if
```

Cada operador nuevo (`*`, `/`) es otro `if` anidado dentro del mismo
párrafo, y ese párrafo es el único que sabe evaluar un nodo — nada se
puede extender sin tocarlo.

## Así queda con Interpreter aplicado

Mirá [`interpreter.cbl`](interpreter.cbl) de esta carpeta:
`number-expression` (línea 8), `add-expression` (línea 28) y
`subtract-expression` (línea 56) son clases distintas, cada una con su
propio método `interpret` (líneas 19, 42 y 70). El `interpret` de
`add-expression` (línea 42) no tiene ningún `if` de operador —
simplemente invoca `"interpret"` sobre `left-exp` y `right-exp` (líneas
47-48) y suma los resultados con `compute` (línea 49); cada hijo puede
ser otro nodo compuesto o un número, y la recursión ocurre sola.

El párrafo principal (línea 101) arma el árbol de `(5 + 3) - 2` creando
cada nodo con `"new"`/`"init"` y pasándole sus hijos (líneas 103-116), y
al final invoca `"interpret"` una sola vez sobre `sub-node`, la raíz
(línea 118). Agregar un operador `*` es una clase
`multiply-expression` nueva con su propio `interpret` — cero cambios en
las clases existentes.
