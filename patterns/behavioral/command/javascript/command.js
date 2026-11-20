// Command: wraps an action as an object with a common interface
// (execute/undo), so it can be stored, queued, or undone without the
// caller knowing what it actually does.

// The "receiver": the thing commands actually act on.
class Light {
  turnOn() {
    console.log("Light is ON");
  }
  turnOff() {
    console.log("Light is OFF");
  }
}

class TurnOnCommand {
  constructor(light) {
    this.light = light;
  }
  execute() {
    this.light.turnOn();
  }
  undo() {
    this.light.turnOff();
  }
}

class TurnOffCommand {
  constructor(light) {
    this.light = light;
  }
  execute() {
    this.light.turnOff();
  }
  undo() {
    this.light.turnOn();
  }
}

// The "invoker": knows how to run a command and keeps history for undo,
// without knowing what each command actually does.
class RemoteControl {
  #history = [];

  submit(command) {
    command.execute();
    this.#history.push(command);
  }

  undoLast() {
    const command = this.#history.pop();
    if (command) command.undo();
  }
}

// --- demo ---
const light = new Light();
const remote = new RemoteControl();

remote.submit(new TurnOnCommand(light));
remote.submit(new TurnOffCommand(light));
remote.undoLast(); // undoes TurnOffCommand -> light turns back on
