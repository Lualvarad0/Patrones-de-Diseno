<?php
// Flyweight: the heavy, repeated part of an object's state (intrinsic —
// here, the tree's sprite/model) is shared across many instances; the
// part that differs per instance (extrinsic — here, x/y position) is
// passed in from outside instead of stored in the shared object.
class TreeType // the flyweight: shared, created once per distinct type
{
    public function __construct(private string $name, private string $sprite) {}

    public function draw(int $x, int $y): void
    {
        echo "Drawing {$this->name} ({$this->sprite}) at ({$x},{$y})\n";
    }
}

// The factory: makes sure each distinct TreeType is created only once,
// no matter how many trees of that type end up in the forest.
class TreeFactory
{
    /** @var array<string, TreeType> */
    private array $treeTypes = [];

    public function getTreeType(string $name, string $sprite): TreeType
    {
        if (!isset($this->treeTypes[$name])) {
            $this->treeTypes[$name] = new TreeType($name, $sprite);
            echo "Created new TreeType: {$name}\n";
        }
        return $this->treeTypes[$name];
    }
}

// Each Tree only stores its extrinsic state (position) plus a reference
// to the shared flyweight — not a full copy of the sprite data.
class Tree
{
    public function __construct(private int $x, private int $y, private TreeType $type) {}

    public function draw(): void
    {
        $this->type->draw($this->x, $this->y);
    }
}

// --- demo ---
$factory = new TreeFactory();
$forest = [
    new Tree(1, 2, $factory->getTreeType("Pine", "green-sprite")),
    new Tree(5, 7, $factory->getTreeType("Pine", "green-sprite")), // reuses the same TreeType
    new Tree(3, 9, $factory->getTreeType("Oak", "brown-sprite")),
];

foreach ($forest as $tree) {
    $tree->draw();
}
