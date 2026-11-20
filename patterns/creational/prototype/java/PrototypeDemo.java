// Prototype: the object knows how to clone itself, so you can get a copy
// without coupling the caller to the concrete class or constructor.
class Sheep implements Cloneable {
    String name;
    String color;

    Sheep(String name, String color) {
        this.name = name;
        this.color = color;
    }

    // Shallow copy here is enough because every field is an immutable
    // String — if Sheep held a mutable reference field, a shallow clone
    // would make both sheep share (and corrupt) it.
    @Override
    public Sheep clone() {
        return new Sheep(name, color);
    }

    @Override
    public String toString() {
        return "Sheep(name=" + name + ", color=" + color + ")";
    }
}

public class PrototypeDemo {
    public static void main(String[] args) {
        Sheep original = new Sheep("Dolly", "white");
        Sheep clone = original.clone();
        clone.name = "Dolly Jr.";

        System.out.println(original); // untouched
        System.out.println(clone);    // independent copy with one field changed
    }
}
