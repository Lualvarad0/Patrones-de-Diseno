// Visitor: new operations on a stable shape hierarchy live in separate
// visitor classes instead of being added as a method to every shape.
// Double dispatch (accept calls visit, passing itself) lets the visitor
// know the concrete shape type without any casting.
class Circle {
  constructor(radius) {
    this.radius = radius;
  }
  accept(visitor) {
    visitor.visitCircle(this);
  }
}

class Square {
  constructor(side) {
    this.side = side;
  }
  accept(visitor) {
    visitor.visitSquare(this);
  }
}

class AreaVisitor {
  visitCircle(circle) {
    console.log(`Circle area: ${(Math.PI * circle.radius ** 2).toFixed(2)}`);
  }
  visitSquare(square) {
    console.log(`Square area: ${(square.side ** 2).toFixed(2)}`);
  }
}

class SvgExportVisitor {
  visitCircle(circle) {
    console.log(`<circle r="${circle.radius}" />`);
  }
  visitSquare(square) {
    console.log(`<rect width="${square.side}" height="${square.side}" />`);
  }
}

// --- demo ---
const shapes = [new Circle(3), new Square(4)];

const areaVisitor = new AreaVisitor();
shapes.forEach((shape) => shape.accept(areaVisitor)); // same shapes, area operation

console.log();

const svgVisitor = new SvgExportVisitor();
shapes.forEach((shape) => shape.accept(svgVisitor)); // same shapes, export operation
