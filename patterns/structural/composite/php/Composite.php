<?php
// Composite: files (leaves) and folders (containers) implement the same
// interface, so the client can call getSize() on either one without
// asking "is this a leaf or a folder?" first.
interface FileSystemItem
{
    public function getSize(): int;
    public function print(string $indent = ""): void;
}

class FileItem implements FileSystemItem
{
    public function __construct(private string $name, private int $size) {}

    public function getSize(): int { return $this->size; }

    public function print(string $indent = ""): void
    {
        echo "{$indent}{$this->name} ({$this->size}KB)\n";
    }
}

class Folder implements FileSystemItem
{
    /** @var FileSystemItem[] */
    private array $children = [];

    public function __construct(private string $name) {}

    public function add(FileSystemItem $item): void
    {
        $this->children[] = $item;
    }

    // Delegates to each child and sums the results — doesn't matter if a
    // child is a FileItem or another Folder, the recursion just happens.
    public function getSize(): int
    {
        return array_sum(array_map(fn($child) => $child->getSize(), $this->children));
    }

    public function print(string $indent = ""): void
    {
        echo "{$indent}{$this->name}/ ({$this->getSize()}KB)\n";
        foreach ($this->children as $child) {
            $child->print($indent . "  ");
        }
    }
}

// --- demo ---
$root = new Folder("project");
$root->add(new FileItem("README.md", 2));

$src = new Folder("src");
$src->add(new FileItem("index.php", 5));
$src->add(new FileItem("Utils.php", 3));
$root->add($src);

$root->print(); // the client only ever calls print()/getSize(), leaf or folder
