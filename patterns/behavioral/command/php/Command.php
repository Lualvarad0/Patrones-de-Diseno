<?php
// Command: wraps an action as an object with a common interface
// (execute/undo), so it can be stored, queued, or undone without the
// caller knowing what it actually does.

// The "receiver": the thing commands actually act on.
class Light
{
    public function turnOn(): void { echo "Light is ON\n"; }
    public function turnOff(): void { echo "Light is OFF\n"; }
}

interface Command
{
    public function execute(): void;
    public function undo(): void;
}

class TurnOnCommand implements Command
{
    public function __construct(private Light $light) {}
    public function execute(): void { $this->light->turnOn(); }
    public function undo(): void { $this->light->turnOff(); }
}

class TurnOffCommand implements Command
{
    public function __construct(private Light $light) {}
    public function execute(): void { $this->light->turnOff(); }
    public function undo(): void { $this->light->turnOn(); }
}

// The "invoker": knows how to run a command and keeps history for undo,
// without knowing what each command actually does.
class RemoteControl
{
    /** @var Command[] */
    private array $history = [];

    public function submit(Command $command): void
    {
        $command->execute();
        $this->history[] = $command;
    }

    public function undoLast(): void
    {
        $command = array_pop($this->history);
        if ($command !== null) {
            $command->undo();
        }
    }
}

// --- demo ---
$light = new Light();
$remote = new RemoteControl();

$remote->submit(new TurnOnCommand($light));
$remote->submit(new TurnOffCommand($light));
$remote->undoLast(); // undoes TurnOffCommand -> light turns back on
