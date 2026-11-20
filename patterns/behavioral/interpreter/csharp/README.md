# Interpreter en C#

## El problema, en código

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, evaluás el árbol de la fórmula con una
función que distingue el tipo de nodo a mano:

```csharp
int Evaluate(object node)
{
    if (node is int number) return number;
    if (node is (string op, object left, object right))
    {
        if (op == "+") return Evaluate(left) + Evaluate(right);
        if (op == "-") return Evaluate(left) - Evaluate(right);
        // agregar "*" significa meter otro "if" acá adentro
        throw new Exception("operador desconocido");
    }
    throw new Exception("nodo desconocido");
}
```

Cada operador nuevo (`*`, `/`, `%`) es otro `if` dentro de la misma
función, y esa función es la única que sabe evaluar un nodo — nada se
puede extender sin tocarla.

## Así queda con Interpreter aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `NumberExpression`
(línea 9), `AddExpression` (línea 16) y `SubtractExpression` (línea 23)
implementan la misma interfaz `IExpression` (línea 4), cada uno con su
propio `Interpret()`. `AddExpression.Interpret()` (línea 20) no tiene
ningún `if` de operador — simplemente suma lo que devuelven sus dos hijos
(`_left.Interpret() + _right.Interpret()`), y cada hijo puede ser otro
nodo compuesto o un número; la recursión ocurre sola.

El `Main` (línea 32) arma el árbol de `(5 + 3) - 2` anidando los
constructores (líneas 35-38) y llama `expression.Interpret()` (línea 40)
una sola vez en la raíz. Agregar un operador `*` es una clase
`MultiplyExpression` nueva que implementa `IExpression` — cero cambios en
las clases existentes.
