// Abstract Factory: one factory interface creates a whole FAMILY of
// related products (button + checkbox), guaranteeing they're never mixed
// across families (no light button with a dark checkbox).
public interface IButton
{
    string Render();
}

public interface ICheckbox
{
    string Render();
}

public class LightButton : IButton
{
    public string Render() => "[ Light Button ]";
}

public class LightCheckbox : ICheckbox
{
    public string Render() => "[x] Light Checkbox";
}

public class DarkButton : IButton
{
    public string Render() => "[ Dark Button ]";
}

public class DarkCheckbox : ICheckbox
{
    public string Render() => "[x] Dark Checkbox";
}

// The abstract factory: one creation method per product in the family.
public interface IGuiFactory
{
    IButton CreateButton();
    ICheckbox CreateCheckbox();
}

public class LightFactory : IGuiFactory
{
    public IButton CreateButton() => new LightButton();
    public ICheckbox CreateCheckbox() => new LightCheckbox();
}

public class DarkFactory : IGuiFactory
{
    public IButton CreateButton() => new DarkButton();
    public ICheckbox CreateCheckbox() => new DarkCheckbox();
}

// The client only talks to IGuiFactory — it never knows which theme it got.
public class Application
{
    private readonly IButton _button;
    private readonly ICheckbox _checkbox;

    public Application(IGuiFactory factory)
    {
        _button = factory.CreateButton();
        _checkbox = factory.CreateCheckbox();
    }

    public void Render()
    {
        Console.WriteLine(_button.Render());
        Console.WriteLine(_checkbox.Render());
    }
}

class Program
{
    static void Main()
    {
        var lightApp = new Application(new LightFactory());
        lightApp.Render();

        var darkApp = new Application(new DarkFactory());
        darkApp.Render();
    }
}
