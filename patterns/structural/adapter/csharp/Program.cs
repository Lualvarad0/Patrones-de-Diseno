// Adapter: makes an incompatible interface (LegacyRectangle) work where a
// different interface (IShape) is expected, without touching either class.

// The interface our client code expects.
public interface IShape
{
    void Draw();
}

// The incompatible class we can't (or don't want to) modify — imagine this
// comes from a third-party library with its own quirky API.
public class LegacyRectangle
{
    public void OldDraw(int x1, int y1, int x2, int y2)
    {
        Console.WriteLine($"LegacyRectangle drawn from ({x1},{y1}) to ({x2},{y2})");
    }
}

// The adapter: implements IShape, and translates Draw() into the call
// LegacyRectangle actually understands.
public class RectangleAdapter : IShape
{
    private readonly LegacyRectangle _legacyRectangle;
    private readonly int _x1, _y1, _x2, _y2;

    public RectangleAdapter(LegacyRectangle legacyRectangle, int x1, int y1, int x2, int y2)
    {
        _legacyRectangle = legacyRectangle;
        (_x1, _y1, _x2, _y2) = (x1, y1, x2, y2);
    }

    public void Draw() => _legacyRectangle.OldDraw(_x1, _y1, _x2, _y2);
}

class Program
{
    static void Main()
    {
        IShape shape = new RectangleAdapter(new LegacyRectangle(), 0, 0, 10, 20);
        shape.Draw(); // client only ever talks to IShape
    }
}
