// Interpreter: models a tiny grammar (arithmetic expressions) as a tree
// of objects, where each node knows how to evaluate itself — evaluating
// the root recursively evaluates the whole expression.
interface Expression {
    int interpret();
}

class NumberExpression implements Expression {
    private final int value;
    NumberExpression(int value) { this.value = value; }
    public int interpret() { return value; }
}

class AddExpression implements Expression {
    private final Expression left, right;
    AddExpression(Expression left, Expression right) { this.left = left; this.right = right; }
    public int interpret() { return left.interpret() + right.interpret(); }
}

class SubtractExpression implements Expression {
    private final Expression left, right;
    SubtractExpression(Expression left, Expression right) { this.left = left; this.right = right; }
    public int interpret() { return left.interpret() - right.interpret(); }
}

public class InterpreterDemo {
    public static void main(String[] args) {
        // builds the tree for (5 + 3) - 2
        Expression expression = new SubtractExpression(
                new AddExpression(new NumberExpression(5), new NumberExpression(3)),
                new NumberExpression(2)
        );

        System.out.println("(5 + 3) - 2 = " + expression.interpret());
    }
}
