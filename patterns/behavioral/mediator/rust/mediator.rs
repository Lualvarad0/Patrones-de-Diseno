// Mediator: users don't talk to each other directly — they only know
// the chat room, which decides who gets each message. Adding a new user
// never requires changing any existing user's code.
//
// Rust's ownership rules make a two-way reference (user -> chat room and
// chat room -> user) awkward, so here the chat room owns every `User`
// and messages are sent by calling `chat_room.send_message(name, ...)`
// directly — arguably an even purer mediator, since users end up with
// no reference to the mediator at all.
struct User {
    name: String,
}

impl User {
    fn receive(&self, from: &str, message: &str) {
        println!("{} received from {}: {}", self.name, from, message);
    }
}

struct ChatRoom {
    users: Vec<User>,
}

impl ChatRoom {
    fn new() -> Self {
        ChatRoom { users: Vec::new() }
    }

    fn register(&mut self, name: &str) {
        self.users.push(User { name: name.to_string() });
    }

    fn send_message(&self, sender_name: &str, message: &str) {
        for user in &self.users {
            if user.name != sender_name {
                user.receive(sender_name, message);
            }
        }
    }
}

fn main() {
    let mut chat_room = ChatRoom::new();
    chat_room.register("Alice");
    chat_room.register("Bob");
    chat_room.register("Carol");

    chat_room.send_message("Alice", "Hey everyone!"); // Bob and Carol receive it, Alice doesn't
}
