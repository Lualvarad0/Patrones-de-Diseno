// Mediator: users don't talk to each other directly — they only know
// the chat room, which decides who gets each message. Adding a new user
// never requires changing any existing user's code.
public class ChatRoom
{
    private readonly List<User> _users = new();

    public void Register(User user) => _users.Add(user);

    public void SendMessage(User sender, string message)
    {
        foreach (var user in _users)
        {
            if (user != sender) user.Receive(sender.Name, message);
        }
    }
}

public class User
{
    public string Name { get; }
    private readonly ChatRoom _chatRoom;

    public User(string name, ChatRoom chatRoom)
    {
        Name = name;
        _chatRoom = chatRoom;
        chatRoom.Register(this);
    }

    public void Send(string message) => _chatRoom.SendMessage(this, message);

    public void Receive(string from, string message) => Console.WriteLine($"{Name} received from {from}: {message}");
}

class Program
{
    static void Main()
    {
        var chatRoom = new ChatRoom();
        var alice = new User("Alice", chatRoom);
        var bob = new User("Bob", chatRoom);
        var carol = new User("Carol", chatRoom);

        alice.Send("Hey everyone!"); // Bob and Carol receive it, Alice doesn't
    }
}
