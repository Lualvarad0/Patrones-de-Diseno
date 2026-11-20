// Chain of Responsibility: each handler either resolves the request or
// passes it to the next handler in the chain — the caller only ever
// talks to the first handler and doesn't know how many others exist.
abstract class SupportHandler {
    private SupportHandler next;

    SupportHandler setNext(SupportHandler next) {
        this.next = next;
        return next; // lets callers chain setNext calls while building the chain
    }

    void handle(int severity) {
        if (canHandle(severity)) {
            resolve(severity);
        } else if (next != null) {
            next.handle(severity);
        } else {
            System.out.println("No handler could resolve severity " + severity);
        }
    }

    abstract boolean canHandle(int severity);
    abstract void resolve(int severity);
}

class Level1Support extends SupportHandler {
    boolean canHandle(int severity) { return severity <= 1; }
    void resolve(int severity) { System.out.println("Level1 resolved severity " + severity); }
}

class Level2Support extends SupportHandler {
    boolean canHandle(int severity) { return severity <= 2; }
    void resolve(int severity) { System.out.println("Level2 resolved severity " + severity); }
}

class Level3Support extends SupportHandler {
    boolean canHandle(int severity) { return severity <= 3; }
    void resolve(int severity) { System.out.println("Level3 resolved severity " + severity); }
}

public class ChainOfResponsibilityDemo {
    public static void main(String[] args) {
        Level1Support level1 = new Level1Support();
        Level2Support level2 = new Level2Support();
        Level3Support level3 = new Level3Support();
        level1.setNext(level2).setNext(level3); // build the chain: 1 -> 2 -> 3

        level1.handle(1); // resolved at level 1
        level1.handle(2); // escalates to level 2
        level1.handle(3); // escalates to level 3
        level1.handle(5); // nobody can handle it
    }
}
