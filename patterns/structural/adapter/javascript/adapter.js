// Adapter: makes an incompatible interface (LegacyRectangle) work where a
// different interface (Shape-like: a draw() method) is expected, without
// touching either class.

// The incompatible class we can't (or don't want to) modify — imagine this
// comes from a third-party library with its own quirky API.
class LegacyRectangle {
  oldDraw(x1, y1, x2, y2) {
    console.log(`LegacyRectangle drawn from (${x1},${y1}) to (${x2},${y2})`);
  }
}

// The adapter: exposes draw(), and translates it into the call
// LegacyRectangle actually understands.
class RectangleAdapter {
  #legacyRectangle;
  #x1; #y1; #x2; #y2;

  constructor(legacyRectangle, x1, y1, x2, y2) {
    this.#legacyRectangle = legacyRectangle;
    this.#x1 = x1;
    this.#y1 = y1;
    this.#x2 = x2;
    this.#y2 = y2;
  }

  draw() {
    this.#legacyRectangle.oldDraw(this.#x1, this.#y1, this.#x2, this.#y2);
  }
}

// --- demo ---
const shape = new RectangleAdapter(new LegacyRectangle(), 0, 0, 10, 20);
shape.draw(); // client only ever calls draw()
