// Visitor: new operations on a stable shape hierarchy live in separate
// visitor classes instead of being added as a method to every shape.
// Double dispatch (accept calls visit, passing itself) lets the visitor
// know the concrete shape type without any casting.
#include <iostream>
#include <memory>
#include <vector>
#include <cmath>

class Circle;
class Square;

class Visitor {
public:
    virtual void visitCircle(const Circle& circle) = 0;
    virtual void visitSquare(const Square& square) = 0;
    virtual ~Visitor() = default;
};

class Shape {
public:
    virtual void accept(Visitor& visitor) const = 0;
    virtual ~Shape() = default;
};

class Circle : public Shape {
public:
    double radius;
    explicit Circle(double radius) : radius(radius) {}
    void accept(Visitor& visitor) const override { visitor.visitCircle(*this); }
};

class Square : public Shape {
public:
    double side;
    explicit Square(double side) : side(side) {}
    void accept(Visitor& visitor) const override { visitor.visitSquare(*this); }
};

class AreaVisitor : public Visitor {
public:
    void visitCircle(const Circle& circle) override {
        std::cout << "Circle area: " << (M_PI * circle.radius * circle.radius) << std::endl;
    }
    void visitSquare(const Square& square) override {
        std::cout << "Square area: " << (square.side * square.side) << std::endl;
    }
};

class SvgExportVisitor : public Visitor {
public:
    void visitCircle(const Circle& circle) override {
        std::cout << "<circle r=\"" << circle.radius << "\" />" << std::endl;
    }
    void visitSquare(const Square& square) override {
        std::cout << "<rect width=\"" << square.side << "\" height=\"" << square.side << "\" />" << std::endl;
    }
};

int main() {
    std::vector<std::unique_ptr<Shape>> shapes;
    shapes.push_back(std::make_unique<Circle>(3));
    shapes.push_back(std::make_unique<Square>(4));

    AreaVisitor areaVisitor;
    for (const auto& shape : shapes) shape->accept(areaVisitor); // same shapes, area operation

    std::cout << std::endl;

    SvgExportVisitor svgVisitor;
    for (const auto& shape : shapes) shape->accept(svgVisitor); // same shapes, export operation

    return 0;
}
