// Flyweight: the heavy, repeated part of an object's state (intrinsic —
// here, the tree's sprite/model) is shared across many instances; the
// part that differs per instance (extrinsic — here, x/y position) is
// passed in from outside instead of stored in the shared object.
class TreeType {
  // the flyweight: shared, created once per distinct type
  constructor(name, sprite) {
    this.name = name;
    this.sprite = sprite;
  }

  draw(x, y) {
    console.log(`Drawing ${this.name} (${this.sprite}) at (${x},${y})`);
  }
}

// The factory: makes sure each distinct TreeType is created only once,
// no matter how many trees of that type end up in the forest.
class TreeFactory {
  #treeTypes = new Map();

  getTreeType(name, sprite) {
    if (!this.#treeTypes.has(name)) {
      this.#treeTypes.set(name, new TreeType(name, sprite));
      console.log(`Created new TreeType: ${name}`);
    }
    return this.#treeTypes.get(name);
  }
}

// Each Tree only stores its extrinsic state (position) plus a reference
// to the shared flyweight — not a full copy of the sprite data.
class Tree {
  constructor(x, y, type) {
    this.x = x;
    this.y = y;
    this.type = type;
  }

  draw() {
    this.type.draw(this.x, this.y);
  }
}

// --- demo ---
const factory = new TreeFactory();
const forest = [
  new Tree(1, 2, factory.getTreeType("Pine", "green-sprite")),
  new Tree(5, 7, factory.getTreeType("Pine", "green-sprite")), // reuses the same TreeType
  new Tree(3, 9, factory.getTreeType("Oak", "brown-sprite")),
];

for (const tree of forest) tree.draw();
