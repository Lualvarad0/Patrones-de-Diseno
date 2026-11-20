// Flyweight: the heavy, repeated part of an object's state (intrinsic —
// here, the tree's sprite/model) is shared across many instances; the
// part that differs per instance (extrinsic — here, x/y position) is
// passed in from outside instead of stored in the shared object.
public class TreeType // the flyweight: shared, created once per distinct type
{
    private readonly string _name;
    private readonly string _sprite;

    public TreeType(string name, string sprite)
    {
        _name = name;
        _sprite = sprite;
    }

    public void Draw(int x, int y) => Console.WriteLine($"Drawing {_name} ({_sprite}) at ({x},{y})");
}

// The factory: makes sure each distinct TreeType is created only once,
// no matter how many trees of that type end up in the forest.
public class TreeFactory
{
    private readonly Dictionary<string, TreeType> _treeTypes = new();

    public TreeType GetTreeType(string name, string sprite)
    {
        if (!_treeTypes.TryGetValue(name, out var treeType))
        {
            treeType = new TreeType(name, sprite);
            _treeTypes[name] = treeType;
            Console.WriteLine($"Created new TreeType: {name}");
        }
        return treeType;
    }
}

// Each Tree only stores its extrinsic state (position) plus a reference
// to the shared flyweight — not a full copy of the sprite data.
public class Tree
{
    private readonly int _x, _y;
    private readonly TreeType _type;

    public Tree(int x, int y, TreeType type)
    {
        _x = x;
        _y = y;
        _type = type;
    }

    public void Draw() => _type.Draw(_x, _y);
}

class Program
{
    static void Main()
    {
        var factory = new TreeFactory();
        var forest = new List<Tree>
        {
            new Tree(1, 2, factory.GetTreeType("Pine", "green-sprite")),
            new Tree(5, 7, factory.GetTreeType("Pine", "green-sprite")), // reuses the same TreeType
            new Tree(3, 9, factory.GetTreeType("Oak", "brown-sprite")),
        };

        foreach (var tree in forest) tree.Draw();
    }
}
