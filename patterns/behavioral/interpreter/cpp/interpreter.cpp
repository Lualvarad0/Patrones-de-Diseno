// Interpreter: models a tiny grammar (arithmetic expressions) as a tree
// of objects, where each node knows how to evaluate itself — evaluating
// the root recursively evaluates the whole expression.
#include <iostream>
#include <memory>

class Expression {
public:
    virtual int interpret() const = 0;
    virtual ~Expression() = default;
};

class NumberExpression : public Expression {
public:
    explicit NumberExpression(int value) : value(value) {}
    int interpret() const override { return value; }
private:
    int value;
};

class AddExpression : public Expression {
public:
    AddExpression(std::unique_ptr<Expression> left, std::unique_ptr<Expression> right)
        : left(std::move(left)), right(std::move(right)) {}
    int interpret() const override { return left->interpret() + right->interpret(); }
private:
    std::unique_ptr<Expression> left, right;
};

class SubtractExpression : public Expression {
public:
    SubtractExpression(std::unique_ptr<Expression> left, std::unique_ptr<Expression> right)
        : left(std::move(left)), right(std::move(right)) {}
    int interpret() const override { return left->interpret() - right->interpret(); }
private:
    std::unique_ptr<Expression> left, right;
};

int main() {
    // builds the tree for (5 + 3) - 2
    auto expression = std::make_unique<SubtractExpression>(
        std::make_unique<AddExpression>(
            std::make_unique<NumberExpression>(5),
            std::make_unique<NumberExpression>(3)
        ),
        std::make_unique<NumberExpression>(2)
    );

    std::cout << "(5 + 3) - 2 = " << expression->interpret() << std::endl;

    return 0;
}
