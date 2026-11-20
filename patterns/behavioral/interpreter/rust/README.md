# Interpreter en Rust

## El problema, en código

Tu app de reportes deja que el usuario escriba fórmulas simples como
`(5 + 3) - 2`. Sin Interpreter, evaluás el árbol de la fórmula con una
función que distingue el tipo de nodo a mano, normalmente usando un
`enum` con un `match`:

```rust
enum Node {
    Number(i32),
    Op { operator: char, left: Box<Node>, right: Box<Node> },
}

fn evaluate(node: &Node) -> i32 {
    match node {
        Node::Number(n) => *n,
        Node::Op { operator: '+', left, right } => evaluate(left) + evaluate(right),
        Node::Op { operator: '-', left, right } => evaluate(left) - evaluate(right),
        // agregar '*' significa meter otro brazo acá adentro
        _ => panic!("operador desconocido"),
    }
}
```

Cada operador nuevo (`*`, `/`, `%`) es otro brazo dentro del mismo
`match`, y esa función es la única que sabe evaluar un nodo — nada se
puede extender sin tocarla.

## Así queda con Interpreter aplicado

Mirá [`interpreter.rs`](interpreter.rs) de esta carpeta:
`NumberExpression` (línea 8), `AddExpression` (línea 13) y
`SubtractExpression` (línea 18) implementan el mismo trait `Expression`
(línea 4), cada uno con su propio `interpret()`.
`AddExpression::interpret()` (línea 15) no tiene ningún `match` de
operador — simplemente suma lo que devuelven sus dos hijos
(`self.left.interpret() + self.right.interpret()`), guardados como
`Box<dyn Expression>` (línea 13); la recursión ocurre sola.

El `main` (línea 23) arma el árbol de `(5 + 3) - 2` anidando los structs
(líneas 25-31) y llama `expression.interpret()` (línea 33) una sola vez
en la raíz. Agregar un operador `*` es un struct `MultiplyExpression`
nuevo que implementa `Expression` — cero cambios en los structs
existentes.
