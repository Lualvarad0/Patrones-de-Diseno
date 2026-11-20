// Visitor: new operations on a stable shape hierarchy live in separate
// visitor classes instead of being added as a method to every shape.
// Double dispatch (Accept calls Visit, passing itself) lets the visitor
// know the concrete shape type without any casting.
using System;

interface IVisitor
{
    void VisitCircle(Circle circle);
    void VisitSquare(Square square);
}

interface IShape
{
    void Accept(IVisitor visitor);
}

class Circle : IShape
{
    public double Radius { get; }
    public Circle(double radius) => Radius = radius;
    public void Accept(IVisitor visitor) => visitor.VisitCircle(this);
}

class Square : IShape
{
    public double Side { get; }
    public Square(double side) => Side = side;
    public void Accept(IVisitor visitor) => visitor.VisitSquare(this);
}

class AreaVisitor : IVisitor
{
    public void VisitCircle(Circle circle) =>
        Console.WriteLine($"Circle area: {Math.PI * circle.Radius * circle.Radius:F2}");

    public void VisitSquare(Square square) =>
        Console.WriteLine($"Square area: {square.Side * square.Side:F2}");
}

class SvgExportVisitor : IVisitor
{
    public void VisitCircle(Circle circle) =>
        Console.WriteLine($"<circle r=\"{circle.Radius}\" />");

    public void VisitSquare(Square square) =>
        Console.WriteLine($"<rect width=\"{square.Side}\" height=\"{square.Side}\" />");
}

class Program
{
    static void Main()
    {
        IShape[] shapes = { new Circle(3), new Square(4) };

        IVisitor areaVisitor = new AreaVisitor();
        foreach (var shape in shapes) shape.Accept(areaVisitor); // same shapes, area operation

        Console.WriteLine();

        IVisitor svgVisitor = new SvgExportVisitor();
        foreach (var shape in shapes) shape.Accept(svgVisitor); // same shapes, export operation
    }
}
