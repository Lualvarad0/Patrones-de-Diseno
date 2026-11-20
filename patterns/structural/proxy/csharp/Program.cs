// Proxy: implements the same interface as the real object and controls
// access to it — here, a "virtual proxy" that delays creating the
// expensive real object until it's actually needed.
public interface IImage
{
    void Display();
}

public class RealImage : IImage // expensive to create — simulates loading from disk
{
    private readonly string _filename;

    public RealImage(string filename)
    {
        _filename = filename;
        LoadFromDisk();
    }

    private void LoadFromDisk() => Console.WriteLine($"Loading {_filename} from disk...");

    public void Display() => Console.WriteLine($"Displaying {_filename}");
}

// The proxy: same interface as RealImage, but only creates the real
// object the first time Display() is actually called.
public class ImageProxy : IImage
{
    private readonly string _filename;
    private RealImage? _realImage;

    public ImageProxy(string filename) => _filename = filename;

    public void Display()
    {
        _realImage ??= new RealImage(_filename); // created lazily, on first use
        _realImage.Display();
    }
}

class Program
{
    static void Main()
    {
        IImage image = new ImageProxy("photo.png");

        Console.WriteLine("Image proxy created, nothing loaded yet");
        image.Display(); // loads from disk here
        image.Display(); // reuses the already-loaded RealImage
    }
}
