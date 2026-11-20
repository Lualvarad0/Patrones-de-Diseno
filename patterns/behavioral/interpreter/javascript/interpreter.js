// Interpreter: models a tiny grammar (arithmetic expressions) as a tree
// of objects, where each node knows how to evaluate itself — evaluating
// the root recursively evaluates the whole expression.
class NumberExpression {
  constructor(value) {
    this.value = value;
  }
  interpret() {
    return this.value;
  }
}

class AddExpression {
  constructor(left, right) {
    this.left = left;
    this.right = right;
  }
  interpret() {
    return this.left.interpret() + this.right.interpret();
  }
}

class SubtractExpression {
  constructor(left, right) {
    this.left = left;
    this.right = right;
  }
  interpret() {
    return this.left.interpret() - this.right.interpret();
  }
}

// --- demo ---
// builds the tree for (5 + 3) - 2
const expression = new SubtractExpression(
  new AddExpression(new NumberExpression(5), new NumberExpression(3)),
  new NumberExpression(2)
);

console.log(`(5 + 3) - 2 = ${expression.interpret()}`);
