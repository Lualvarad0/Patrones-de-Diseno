<?php
// Memento: the editor can save a snapshot of its own state and restore
// it later, without the history stack (Caretaker) ever looking inside
// the snapshot — it just stores and returns opaque Memento objects.
class EditorMemento // the snapshot: immutable, opaque to everyone but the editor
{
    public function __construct(private string $content) {}
    public function getContent(): string { return $this->content; }
}

class TextEditor
{
    private string $content = "";

    public function type(string $text): void
    {
        $this->content .= $text;
    }

    public function getContent(): string
    {
        return $this->content;
    }

    public function save(): EditorMemento
    {
        return new EditorMemento($this->content);
    }

    public function restore(EditorMemento $memento): void
    {
        $this->content = $memento->getContent();
    }
}

// The "caretaker": keeps a history of snapshots, but never looks inside them.
class History
{
    /** @var EditorMemento[] */
    private array $snapshots = [];

    public function push(EditorMemento $memento): void
    {
        $this->snapshots[] = $memento;
    }

    public function pop(): EditorMemento
    {
        return array_pop($this->snapshots);
    }
}

// --- demo ---
$editor = new TextEditor();
$history = new History();

$editor->type("Hello");
$history->push($editor->save()); // checkpoint 1: "Hello"

$editor->type(", world!");
$history->push($editor->save()); // checkpoint 2: "Hello, world!"

$editor->type(" This part is a typo.");
echo "Before undo: " . $editor->getContent() . "\n";

$editor->restore($history->pop()); // undo back to checkpoint 2
echo "After undo: " . $editor->getContent() . "\n";
