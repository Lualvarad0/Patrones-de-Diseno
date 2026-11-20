import java.util.ArrayList;
import java.util.List;

// Mediator: users don't talk to each other directly — they only know
// the chat room, which decides who gets each message. Adding a new user
// never requires changing any existing user's code.
class ChatRoom {
    private final List<User> users = new ArrayList<>();

    void register(User user) { users.add(user); }

    void sendMessage(User sender, String message) {
        for (User user : users) {
            if (user != sender) user.receive(sender.getName(), message);
        }
    }
}

class User {
    private final String name;
    private final ChatRoom chatRoom;

    User(String name, ChatRoom chatRoom) {
        this.name = name;
        this.chatRoom = chatRoom;
        chatRoom.register(this);
    }

    String getName() { return name; }

    void send(String message) { chatRoom.sendMessage(this, message); }

    void receive(String from, String message) {
        System.out.println(name + " received from " + from + ": " + message);
    }
}

public class MediatorDemo {
    public static void main(String[] args) {
        ChatRoom chatRoom = new ChatRoom();
        User alice = new User("Alice", chatRoom);
        User bob = new User("Bob", chatRoom);
        User carol = new User("Carol", chatRoom);

        alice.send("Hey everyone!"); // Bob and Carol receive it, Alice doesn't
    }
}
