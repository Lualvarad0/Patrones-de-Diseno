// Memento: the editor can save a snapshot of its own state and restore
// it later, without the history stack (Caretaker) ever looking inside
// the snapshot — it just stores and returns opaque Memento values.
struct EditorMemento { // the snapshot: immutable, opaque to everyone but the editor
    content: String,
}

struct TextEditor {
    content: String,
}

impl TextEditor {
    fn new() -> Self {
        TextEditor { content: String::new() }
    }

    fn type_text(&mut self, text: &str) {
        self.content.push_str(text);
    }

    fn save(&self) -> EditorMemento {
        EditorMemento { content: self.content.clone() }
    }

    fn restore(&mut self, memento: EditorMemento) {
        self.content = memento.content;
    }
}

// The "caretaker": keeps a history of snapshots, but never looks inside them.
struct History {
    snapshots: Vec<EditorMemento>,
}

impl History {
    fn new() -> Self {
        History { snapshots: Vec::new() }
    }

    fn push(&mut self, memento: EditorMemento) {
        self.snapshots.push(memento);
    }

    fn pop(&mut self) -> Option<EditorMemento> {
        self.snapshots.pop()
    }
}

fn main() {
    let mut editor = TextEditor::new();
    let mut history = History::new();

    editor.type_text("Hello");
    history.push(editor.save()); // checkpoint 1: "Hello"

    editor.type_text(", world!");
    history.push(editor.save()); // checkpoint 2: "Hello, world!"

    editor.type_text(" This part is a typo.");
    println!("Before undo: {}", editor.content);

    if let Some(memento) = history.pop() {
        editor.restore(memento); // undo back to checkpoint 2
    }
    println!("After undo: {}", editor.content);
}
