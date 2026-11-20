// Flyweight: the heavy, repeated part of an object's state (intrinsic —
// here, the tree's sprite/model) is shared across many instances via
// `Rc`; the part that differs per instance (extrinsic — x/y position) is
// passed in from outside instead of stored in the shared object.
use std::collections::HashMap;
use std::rc::Rc;

struct TreeType { // the flyweight: shared, created once per distinct type
    name: String,
    sprite: String,
}

impl TreeType {
    fn draw(&self, x: i32, y: i32) {
        println!("Drawing {} ({}) at ({x},{y})", self.name, self.sprite);
    }
}

// The factory: makes sure each distinct TreeType is created only once,
// no matter how many trees of that type end up in the forest.
struct TreeFactory {
    tree_types: HashMap<String, Rc<TreeType>>,
}

impl TreeFactory {
    fn new() -> Self {
        TreeFactory { tree_types: HashMap::new() }
    }

    fn get_tree_type(&mut self, name: &str, sprite: &str) -> Rc<TreeType> {
        if let Some(existing) = self.tree_types.get(name) {
            return Rc::clone(existing); // bumps the refcount, no new TreeType
        }
        let tree_type = Rc::new(TreeType { name: name.to_string(), sprite: sprite.to_string() });
        println!("Created new TreeType: {name}");
        self.tree_types.insert(name.to_string(), Rc::clone(&tree_type));
        tree_type
    }
}

// Each Tree only stores its extrinsic state (position) plus a shared
// reference to the flyweight — not a full copy of the sprite data.
struct Tree {
    x: i32,
    y: i32,
    tree_type: Rc<TreeType>,
}

impl Tree {
    fn draw(&self) {
        self.tree_type.draw(self.x, self.y);
    }
}

fn main() {
    let mut factory = TreeFactory::new();
    let forest = vec![
        Tree { x: 1, y: 2, tree_type: factory.get_tree_type("Pine", "green-sprite") },
        Tree { x: 5, y: 7, tree_type: factory.get_tree_type("Pine", "green-sprite") }, // reused
        Tree { x: 3, y: 9, tree_type: factory.get_tree_type("Oak", "brown-sprite") },
    ];

    for tree in &forest {
        tree.draw();
    }
}
