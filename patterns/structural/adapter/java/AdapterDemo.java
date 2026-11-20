// Adapter: makes an incompatible interface (LegacyRectangle) work where a
// different interface (Shape) is expected, without touching either class.

// The interface our client code expects.
interface Shape {
    void draw();
}

// The incompatible class we can't (or don't want to) modify — imagine this
// comes from a third-party library with its own quirky API.
class LegacyRectangle {
    void oldDraw(int x1, int y1, int x2, int y2) {
        System.out.println("LegacyRectangle drawn from (" + x1 + "," + y1 + ") to (" + x2 + "," + y2 + ")");
    }
}

// The adapter: implements Shape, and translates draw() into the call
// LegacyRectangle actually understands.
class RectangleAdapter implements Shape {
    private final LegacyRectangle legacyRectangle;
    private final int x1, y1, x2, y2;

    RectangleAdapter(LegacyRectangle legacyRectangle, int x1, int y1, int x2, int y2) {
        this.legacyRectangle = legacyRectangle;
        this.x1 = x1;
        this.y1 = y1;
        this.x2 = x2;
        this.y2 = y2;
    }

    public void draw() {
        legacyRectangle.oldDraw(x1, y1, x2, y2);
    }
}

public class AdapterDemo {
    public static void main(String[] args) {
        Shape shape = new RectangleAdapter(new LegacyRectangle(), 0, 0, 10, 20);
        shape.draw(); // client only ever talks to Shape
    }
}
