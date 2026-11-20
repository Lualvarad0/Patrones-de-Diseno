# Interpreter en JavaScript

## El problema, en código

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, evaluás el árbol de la fórmula con una
función que distingue el tipo de nodo a mano:

```javascript
function evaluate(node) {
  if (typeof node === "number") return node;
  if (node.operator === "+") return evaluate(node.left) + evaluate(node.right);
  if (node.operator === "-") return evaluate(node.left) - evaluate(node.right);
  // agregar "*" significa meter otro "if" acá adentro
  throw new Error("operador desconocido");
}
```

Cada operador nuevo (`*`, `/`, `%`) es otro `if` dentro de la misma
función, y esa función es la única que sabe evaluar un nodo — nada se
puede extender sin tocarla.

## Así queda con Interpreter aplicado

Mirá [`interpreter.js`](interpreter.js) de esta carpeta:
`NumberExpression` (línea 4), `AddExpression` (línea 13) y
`SubtractExpression` (línea 23) tienen todas un método `interpret()`.
`AddExpression.interpret()` (línea 18) no tiene ningún `if` de operador —
simplemente suma lo que devuelven sus dos hijos
(`this.left.interpret() + this.right.interpret()`), y cada hijo puede ser
otro nodo compuesto o un número; la recursión ocurre sola.

El bloque de demo (línea 33) arma el árbol de `(5 + 3) - 2` anidando los
constructores (líneas 35-38) y llama `expression.interpret()` (línea 40)
una sola vez en la raíz. Agregar un operador `*` es una clase
`MultiplyExpression` nueva con su propio `interpret()` — cero cambios en
las clases existentes.
