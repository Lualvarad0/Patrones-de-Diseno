// Prototype: the object knows how to clone itself, so you can get a copy
// without coupling the caller to the concrete class or constructor.
public class Sheep : ICloneable
{
    public string Name { get; set; }
    public string Color { get; set; }

    public Sheep(string name, string color)
    {
        Name = name;
        Color = color;
    }

    // Shallow copy here is enough because every field is an immutable
    // value type/string — if Sheep held a mutable reference field, a
    // shallow clone would make both sheep share (and corrupt) it.
    public object Clone() => new Sheep(Name, Color);

    public override string ToString() => $"Sheep(name={Name}, color={Color})";
}

class Program
{
    static void Main()
    {
        var original = new Sheep("Dolly", "white");
        var clone = (Sheep)original.Clone();
        clone.Name = "Dolly Jr.";

        Console.WriteLine(original); // untouched
        Console.WriteLine(clone);    // independent copy with one field changed
    }
}
