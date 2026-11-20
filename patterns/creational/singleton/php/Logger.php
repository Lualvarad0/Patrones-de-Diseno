<?php
// Singleton: the class controls its own single instance.
// Constructor is private; the only way in is the static getInstance() method.
final class Logger
{
    private static ?Logger $instance = null;

    private int $messageCount = 0;

    private function __construct() {} // nobody outside this class can call `new Logger()`
    private function __clone() {}     // and nobody can clone it either

    public static function getInstance(): Logger
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    public function log(string $message): void
    {
        $this->messageCount++;
        echo "[{$this->messageCount}] {$message}\n";
    }
}

// --- demo ---
Logger::getInstance()->log("App started");

$sameLogger = Logger::getInstance();
$sameLogger->log("Second message, same instance");

echo (Logger::getInstance() === $sameLogger)
    ? "Same instance confirmed\n"
    : "BUG: different instances\n";
