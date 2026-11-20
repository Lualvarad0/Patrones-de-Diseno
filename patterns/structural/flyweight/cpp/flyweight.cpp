// Flyweight: the heavy, repeated part of an object's state (intrinsic —
// here, the tree's sprite/model) is shared across many instances via
// shared_ptr; the part that differs per instance (extrinsic — x/y
// position) is passed in from outside instead of stored in the shared
// object.
#include <iostream>
#include <map>
#include <memory>
#include <string>
#include <vector>

class TreeType { // the flyweight: shared, created once per distinct type
public:
    TreeType(std::string name, std::string sprite) : name(std::move(name)), sprite(std::move(sprite)) {}

    void draw(int x, int y) const {
        std::cout << "Drawing " << name << " (" << sprite << ") at (" << x << "," << y << ")" << std::endl;
    }

private:
    std::string name;
    std::string sprite;
};

// The factory: makes sure each distinct TreeType is created only once,
// no matter how many trees of that type end up in the forest.
class TreeFactory {
public:
    std::shared_ptr<TreeType> getTreeType(const std::string& name, const std::string& sprite) {
        auto it = treeTypes.find(name);
        if (it != treeTypes.end()) return it->second;

        auto treeType = std::make_shared<TreeType>(name, sprite);
        treeTypes[name] = treeType;
        std::cout << "Created new TreeType: " << name << std::endl;
        return treeType;
    }

private:
    std::map<std::string, std::shared_ptr<TreeType>> treeTypes;
};

// Each Tree only stores its extrinsic state (position) plus a shared
// pointer to the flyweight — not a full copy of the sprite data.
class Tree {
public:
    Tree(int x, int y, std::shared_ptr<TreeType> type) : x(x), y(y), type(std::move(type)) {}

    void draw() const { type->draw(x, y); }

private:
    int x, y;
    std::shared_ptr<TreeType> type;
};

int main() {
    TreeFactory factory;
    std::vector<Tree> forest;
    forest.emplace_back(1, 2, factory.getTreeType("Pine", "green-sprite"));
    forest.emplace_back(5, 7, factory.getTreeType("Pine", "green-sprite")); // reused
    forest.emplace_back(3, 9, factory.getTreeType("Oak", "brown-sprite"));

    for (const auto& tree : forest) tree.draw();

    return 0;
}
