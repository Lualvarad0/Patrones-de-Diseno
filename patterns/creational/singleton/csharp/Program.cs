// Singleton: the class controls its own single instance.
// Constructor is private; the only way in is the static Instance property.
public sealed class Logger
{
    // Lazy<T> makes this thread-safe without manual locking.
    private static readonly Lazy<Logger> _instance = new(() => new Logger());

    public static Logger Instance => _instance.Value;

    private int _messageCount = 0;

    private Logger() { } // nobody outside this class can call `new Logger()`

    public void Log(string message)
    {
        _messageCount++;
        Console.WriteLine($"[{_messageCount}] {message}");
    }
}

class Program
{
    static void Main()
    {
        Logger.Instance.Log("App started");

        var sameLogger = Logger.Instance;
        sameLogger.Log("Second message, same instance");

        Console.WriteLine(ReferenceEquals(Logger.Instance, sameLogger)
            ? "Same instance confirmed"
            : "BUG: different instances");
    }
}
