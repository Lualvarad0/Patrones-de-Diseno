// Adapter: makes an incompatible interface (LegacyRectangle) work where a
// different interface (Shape) is expected, without touching either class.
#include <iostream>
#include <memory>

// The interface our client code expects.
class Shape {
public:
    virtual void draw() const = 0;
    virtual ~Shape() = default;
};

// The incompatible class we can't (or don't want to) modify — imagine this
// comes from a third-party library with its own quirky API.
class LegacyRectangle {
public:
    void oldDraw(int x1, int y1, int x2, int y2) const {
        std::cout << "LegacyRectangle drawn from (" << x1 << "," << y1
                   << ") to (" << x2 << "," << y2 << ")" << std::endl;
    }
};

// The adapter: implements Shape, and translates draw() into the call
// LegacyRectangle actually understands.
class RectangleAdapter : public Shape {
public:
    RectangleAdapter(LegacyRectangle legacyRectangle, int x1, int y1, int x2, int y2)
        : legacyRectangle(legacyRectangle), x1(x1), y1(y1), x2(x2), y2(y2) {}

    void draw() const override {
        legacyRectangle.oldDraw(x1, y1, x2, y2);
    }

private:
    LegacyRectangle legacyRectangle;
    int x1, y1, x2, y2;
};

int main() {
    std::unique_ptr<Shape> shape = std::make_unique<RectangleAdapter>(
        LegacyRectangle{}, 0, 0, 10, 20);

    shape->draw(); // client only ever talks to Shape

    return 0;
}
