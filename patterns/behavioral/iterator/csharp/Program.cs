// Iterator: exposes a way to walk through a collection's elements one by
// one (HasNext/Next) without exposing whether it's backed by an array,
// a list, or anything else. C#'s `foreach` already does this for you via
// IEnumerable — this example builds the mechanism by hand to show what's
// actually happening underneath.
public class BookCollection
{
    private readonly List<string> _books = new();

    public void Add(string title) => _books.Add(title);

    public BookIterator CreateIterator() => new BookIterator(_books);
}

public class BookIterator
{
    private readonly List<string> _books;
    private int _position = 0;

    public BookIterator(List<string> books) => _books = books;

    public bool HasNext() => _position < _books.Count;

    public string Next() => _books[_position++];
}

class Program
{
    static void Main()
    {
        var collection = new BookCollection();
        collection.Add("Clean Code");
        collection.Add("The Pragmatic Programmer");
        collection.Add("Design Patterns");

        var iterator = collection.CreateIterator();
        while (iterator.HasNext())
        {
            Console.WriteLine(iterator.Next());
        }
    }
}
