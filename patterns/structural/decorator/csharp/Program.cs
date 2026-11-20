// Decorator: wraps an object to add behavior, while implementing the same
// interface — so decorators can be stacked in any combination.
public interface IBeverage
{
    string Description();
    double Cost();
}

public class SimpleCoffee : IBeverage
{
    public string Description() => "Coffee";
    public double Cost() => 2.0;
}

// Base decorator: just forwards to the wrapped beverage by default.
public abstract class BeverageDecorator : IBeverage
{
    protected readonly IBeverage Beverage;
    protected BeverageDecorator(IBeverage beverage) => Beverage = beverage;

    public virtual string Description() => Beverage.Description();
    public virtual double Cost() => Beverage.Cost();
}

public class MilkDecorator : BeverageDecorator
{
    public MilkDecorator(IBeverage beverage) : base(beverage) { }
    public override string Description() => $"{Beverage.Description()} + Milk";
    public override double Cost() => Beverage.Cost() + 0.5;
}

public class SugarDecorator : BeverageDecorator
{
    public SugarDecorator(IBeverage beverage) : base(beverage) { }
    public override string Description() => $"{Beverage.Description()} + Sugar";
    public override double Cost() => Beverage.Cost() + 0.2;
}

class Program
{
    static void Main()
    {
        IBeverage beverage = new SimpleCoffee();
        beverage = new MilkDecorator(beverage);
        beverage = new SugarDecorator(beverage); // decorators stack freely

        Console.WriteLine($"{beverage.Description()} => ${beverage.Cost()}");
    }
}
