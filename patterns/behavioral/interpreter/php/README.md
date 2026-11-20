# Interpreter en PHP

## El problema, en código

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, evaluás el árbol de la fórmula con una
función que distingue el tipo de nodo a mano:

```php
function evaluate($node): int {
    if (is_int($node)) return $node;
    if ($node['operator'] === '+') return evaluate($node['left']) + evaluate($node['right']);
    if ($node['operator'] === '-') return evaluate($node['left']) - evaluate($node['right']);
    // agregar "*" significa meter otro "if" acá adentro
    throw new Exception("operador desconocido");
}
```

Cada operador nuevo (`*`, `/`, `%`) es otro `if` dentro de la misma
función, y esa función es la única que sabe evaluar un nodo — nada se
puede extender sin tocarla.

## Así queda con Interpreter aplicado

Mirá [`Interpreter.php`](Interpreter.php) de esta carpeta:
`NumberExpression` (línea 10), `AddExpression` (línea 16) y
`SubtractExpression` (línea 22) implementan la misma interfaz
`Expression` (línea 5), cada uno con su propio `interpret()`.
`AddExpression::interpret()` (línea 19) no tiene ningún `if` de
operador — simplemente suma lo que devuelven sus dos hijos
(`$this->left->interpret() + $this->right->interpret()`), y cada hijo
puede ser otro nodo compuesto o un número; la recursión ocurre sola.

El bloque de demo (línea 28) arma el árbol de `(5 + 3) - 2` anidando los
constructores (líneas 30-33) y llama `$expression->interpret()` (línea
35) una sola vez en la raíz. Agregar un operador `*` es una clase
`MultiplyExpression` nueva que implementa `Expression` — cero cambios en
las clases existentes.
