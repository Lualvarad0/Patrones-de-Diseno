// Memento: the editor can save a snapshot of its own state and restore
// it later, without the history stack (Caretaker) ever looking inside
// the snapshot — it just stores and returns opaque Memento objects.
public class EditorMemento // the snapshot: immutable, opaque to everyone but the editor
{
    public string Content { get; }
    public EditorMemento(string content) => Content = content;
}

public class TextEditor
{
    public string Content { get; private set; } = "";

    public void Type(string text) => Content += text;

    public EditorMemento Save() => new EditorMemento(Content);

    public void Restore(EditorMemento memento) => Content = memento.Content;
}

// The "caretaker": keeps a history of snapshots, but never looks inside them.
public class History
{
    private readonly Stack<EditorMemento> _snapshots = new();

    public void Push(EditorMemento memento) => _snapshots.Push(memento);

    public EditorMemento Pop() => _snapshots.Pop();
}

class Program
{
    static void Main()
    {
        var editor = new TextEditor();
        var history = new History();

        editor.Type("Hello");
        history.Push(editor.Save()); // checkpoint 1: "Hello"

        editor.Type(", world!");
        history.Push(editor.Save()); // checkpoint 2: "Hello, world!"

        editor.Type(" This part is a typo.");
        Console.WriteLine($"Before undo: {editor.Content}");

        editor.Restore(history.Pop()); // undo back to checkpoint 2
        Console.WriteLine($"After undo: {editor.Content}");
    }
}
