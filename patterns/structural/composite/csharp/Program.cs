// Composite: files (leaves) and folders (containers) implement the same
// interface, so the client can call GetSize() on either one without
// asking "is this a leaf or a folder?" first.
public interface IFileSystemItem
{
    int GetSize();
    void Print(string indent = "");
}

public class FileItem : IFileSystemItem
{
    private readonly string _name;
    private readonly int _size;

    public FileItem(string name, int size)
    {
        _name = name;
        _size = size;
    }

    public int GetSize() => _size;
    public void Print(string indent = "") => Console.WriteLine($"{indent}{_name} ({_size}KB)");
}

public class Folder : IFileSystemItem
{
    private readonly string _name;
    private readonly List<IFileSystemItem> _children = new();

    public Folder(string name) => _name = name;

    public void Add(IFileSystemItem item) => _children.Add(item);

    // Delegates to each child and sums the results — doesn't matter if a
    // child is a FileItem or another Folder, the recursion just happens.
    public int GetSize() => _children.Sum(child => child.GetSize());

    public void Print(string indent = "")
    {
        Console.WriteLine($"{indent}{_name}/ ({GetSize()}KB)");
        foreach (var child in _children)
            child.Print(indent + "  ");
    }
}

class Program
{
    static void Main()
    {
        var root = new Folder("project");
        root.Add(new FileItem("README.md", 2));

        var src = new Folder("src");
        src.Add(new FileItem("main.cs", 5));
        src.Add(new FileItem("utils.cs", 3));
        root.Add(src);

        root.Print(); // the client only ever calls Print()/GetSize() on IFileSystemItem
    }
}
