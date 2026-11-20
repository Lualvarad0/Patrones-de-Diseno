// Adapter: makes an incompatible interface (LegacyRectangle) work where a
// different interface (the Shape trait) is expected, without touching
// either the trait or the legacy type.

// The trait our client code expects.
trait Shape {
    fn draw(&self);
}

// The incompatible type we can't (or don't want to) modify — imagine this
// comes from a third-party crate with its own quirky API.
struct LegacyRectangle;

impl LegacyRectangle {
    fn old_draw(&self, x1: i32, y1: i32, x2: i32, y2: i32) {
        println!("LegacyRectangle drawn from ({x1},{y1}) to ({x2},{y2})");
    }
}

// The adapter: implements Shape, and translates draw() into the call
// LegacyRectangle actually understands.
struct RectangleAdapter {
    legacy_rectangle: LegacyRectangle,
    x1: i32,
    y1: i32,
    x2: i32,
    y2: i32,
}

impl Shape for RectangleAdapter {
    fn draw(&self) {
        self.legacy_rectangle.old_draw(self.x1, self.y1, self.x2, self.y2);
    }
}

fn main() {
    let shape: Box<dyn Shape> = Box::new(RectangleAdapter {
        legacy_rectangle: LegacyRectangle,
        x1: 0,
        y1: 0,
        x2: 10,
        y2: 20,
    });

    shape.draw(); // client only ever talks to the Shape trait
}
