<?php
// Visitor: new operations on a stable shape hierarchy live in separate
// visitor classes instead of being added as a method to every shape.
// Double dispatch (accept calls visit, passing itself) lets the visitor
// know the concrete shape type without any casting.
interface Visitor
{
    public function visitCircle(Circle $circle): void;
    public function visitSquare(Square $square): void;
}

interface Shape
{
    public function accept(Visitor $visitor): void;
}

class Circle implements Shape
{
    public function __construct(public readonly float $radius) {}
    public function accept(Visitor $visitor): void { $visitor->visitCircle($this); }
}

class Square implements Shape
{
    public function __construct(public readonly float $side) {}
    public function accept(Visitor $visitor): void { $visitor->visitSquare($this); }
}

class AreaVisitor implements Visitor
{
    public function visitCircle(Circle $circle): void
    {
        printf("Circle area: %.2f\n", M_PI * $circle->radius ** 2);
    }

    public function visitSquare(Square $square): void
    {
        printf("Square area: %.2f\n", $square->side ** 2);
    }
}

class SvgExportVisitor implements Visitor
{
    public function visitCircle(Circle $circle): void
    {
        echo "<circle r=\"{$circle->radius}\" />\n";
    }

    public function visitSquare(Square $square): void
    {
        echo "<rect width=\"{$square->side}\" height=\"{$square->side}\" />\n";
    }
}

// --- demo ---
$shapes = [new Circle(3), new Square(4)];

$areaVisitor = new AreaVisitor();
foreach ($shapes as $shape) { $shape->accept($areaVisitor); } // same shapes, area operation

echo "\n";

$svgVisitor = new SvgExportVisitor();
foreach ($shapes as $shape) { $shape->accept($svgVisitor); } // same shapes, export operation
