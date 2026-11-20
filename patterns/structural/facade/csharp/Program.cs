// Facade: hides a handful of fiddly subsystem classes behind one simple
// method. The subsystem classes still exist and can be used directly by
// whoever needs the detail — the facade is just a convenient shortcut.
public class Amplifier
{
    public void On() => Console.WriteLine("Amplifier on");
    public void SetVolume(int level) => Console.WriteLine($"Amplifier volume set to {level}");
    public void Off() => Console.WriteLine("Amplifier off");
}

public class DvdPlayer
{
    public void On() => Console.WriteLine("DVD player on");
    public void Play(string movie) => Console.WriteLine($"Playing \"{movie}\"");
    public void Off() => Console.WriteLine("DVD player off");
}

public class Projector
{
    public void On() => Console.WriteLine("Projector on");
    public void SetInput(string source) => Console.WriteLine($"Projector input set to {source}");
    public void Off() => Console.WriteLine("Projector off");
}

// The facade: one simple entry point that coordinates the subsystem.
public class HomeTheaterFacade
{
    private readonly Amplifier _amplifier = new();
    private readonly DvdPlayer _dvdPlayer = new();
    private readonly Projector _projector = new();

    public void WatchMovie(string movie)
    {
        _amplifier.On();
        _amplifier.SetVolume(7);
        _projector.On();
        _projector.SetInput("DVD");
        _dvdPlayer.On();
        _dvdPlayer.Play(movie);
    }

    public void EndMovie()
    {
        _dvdPlayer.Off();
        _projector.Off();
        _amplifier.Off();
    }
}

class Program
{
    static void Main()
    {
        var homeTheater = new HomeTheaterFacade();
        homeTheater.WatchMovie("The Matrix"); // one call instead of six
        homeTheater.EndMovie();
    }
}
