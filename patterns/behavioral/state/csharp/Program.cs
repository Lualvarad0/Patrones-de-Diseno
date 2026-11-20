// State: a traffic light behaves differently depending on its current
// state, and each state decides what the NEXT state is — the light
// itself just delegates to whichever state object it currently holds.
public interface ITrafficLightState
{
    void Next(TrafficLight light);
    string Name { get; }
}

public class RedState : ITrafficLightState
{
    public string Name => "Red";
    public void Next(TrafficLight light) => light.SetState(new GreenState());
}

public class GreenState : ITrafficLightState
{
    public string Name => "Green";
    public void Next(TrafficLight light) => light.SetState(new YellowState());
}

public class YellowState : ITrafficLightState
{
    public string Name => "Yellow";
    public void Next(TrafficLight light) => light.SetState(new RedState());
}

// The "context": holds the current state and delegates to it, without a
// big switch statement anywhere checking which state it's in.
public class TrafficLight
{
    private ITrafficLightState _state = new RedState();

    public void SetState(ITrafficLightState state) => _state = state;

    public void Change()
    {
        _state.Next(this);
        Console.WriteLine($"Light is now {_state.Name}");
    }
}

class Program
{
    static void Main()
    {
        var light = new TrafficLight();
        light.Change(); // Red -> Green
        light.Change(); // Green -> Yellow
        light.Change(); // Yellow -> Red
    }
}
