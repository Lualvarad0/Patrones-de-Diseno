// Interpreter: models a tiny grammar (arithmetic expressions) as a tree
// of objects, where each node knows how to evaluate itself — evaluating
// the root recursively evaluates the whole expression.
public interface IExpression
{
    int Interpret();
}

public class NumberExpression : IExpression
{
    private readonly int _value;
    public NumberExpression(int value) => _value = value;
    public int Interpret() => _value;
}

public class AddExpression : IExpression
{
    private readonly IExpression _left, _right;
    public AddExpression(IExpression left, IExpression right) => (_left, _right) = (left, right);
    public int Interpret() => _left.Interpret() + _right.Interpret();
}

public class SubtractExpression : IExpression
{
    private readonly IExpression _left, _right;
    public SubtractExpression(IExpression left, IExpression right) => (_left, _right) = (left, right);
    public int Interpret() => _left.Interpret() - _right.Interpret();
}

class Program
{
    static void Main()
    {
        // builds the tree for (5 + 3) - 2
        IExpression expression = new SubtractExpression(
            new AddExpression(new NumberExpression(5), new NumberExpression(3)),
            new NumberExpression(2)
        );

        Console.WriteLine($"(5 + 3) - 2 = {expression.Interpret()}");
    }
}
