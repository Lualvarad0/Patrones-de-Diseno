// Visitor: new operations on a stable shape hierarchy live in separate
// visitor types instead of being added as a method to every shape.
// Double dispatch (accept calls visit, passing itself) lets the visitor
// know the concrete shape type without any downcasting.
trait Visitor {
    fn visit_circle(&self, circle: &Circle);
    fn visit_square(&self, square: &Square);
}

trait Shape {
    fn accept(&self, visitor: &dyn Visitor);
}

struct Circle {
    radius: f64,
}

impl Shape for Circle {
    fn accept(&self, visitor: &dyn Visitor) {
        visitor.visit_circle(self);
    }
}

struct Square {
    side: f64,
}

impl Shape for Square {
    fn accept(&self, visitor: &dyn Visitor) {
        visitor.visit_square(self);
    }
}

struct AreaVisitor;
impl Visitor for AreaVisitor {
    fn visit_circle(&self, circle: &Circle) {
        println!("Circle area: {:.2}", std::f64::consts::PI * circle.radius * circle.radius);
    }
    fn visit_square(&self, square: &Square) {
        println!("Square area: {:.2}", square.side * square.side);
    }
}

struct SvgExportVisitor;
impl Visitor for SvgExportVisitor {
    fn visit_circle(&self, circle: &Circle) {
        println!("<circle r=\"{}\" />", circle.radius);
    }
    fn visit_square(&self, square: &Square) {
        println!("<rect width=\"{}\" height=\"{}\" />", square.side, square.side);
    }
}

fn main() {
    let shapes: Vec<Box<dyn Shape>> = vec![
        Box::new(Circle { radius: 3.0 }),
        Box::new(Square { side: 4.0 }),
    ];

    let area_visitor = AreaVisitor;
    for shape in &shapes {
        shape.accept(&area_visitor); // same shapes, area operation
    }

    println!();

    let svg_visitor = SvgExportVisitor;
    for shape in &shapes {
        shape.accept(&svg_visitor); // same shapes, export operation
    }
}
