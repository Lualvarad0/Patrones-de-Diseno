// Singleton: the class controls its own single instance.
// A function-local `static` is initialized exactly once, lazily, and the C++11+
// standard guarantees this initialization is thread-safe.
#include <iostream>

class Logger {
public:
    static Logger& instance() {
        static Logger instance; // created on first call, reused after that
        return instance;
    }

    void log(const std::string& message) {
        messageCount++;
        std::cout << "[" << messageCount << "] " << message << std::endl;
    }

    // Explicitly forbid copying/assigning, otherwise someone could
    // duplicate the "single" instance by accident.
    Logger(const Logger&) = delete;
    Logger& operator=(const Logger&) = delete;

private:
    Logger() = default; // nobody outside this class can construct it
    int messageCount = 0;
};

int main() {
    Logger::instance().log("App started");

    Logger& sameLogger = Logger::instance();
    sameLogger.log("Second message, same instance");

    std::cout << (&Logger::instance() == &sameLogger
        ? "Same instance confirmed"
        : "BUG: different instances") << std::endl;

    return 0;
}
