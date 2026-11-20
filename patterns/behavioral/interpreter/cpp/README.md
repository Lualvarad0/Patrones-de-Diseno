# Interpreter en C++

## El problema, en código

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, evaluás el árbol de la fórmula con una
función que distingue el tipo de nodo a mano:

```cpp
int evaluate(Node* node) {
    if (node->isNumber) return node->value;
    if (node->operatorChar == '+') return evaluate(node->left) + evaluate(node->right);
    if (node->operatorChar == '-') return evaluate(node->left) - evaluate(node->right);
    // agregar '*' significa meter otro "if" acá adentro
    throw std::runtime_error("operador desconocido");
}
```

Cada operador nuevo (`*`, `/`, `%`) es otro `if` dentro de la misma
función, y esa función es la única que sabe evaluar un nodo — nada se
puede extender sin tocarla.

## Así queda con Interpreter aplicado

Mirá [`interpreter.cpp`](interpreter.cpp) de esta carpeta:
`NumberExpression` (línea 13), `AddExpression` (línea 21) y
`SubtractExpression` (línea 30) heredan de la misma clase abstracta
`Expression` (línea 7), cada uno con su propio `interpret()`.
`AddExpression::interpret()` (línea 25) no tiene ningún `if` de
operador — simplemente suma lo que devuelven sus dos hijos
(`left->interpret() + right->interpret()`), guardados como
`unique_ptr<Expression>` (línea 27); la recursión ocurre sola por
despacho virtual.

El `main` (línea 39) arma el árbol de `(5 + 3) - 2` anidando
`make_unique` (líneas 41-47) y llama `expression->interpret()` (línea
49) una sola vez en la raíz. Agregar un operador `*` es una clase
`MultiplyExpression` nueva que hereda de `Expression` — cero cambios en
las clases existentes.
