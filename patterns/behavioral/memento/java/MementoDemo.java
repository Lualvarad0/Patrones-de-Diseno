import java.util.ArrayDeque;
import java.util.Deque;

// Memento: the editor can save a snapshot of its own state and restore
// it later, without the history stack (Caretaker) ever looking inside
// the snapshot — it just stores and returns opaque Memento objects.
class EditorMemento { // the snapshot: immutable, opaque to everyone but the editor
    private final String content;
    EditorMemento(String content) { this.content = content; }
    String getContent() { return content; }
}

class TextEditor {
    private String content = "";

    void type(String text) { content += text; }

    String getContent() { return content; }

    EditorMemento save() { return new EditorMemento(content); }

    void restore(EditorMemento memento) { content = memento.getContent(); }
}

// The "caretaker": keeps a history of snapshots, but never looks inside them.
class History {
    private final Deque<EditorMemento> snapshots = new ArrayDeque<>();

    void push(EditorMemento memento) { snapshots.push(memento); }

    EditorMemento pop() { return snapshots.pop(); }
}

public class MementoDemo {
    public static void main(String[] args) {
        TextEditor editor = new TextEditor();
        History history = new History();

        editor.type("Hello");
        history.push(editor.save()); // checkpoint 1: "Hello"

        editor.type(", world!");
        history.push(editor.save()); // checkpoint 2: "Hello, world!"

        editor.type(" This part is a typo.");
        System.out.println("Before undo: " + editor.getContent());

        editor.restore(history.pop()); // undo back to checkpoint 2
        System.out.println("After undo: " + editor.getContent());
    }
}
