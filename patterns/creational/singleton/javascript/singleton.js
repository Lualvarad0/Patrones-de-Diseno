// Singleton: the module itself IS the single instance (the cleanest way to
// do this in JS/Node) — no class-based trickery needed, since a module is
// only evaluated once and then cached by the module loader.

class Logger {
  #messageCount = 0; // private field, not accessible from outside

  log(message) {
    this.#messageCount++;
    console.log(`[${this.#messageCount}] ${message}`);
  }
}

// Exporting a single already-created instance is what makes this a singleton:
// every file that `require`/`import`s this module gets the SAME object.
const instance = new Logger();
module.exports = instance;

// --- demo ---
if (require.main === module) {
  const logger1 = require("./singleton");
  const logger2 = require("./singleton");

  logger1.log("App started");
  logger2.log("Second message, same instance");

  console.log(
    logger1 === logger2 ? "Same instance confirmed" : "BUG: different instances"
  );
}
