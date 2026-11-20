<?php
// Iterator: exposes a way to walk through a collection's elements one by
// one (hasNext/next) without exposing whether it's backed by an array
// or anything else. PHP has its own `Iterator` interface used by
// `foreach` — this example builds the mechanism by hand first to show
// what's actually happening underneath, named differently from PHP's
// built-in interface to avoid confusion.
class BookCollection
{
    private array $books = [];

    public function add(string $title): void
    {
        $this->books[] = $title;
    }

    public function createIterator(): BookIterator
    {
        return new BookIterator($this->books);
    }
}

class BookIterator
{
    private int $position = 0;

    public function __construct(private array $books) {}

    public function hasNext(): bool
    {
        return $this->position < count($this->books);
    }

    public function next(): string
    {
        return $this->books[$this->position++];
    }
}

// --- demo ---
$collection = new BookCollection();
$collection->add("Clean Code");
$collection->add("The Pragmatic Programmer");
$collection->add("Design Patterns");

$iterator = $collection->createIterator();
while ($iterator->hasNext()) {
    echo $iterator->next() . "\n";
}
