// Chain of Responsibility: each handler either resolves the request or
// passes it to the next handler in the chain — the caller only ever
// talks to the first handler and doesn't know how many others exist.
public abstract class SupportHandler
{
    private SupportHandler? _next;

    public SupportHandler SetNext(SupportHandler next)
    {
        _next = next;
        return next; // lets callers chain SetNext calls while building the chain
    }

    public void Handle(int severity)
    {
        if (CanHandle(severity))
        {
            Resolve(severity);
        }
        else if (_next != null)
        {
            _next.Handle(severity);
        }
        else
        {
            Console.WriteLine($"No handler could resolve severity {severity}");
        }
    }

    protected abstract bool CanHandle(int severity);
    protected abstract void Resolve(int severity);
}

public class Level1Support : SupportHandler
{
    protected override bool CanHandle(int severity) => severity <= 1;
    protected override void Resolve(int severity) => Console.WriteLine($"Level1 resolved severity {severity}");
}

public class Level2Support : SupportHandler
{
    protected override bool CanHandle(int severity) => severity <= 2;
    protected override void Resolve(int severity) => Console.WriteLine($"Level2 resolved severity {severity}");
}

public class Level3Support : SupportHandler
{
    protected override bool CanHandle(int severity) => severity <= 3;
    protected override void Resolve(int severity) => Console.WriteLine($"Level3 resolved severity {severity}");
}

class Program
{
    static void Main()
    {
        var level1 = new Level1Support();
        var level2 = new Level2Support();
        var level3 = new Level3Support();
        level1.SetNext(level2).SetNext(level3); // build the chain: 1 -> 2 -> 3

        level1.Handle(1); // resolved at level 1
        level1.Handle(2); // escalates to level 2
        level1.Handle(3); // escalates to level 3
        level1.Handle(5); // nobody can handle it
    }
}
