// Factory Method: the creator declares a method that subclasses override
// to decide which concrete product to instantiate.
public interface IDocument
{
    string Render();
}

public class PdfDocument : IDocument
{
    public string Render() => "PDF document rendered";
}

public class WordDocument : IDocument
{
    public string Render() => "Word document rendered";
}

// The "Creator": defines the factory method as abstract and uses it
// internally without knowing which concrete IDocument it will get.
public abstract class DocumentCreator
{
    public abstract IDocument CreateDocument(); // the factory method

    public string Open()
    {
        var document = CreateDocument();
        return document.Render();
    }
}

public class PdfCreator : DocumentCreator
{
    public override IDocument CreateDocument() => new PdfDocument();
}

public class WordCreator : DocumentCreator
{
    public override IDocument CreateDocument() => new WordDocument();
}

class Program
{
    static void Main()
    {
        DocumentCreator creator = new PdfCreator();
        Console.WriteLine(creator.Open());

        creator = new WordCreator();
        Console.WriteLine(creator.Open());
    }
}
