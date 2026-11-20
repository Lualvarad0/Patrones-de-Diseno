// Command: wraps an action as an object with a common interface
// (execute/undo), so it can be stored, queued, or undone without the
// caller knowing what it actually does.
#include <iostream>
#include <memory>
#include <vector>

// The "receiver": the thing commands actually act on.
class Light {
public:
    void turnOn() { std::cout << "Light is ON" << std::endl; }
    void turnOff() { std::cout << "Light is OFF" << std::endl; }
};

class Command {
public:
    virtual void execute() = 0;
    virtual void undo() = 0;
    virtual ~Command() = default;
};

class TurnOnCommand : public Command {
public:
    explicit TurnOnCommand(Light& light) : light(light) {}
    void execute() override { light.turnOn(); }
    void undo() override { light.turnOff(); }
private:
    Light& light;
};

class TurnOffCommand : public Command {
public:
    explicit TurnOffCommand(Light& light) : light(light) {}
    void execute() override { light.turnOff(); }
    void undo() override { light.turnOn(); }
private:
    Light& light;
};

// The "invoker": knows how to run a command and keeps history for undo,
// without knowing what each command actually does.
class RemoteControl {
public:
    void submit(std::unique_ptr<Command> command) {
        command->execute();
        history.push_back(std::move(command));
    }

    void undoLast() {
        if (!history.empty()) {
            history.back()->undo();
            history.pop_back();
        }
    }

private:
    std::vector<std::unique_ptr<Command>> history;
};

int main() {
    Light light;
    RemoteControl remote;

    remote.submit(std::make_unique<TurnOnCommand>(light));
    remote.submit(std::make_unique<TurnOffCommand>(light));
    remote.undoLast(); // undoes TurnOffCommand -> light turns back on

    return 0;
}
