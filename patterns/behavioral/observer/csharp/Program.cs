// Observer: the subject keeps a list of observers and notifies all of
// them when its state changes, without knowing what each one does with
// that information.
public interface IObserver
{
    void Update(double temperature);
}

public class PhoneDisplay : IObserver
{
    public void Update(double temperature) => Console.WriteLine($"[Phone] Temperature is now {temperature}°C");
}

public class TvDisplay : IObserver
{
    public void Update(double temperature) => Console.WriteLine($"[TV] Temperature is now {temperature}°C");
}

// The "subject": holds the observers and pushes updates to all of them.
public class WeatherStation
{
    private readonly List<IObserver> _observers = new();

    public void Subscribe(IObserver observer) => _observers.Add(observer);
    public void Unsubscribe(IObserver observer) => _observers.Remove(observer);

    public void SetTemperature(double temperature)
    {
        foreach (var observer in _observers)
            observer.Update(temperature);
    }
}

class Program
{
    static void Main()
    {
        var station = new WeatherStation();
        var phone = new PhoneDisplay();
        var tv = new TvDisplay();

        station.Subscribe(phone);
        station.Subscribe(tv);

        station.SetTemperature(23.5); // both observers get notified

        station.Unsubscribe(tv);
        station.SetTemperature(24.0); // only phone gets notified now
    }
}
