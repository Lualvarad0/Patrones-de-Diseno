// Chain of Responsibility: each handler either resolves the request or
// passes it to the next handler in the chain — the caller only ever
// talks to the first handler and doesn't know how many others exist.
// Rust builds the chain "inside out" (innermost/last handler first) so
// ownership of each `next` link is clear from construction, rather than
// mutating a `next` pointer after the fact.
trait Handler {
    fn can_handle(&self, severity: u8) -> bool;
    fn resolve(&self, severity: u8);
    fn next(&self) -> Option<&dyn Handler>;

    fn handle(&self, severity: u8) {
        if self.can_handle(severity) {
            self.resolve(severity);
        } else if let Some(next) = self.next() {
            next.handle(severity);
        } else {
            println!("No handler could resolve severity {severity}");
        }
    }
}

struct Level1Support { next: Option<Box<dyn Handler>> }
impl Handler for Level1Support {
    fn can_handle(&self, severity: u8) -> bool { severity <= 1 }
    fn resolve(&self, severity: u8) { println!("Level1 resolved severity {severity}"); }
    fn next(&self) -> Option<&dyn Handler> { self.next.as_deref() }
}

struct Level2Support { next: Option<Box<dyn Handler>> }
impl Handler for Level2Support {
    fn can_handle(&self, severity: u8) -> bool { severity <= 2 }
    fn resolve(&self, severity: u8) { println!("Level2 resolved severity {severity}"); }
    fn next(&self) -> Option<&dyn Handler> { self.next.as_deref() }
}

struct Level3Support { next: Option<Box<dyn Handler>> }
impl Handler for Level3Support {
    fn can_handle(&self, severity: u8) -> bool { severity <= 3 }
    fn resolve(&self, severity: u8) { println!("Level3 resolved severity {severity}"); }
    fn next(&self) -> Option<&dyn Handler> { self.next.as_deref() }
}

fn main() {
    // build the chain: 1 -> 2 -> 3, starting from the tail
    let level3 = Level3Support { next: None };
    let level2 = Level2Support { next: Some(Box::new(level3)) };
    let level1 = Level1Support { next: Some(Box::new(level2)) };

    level1.handle(1); // resolved at level 1
    level1.handle(2); // escalates to level 2
    level1.handle(3); // escalates to level 3
    level1.handle(5); // nobody can handle it
}
