// Singleton in Rust: idiomatic Rust rarely needs a classic "getInstance()"
// singleton — a `static` protected by `OnceLock` gives you a single,
// lazily-initialized instance, safely shared across threads, without
// the unsafe mutable global state languages normally default to here.
use std::sync::{Mutex, OnceLock};

struct Logger {
    message_count: Mutex<u32>,
}

impl Logger {
    fn new() -> Self {
        Logger { message_count: Mutex::new(0) }
    }

    fn instance() -> &'static Logger {
        static INSTANCE: OnceLock<Logger> = OnceLock::new();
        INSTANCE.get_or_init(Logger::new)
    }

    fn log(&self, message: &str) {
        let mut count = self.message_count.lock().unwrap();
        *count += 1;
        println!("[{}] {}", *count, message);
    }
}

fn main() {
    Logger::instance().log("App started");

    let same_logger = Logger::instance();
    same_logger.log("Second message, same instance");

    let same = std::ptr::eq(Logger::instance(), same_logger);
    println!("{}", if same { "Same instance confirmed" } else { "BUG: different instances" });
}
