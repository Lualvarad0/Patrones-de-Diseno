import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

// Flyweight: the heavy, repeated part of an object's state (intrinsic —
// here, the tree's sprite/model) is shared across many instances; the
// part that differs per instance (extrinsic — here, x/y position) is
// passed in from outside instead of stored in the shared object.
class TreeType { // the flyweight: shared, created once per distinct type
    private final String name;
    private final String sprite;

    TreeType(String name, String sprite) {
        this.name = name;
        this.sprite = sprite;
    }

    void draw(int x, int y) {
        System.out.println("Drawing " + name + " (" + sprite + ") at (" + x + "," + y + ")");
    }
}

// The factory: makes sure each distinct TreeType is created only once,
// no matter how many trees of that type end up in the forest.
class TreeFactory {
    private final Map<String, TreeType> treeTypes = new HashMap<>();

    TreeType getTreeType(String name, String sprite) {
        TreeType treeType = treeTypes.get(name);
        if (treeType == null) {
            treeType = new TreeType(name, sprite);
            treeTypes.put(name, treeType);
            System.out.println("Created new TreeType: " + name);
        }
        return treeType;
    }
}

// Each Tree only stores its extrinsic state (position) plus a reference
// to the shared flyweight — not a full copy of the sprite data.
class Tree {
    private final int x, y;
    private final TreeType type;

    Tree(int x, int y, TreeType type) {
        this.x = x;
        this.y = y;
        this.type = type;
    }

    void draw() {
        type.draw(x, y);
    }
}

public class FlyweightDemo {
    public static void main(String[] args) {
        TreeFactory factory = new TreeFactory();
        List<Tree> forest = new ArrayList<>();
        forest.add(new Tree(1, 2, factory.getTreeType("Pine", "green-sprite")));
        forest.add(new Tree(5, 7, factory.getTreeType("Pine", "green-sprite"))); // reuses the same TreeType
        forest.add(new Tree(3, 9, factory.getTreeType("Oak", "brown-sprite")));

        for (Tree tree : forest) tree.draw();
    }
}
