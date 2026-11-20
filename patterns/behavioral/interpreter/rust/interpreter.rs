// Interpreter: models a tiny grammar (arithmetic expressions) as a tree
// of objects, where each node knows how to evaluate itself — evaluating
// the root recursively evaluates the whole expression.
trait Expression {
    fn interpret(&self) -> i32;
}

struct NumberExpression { value: i32 }
impl Expression for NumberExpression {
    fn interpret(&self) -> i32 { self.value }
}

struct AddExpression { left: Box<dyn Expression>, right: Box<dyn Expression> }
impl Expression for AddExpression {
    fn interpret(&self) -> i32 { self.left.interpret() + self.right.interpret() }
}

struct SubtractExpression { left: Box<dyn Expression>, right: Box<dyn Expression> }
impl Expression for SubtractExpression {
    fn interpret(&self) -> i32 { self.left.interpret() - self.right.interpret() }
}

fn main() {
    // builds the tree for (5 + 3) - 2
    let expression = SubtractExpression {
        left: Box::new(AddExpression {
            left: Box::new(NumberExpression { value: 5 }),
            right: Box::new(NumberExpression { value: 3 }),
        }),
        right: Box::new(NumberExpression { value: 2 }),
    };

    println!("(5 + 3) - 2 = {}", expression.interpret());
}
