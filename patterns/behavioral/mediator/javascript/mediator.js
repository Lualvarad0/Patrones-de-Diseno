// Mediator: users don't talk to each other directly — they only know
// the chat room, which decides who gets each message. Adding a new user
// never requires changing any existing user's code.
class ChatRoom {
  #users = [];

  register(user) {
    this.#users.push(user);
  }

  sendMessage(sender, message) {
    for (const user of this.#users) {
      if (user !== sender) user.receive(sender.name, message);
    }
  }
}

class User {
  constructor(name, chatRoom) {
    this.name = name;
    this.chatRoom = chatRoom;
    chatRoom.register(this);
  }

  send(message) {
    this.chatRoom.sendMessage(this, message);
  }

  receive(from, message) {
    console.log(`${this.name} received from ${from}: ${message}`);
  }
}

// --- demo ---
const chatRoom = new ChatRoom();
const alice = new User("Alice", chatRoom);
const bob = new User("Bob", chatRoom);
const carol = new User("Carol", chatRoom);

alice.send("Hey everyone!"); // Bob and Carol receive it, Alice doesn't
