// Singleton: the class controls its own single instance.
// Constructor is private; the only way in is the static getInstance() method.
public class Logger {

    // Initialized at class-load time by the JVM, which is thread-safe by default.
    private static final Logger INSTANCE = new Logger();

    private int messageCount = 0;

    private Logger() { } // nobody outside this class can call `new Logger()`

    public static Logger getInstance() {
        return INSTANCE;
    }

    public void log(String message) {
        messageCount++;
        System.out.println("[" + messageCount + "] " + message);
    }

    public static void main(String[] args) {
        Logger.getInstance().log("App started");

        Logger sameLogger = Logger.getInstance();
        sameLogger.log("Second message, same instance");

        System.out.println(Logger.getInstance() == sameLogger
                ? "Same instance confirmed"
                : "BUG: different instances");
    }
}
