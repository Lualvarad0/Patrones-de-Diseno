<?php
// Adapter: makes an incompatible interface (LegacyRectangle) work where a
// different interface (Shape) is expected, without touching either class.

// The interface our client code expects.
interface Shape
{
    public function draw(): void;
}

// The incompatible class we can't (or don't want to) modify — imagine this
// comes from a third-party library with its own quirky API.
class LegacyRectangle
{
    public function oldDraw(int $x1, int $y1, int $x2, int $y2): void
    {
        echo "LegacyRectangle drawn from ($x1,$y1) to ($x2,$y2)\n";
    }
}

// The adapter: implements Shape, and translates draw() into the call
// LegacyRectangle actually understands.
class RectangleAdapter implements Shape
{
    public function __construct(
        private LegacyRectangle $legacyRectangle,
        private int $x1,
        private int $y1,
        private int $x2,
        private int $y2
    ) {}

    public function draw(): void
    {
        $this->legacyRectangle->oldDraw($this->x1, $this->y1, $this->x2, $this->y2);
    }
}

// --- demo ---
$shape = new RectangleAdapter(new LegacyRectangle(), 0, 0, 10, 20);
$shape->draw(); // client only ever talks to Shape
