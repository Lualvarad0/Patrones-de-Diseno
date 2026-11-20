# Interpreter en Java

## El problema, en código

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, evaluás el árbol de la fórmula con un
método que distingue el tipo de nodo a mano:

```java
int evaluate(Object node) {
    if (node instanceof Integer number) return number;
    if (node instanceof OpNode op) {
        if (op.operator.equals("+")) return evaluate(op.left) + evaluate(op.right);
        if (op.operator.equals("-")) return evaluate(op.left) - evaluate(op.right);
        // agregar "*" significa meter otro "if" acá adentro
        throw new RuntimeException("operador desconocido");
    }
    throw new RuntimeException("nodo desconocido");
}
```

Cada operador nuevo (`*`, `/`, `%`) es otro `if` dentro del mismo método,
y ese método es el único que sabe evaluar un nodo — nada se puede
extender sin tocarlo.

## Así queda con Interpreter aplicado

Mirá [`InterpreterDemo.java`](InterpreterDemo.java) de esta carpeta:
`NumberExpression` (línea 8), `AddExpression` (línea 14) y
`SubtractExpression` (línea 20) implementan la misma interfaz
`Expression` (línea 4), cada uno con su propio `interpret()`.
`AddExpression.interpret()` (línea 17) no tiene ningún `if` de operador —
simplemente suma lo que devuelven sus dos hijos
(`left.interpret() + right.interpret()`), y cada hijo puede ser otro nodo
compuesto o un número; la recursión ocurre sola.

El `main` (línea 27) arma el árbol de `(5 + 3) - 2` anidando los
constructores (líneas 29-32) y llama `expression.interpret()` (línea 34)
una sola vez en la raíz. Agregar un operador `*` es una clase
`MultiplyExpression` nueva que implementa `Expression` — cero cambios en
las clases existentes.
