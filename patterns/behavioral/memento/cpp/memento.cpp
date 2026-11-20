// Memento: the editor can save a snapshot of its own state and restore
// it later, without the history stack (Caretaker) ever looking inside
// the snapshot — it just stores and returns opaque Memento objects.
#include <iostream>
#include <stack>
#include <string>

class EditorMemento { // the snapshot: immutable, opaque to everyone but the editor
public:
    explicit EditorMemento(std::string content) : content(std::move(content)) {}
    const std::string& getContent() const { return content; }
private:
    std::string content;
};

class TextEditor {
public:
    void type(const std::string& text) { content += text; }

    const std::string& getContent() const { return content; }

    EditorMemento save() const { return EditorMemento(content); }

    void restore(const EditorMemento& memento) { content = memento.getContent(); }

private:
    std::string content;
};

// The "caretaker": keeps a history of snapshots, but never looks inside them.
class History {
public:
    void push(const EditorMemento& memento) { snapshots.push(memento); }

    EditorMemento pop() {
        EditorMemento top = snapshots.top();
        snapshots.pop();
        return top;
    }

private:
    std::stack<EditorMemento> snapshots;
};

int main() {
    TextEditor editor;
    History history;

    editor.type("Hello");
    history.push(editor.save()); // checkpoint 1: "Hello"

    editor.type(", world!");
    history.push(editor.save()); // checkpoint 2: "Hello, world!"

    editor.type(" This part is a typo.");
    std::cout << "Before undo: " << editor.getContent() << std::endl;

    editor.restore(history.pop()); // undo back to checkpoint 2
    std::cout << "After undo: " << editor.getContent() << std::endl;

    return 0;
}
