import java.util.ArrayDeque;
import java.util.Deque;

// Command: wraps an action as an object with a common interface
// (execute/undo), so it can be stored, queued, or undone without the
// caller knowing what it actually does.
interface Command {
    void execute();
    void undo();
}

// The "receiver": the thing commands actually act on.
class Light {
    void turnOn() { System.out.println("Light is ON"); }
    void turnOff() { System.out.println("Light is OFF"); }
}

class TurnOnCommand implements Command {
    private final Light light;
    TurnOnCommand(Light light) { this.light = light; }
    public void execute() { light.turnOn(); }
    public void undo() { light.turnOff(); }
}

class TurnOffCommand implements Command {
    private final Light light;
    TurnOffCommand(Light light) { this.light = light; }
    public void execute() { light.turnOff(); }
    public void undo() { light.turnOn(); }
}

// The "invoker": knows how to run a command and keeps history for undo,
// without knowing what each command actually does.
class RemoteControl {
    private final Deque<Command> history = new ArrayDeque<>();

    void submit(Command command) {
        command.execute();
        history.push(command);
    }

    void undoLast() {
        if (!history.isEmpty()) history.pop().undo();
    }
}

public class CommandDemo {
    public static void main(String[] args) {
        Light light = new Light();
        RemoteControl remote = new RemoteControl();

        remote.submit(new TurnOnCommand(light));
        remote.submit(new TurnOffCommand(light));
        remote.undoLast(); // undoes TurnOffCommand -> light turns back on
    }
}
