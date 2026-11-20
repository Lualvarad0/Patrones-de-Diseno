// Visitor: new operations on a stable shape hierarchy live in separate
// visitor classes instead of being added as a method to every shape.
// Double dispatch (accept calls visit, passing itself) lets the visitor
// know the concrete shape type without any casting.
interface Visitor {
    void visitCircle(Circle circle);
    void visitSquare(Square square);
}

interface Shape {
    void accept(Visitor visitor);
}

class Circle implements Shape {
    final double radius;
    Circle(double radius) { this.radius = radius; }
    public void accept(Visitor visitor) { visitor.visitCircle(this); }
}

class Square implements Shape {
    final double side;
    Square(double side) { this.side = side; }
    public void accept(Visitor visitor) { visitor.visitSquare(this); }
}

class AreaVisitor implements Visitor {
    public void visitCircle(Circle circle) {
        System.out.printf("Circle area: %.2f%n", Math.PI * circle.radius * circle.radius);
    }
    public void visitSquare(Square square) {
        System.out.printf("Square area: %.2f%n", square.side * square.side);
    }
}

class SvgExportVisitor implements Visitor {
    public void visitCircle(Circle circle) {
        System.out.println("<circle r=\"" + circle.radius + "\" />");
    }
    public void visitSquare(Square square) {
        System.out.println("<rect width=\"" + square.side + "\" height=\"" + square.side + "\" />");
    }
}

public class VisitorDemo {
    public static void main(String[] args) {
        Shape[] shapes = { new Circle(3), new Square(4) };

        Visitor areaVisitor = new AreaVisitor();
        for (Shape shape : shapes) shape.accept(areaVisitor); // same shapes, area operation

        System.out.println();

        Visitor svgVisitor = new SvgExportVisitor();
        for (Shape shape : shapes) shape.accept(svgVisitor); // same shapes, export operation
    }
}
