// Builder: constructs a complex object step by step through chainable
// methods, instead of a constructor with a dozen optional parameters.
public class Pizza
{
    public string Size { get; set; } = "medium";
    public bool Cheese { get; set; }
    public bool Pepperoni { get; set; }
    public bool Mushrooms { get; set; }

    public override string ToString()
    {
        var toppings = new List<string>();
        if (Cheese) toppings.Add("cheese");
        if (Pepperoni) toppings.Add("pepperoni");
        if (Mushrooms) toppings.Add("mushrooms");
        return $"{Size} pizza with {(toppings.Count > 0 ? string.Join(", ", toppings) : "no toppings")}";
    }
}

public class PizzaBuilder
{
    private readonly Pizza _pizza = new();

    public PizzaBuilder WithSize(string size)
    {
        _pizza.Size = size;
        return this; // returning `this` is what makes the calls chainable
    }

    public PizzaBuilder AddCheese()
    {
        _pizza.Cheese = true;
        return this;
    }

    public PizzaBuilder AddPepperoni()
    {
        _pizza.Pepperoni = true;
        return this;
    }

    public PizzaBuilder AddMushrooms()
    {
        _pizza.Mushrooms = true;
        return this;
    }

    public Pizza Build() => _pizza;
}

class Program
{
    static void Main()
    {
        var pizza = new PizzaBuilder()
            .WithSize("large")
            .AddCheese()
            .AddPepperoni()
            .Build();

        Console.WriteLine(pizza);
    }
}
