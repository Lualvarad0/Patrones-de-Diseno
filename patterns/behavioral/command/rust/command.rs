// Command: wraps an action as an object with a common interface
// (execute/undo), so it can be stored, queued, or undone without the
// caller knowing what it actually does.
use std::rc::Rc;

// The "receiver": the thing commands actually act on. Wrapped in `Rc` so
// multiple command objects can share the same Light.
struct Light;
impl Light {
    fn turn_on(&self) { println!("Light is ON"); }
    fn turn_off(&self) { println!("Light is OFF"); }
}

trait Command {
    fn execute(&self);
    fn undo(&self);
}

struct TurnOnCommand { light: Rc<Light> }
impl Command for TurnOnCommand {
    fn execute(&self) { self.light.turn_on(); }
    fn undo(&self) { self.light.turn_off(); }
}

struct TurnOffCommand { light: Rc<Light> }
impl Command for TurnOffCommand {
    fn execute(&self) { self.light.turn_off(); }
    fn undo(&self) { self.light.turn_on(); }
}

// The "invoker": knows how to run a command and keeps history for undo,
// without knowing what each command actually does.
struct RemoteControl {
    history: Vec<Box<dyn Command>>,
}

impl RemoteControl {
    fn new() -> Self {
        RemoteControl { history: Vec::new() }
    }

    fn submit(&mut self, command: Box<dyn Command>) {
        command.execute();
        self.history.push(command);
    }

    fn undo_last(&mut self) {
        if let Some(command) = self.history.pop() {
            command.undo();
        }
    }
}

fn main() {
    let light = Rc::new(Light);
    let mut remote = RemoteControl::new();

    remote.submit(Box::new(TurnOnCommand { light: Rc::clone(&light) }));
    remote.submit(Box::new(TurnOffCommand { light: Rc::clone(&light) }));
    remote.undo_last(); // undoes TurnOffCommand -> light turns back on
}
