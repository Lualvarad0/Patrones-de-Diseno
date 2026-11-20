// Mediator: users don't talk to each other directly — they only know
// the chat room, which decides who gets each message. Adding a new user
// never requires changing any existing user's code.
#include <iostream>
#include <string>
#include <vector>

class ChatRoom;

class User {
public:
    User(std::string name, ChatRoom& chatRoom);

    const std::string& getName() const { return name; }

    void send(const std::string& message);

    void receive(const std::string& from, const std::string& message) const {
        std::cout << name << " received from " << from << ": " << message << std::endl;
    }

private:
    std::string name;
    ChatRoom& chatRoom;
};

class ChatRoom {
public:
    void registerUser(User* user) { users.push_back(user); }

    void sendMessage(const User* sender, const std::string& message) {
        for (auto* user : users) {
            if (user != sender) user->receive(sender->getName(), message);
        }
    }

private:
    std::vector<User*> users;
};

User::User(std::string name, ChatRoom& chatRoom) : name(std::move(name)), chatRoom(chatRoom) {
    chatRoom.registerUser(this);
}

void User::send(const std::string& message) {
    chatRoom.sendMessage(this, message);
}

int main() {
    ChatRoom chatRoom;
    User alice("Alice", chatRoom);
    User bob("Bob", chatRoom);
    User carol("Carol", chatRoom);

    alice.send("Hey everyone!"); // Bob and Carol receive it, Alice doesn't

    return 0;
}
