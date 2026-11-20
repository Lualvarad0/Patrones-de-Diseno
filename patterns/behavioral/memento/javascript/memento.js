// Memento: the editor can save a snapshot of its own state and restore
// it later, without the history stack (Caretaker) ever looking inside
// the snapshot — it just stores and returns opaque Memento objects.
class EditorMemento {
  // the snapshot: immutable, opaque to everyone but the editor
  #content;
  constructor(content) {
    this.#content = content;
  }
  getContent() {
    return this.#content;
  }
}

class TextEditor {
  #content = "";

  type(text) {
    this.#content += text;
  }

  getContent() {
    return this.#content;
  }

  save() {
    return new EditorMemento(this.#content);
  }

  restore(memento) {
    this.#content = memento.getContent();
  }
}

// The "caretaker": keeps a history of snapshots, but never looks inside them.
class History {
  #snapshots = [];

  push(memento) {
    this.#snapshots.push(memento);
  }

  pop() {
    return this.#snapshots.pop();
  }
}

// --- demo ---
const editor = new TextEditor();
const history = new History();

editor.type("Hello");
history.push(editor.save()); // checkpoint 1: "Hello"

editor.type(", world!");
history.push(editor.save()); // checkpoint 2: "Hello, world!"

editor.type(" This part is a typo.");
console.log(`Before undo: ${editor.getContent()}`);

editor.restore(history.pop()); // undo back to checkpoint 2
console.log(`After undo: ${editor.getContent()}`);
