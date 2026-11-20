<?php
// Mediator: users don't talk to each other directly — they only know
// the chat room, which decides who gets each message. Adding a new user
// never requires changing any existing user's code.
class ChatRoom
{
    /** @var User[] */
    private array $users = [];

    public function register(User $user): void
    {
        $this->users[] = $user;
    }

    public function sendMessage(User $sender, string $message): void
    {
        foreach ($this->users as $user) {
            if ($user !== $sender) {
                $user->receive($sender->getName(), $message);
            }
        }
    }
}

class User
{
    public function __construct(private string $name, private ChatRoom $chatRoom)
    {
        $chatRoom->register($this);
    }

    public function getName(): string { return $this->name; }

    public function send(string $message): void
    {
        $this->chatRoom->sendMessage($this, $message);
    }

    public function receive(string $from, string $message): void
    {
        echo "{$this->name} received from {$from}: {$message}\n";
    }
}

// --- demo ---
$chatRoom = new ChatRoom();
$alice = new User("Alice", $chatRoom);
$bob = new User("Bob", $chatRoom);
$carol = new User("Carol", $chatRoom);

$alice->send("Hey everyone!"); // Bob and Carol receive it, Alice doesn't
