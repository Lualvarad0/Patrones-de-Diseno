<?php
// Interpreter: models a tiny grammar (arithmetic expressions) as a tree
// of objects, where each node knows how to evaluate itself — evaluating
// the root recursively evaluates the whole expression.
interface Expression
{
    public function interpret(): int;
}

class NumberExpression implements Expression
{
    public function __construct(private int $value) {}
    public function interpret(): int { return $this->value; }
}

class AddExpression implements Expression
{
    public function __construct(private Expression $left, private Expression $right) {}
    public function interpret(): int { return $this->left->interpret() + $this->right->interpret(); }
}

class SubtractExpression implements Expression
{
    public function __construct(private Expression $left, private Expression $right) {}
    public function interpret(): int { return $this->left->interpret() - $this->right->interpret(); }
}

// --- demo ---
// builds the tree for (5 + 3) - 2
$expression = new SubtractExpression(
    new AddExpression(new NumberExpression(5), new NumberExpression(3)),
    new NumberExpression(2)
);

echo "(5 + 3) - 2 = " . $expression->interpret() . "\n";
