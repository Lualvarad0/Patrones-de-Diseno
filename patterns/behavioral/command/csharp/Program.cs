// Command: wraps an action as an object with a common interface
// (Execute/Undo), so it can be stored, queued, or undone without the
// caller knowing what it actually does.
public interface ICommand
{
    void Execute();
    void Undo();
}

// The "receiver": the thing commands actually act on.
public class Light
{
    public bool IsOn { get; private set; }
    public void TurnOn() { IsOn = true; Console.WriteLine("Light is ON"); }
    public void TurnOff() { IsOn = false; Console.WriteLine("Light is OFF"); }
}

public class TurnOnCommand : ICommand
{
    private readonly Light _light;
    public TurnOnCommand(Light light) => _light = light;
    public void Execute() => _light.TurnOn();
    public void Undo() => _light.TurnOff();
}

public class TurnOffCommand : ICommand
{
    private readonly Light _light;
    public TurnOffCommand(Light light) => _light = light;
    public void Execute() => _light.TurnOff();
    public void Undo() => _light.TurnOn();
}

// The "invoker": knows how to run a command and keeps history for undo,
// without knowing what each command actually does.
public class RemoteControl
{
    private readonly Stack<ICommand> _history = new();

    public void Submit(ICommand command)
    {
        command.Execute();
        _history.Push(command);
    }

    public void UndoLast()
    {
        if (_history.Count > 0) _history.Pop().Undo();
    }
}

class Program
{
    static void Main()
    {
        var light = new Light();
        var remote = new RemoteControl();

        remote.Submit(new TurnOnCommand(light));
        remote.Submit(new TurnOffCommand(light));
        remote.UndoLast(); // undoes TurnOffCommand -> light turns back on
    }
}
