// Prototype: the object knows how to clone itself, so you can get a copy
// without coupling the caller to the concrete class or constructor.
#include <iostream>
#include <memory>
#include <string>

class Sheep {
public:
    Sheep(std::string name, std::string color) : name(std::move(name)), color(std::move(color)) {}

    // Shallow copy here is enough because every field is a plain string
    // value — if Sheep held a pointer to shared mutable data, a shallow
    // clone would make both sheep share (and corrupt) it.
    std::unique_ptr<Sheep> clone() const {
        return std::make_unique<Sheep>(name, color);
    }

    void setName(const std::string& newName) { name = newName; }

    std::string describe() const {
        return "Sheep(name=" + name + ", color=" + color + ")";
    }

private:
    std::string name;
    std::string color;
};

int main() {
    Sheep original("Dolly", "white");
    auto clone = original.clone();
    clone->setName("Dolly Jr.");

    std::cout << original.describe() << std::endl; // untouched
    std::cout << clone->describe() << std::endl;    // independent copy with one field changed

    return 0;
}
