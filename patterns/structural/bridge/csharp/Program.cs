// Bridge: splits "remote control" (the abstraction) from "device" (the
// implementation) into two independent hierarchies joined by composition,
// so each one can grow on its own without a subclass explosion.
public interface IDevice
{
    bool IsOn { get; }
    void TurnOn();
    void TurnOff();
    string Name { get; }
}

public class Tv : IDevice
{
    public bool IsOn { get; private set; }
    public string Name => "TV";
    public void TurnOn() => IsOn = true;
    public void TurnOff() => IsOn = false;
}

public class Radio : IDevice
{
    public bool IsOn { get; private set; }
    public string Name => "Radio";
    public void TurnOn() => IsOn = true;
    public void TurnOff() => IsOn = false;
}

// The abstraction: holds a reference to a device and delegates to it,
// without caring which concrete device it is.
public class RemoteControl
{
    protected readonly IDevice Device;
    public RemoteControl(IDevice device) => Device = device;

    public void TogglePower()
    {
        if (Device.IsOn) Device.TurnOff(); else Device.TurnOn();
        Console.WriteLine($"{Device.Name} is now {(Device.IsOn ? "ON" : "OFF")}");
    }
}

// A second abstraction growing independently of the device hierarchy.
public class AdvancedRemoteControl : RemoteControl
{
    public AdvancedRemoteControl(IDevice device) : base(device) { }

    public void Mute()
    {
        if (Device.IsOn) Console.WriteLine($"{Device.Name} muted");
    }
}

class Program
{
    static void Main()
    {
        var tvRemote = new RemoteControl(new Tv());
        tvRemote.TogglePower();

        var radioRemote = new AdvancedRemoteControl(new Radio());
        radioRemote.TogglePower();
        radioRemote.Mute();
    }
}
