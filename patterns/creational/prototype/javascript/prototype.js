// Prototype: the object knows how to clone itself, so you can get a copy
// without coupling the caller to the concrete class or constructor.
class Sheep {
  constructor(name, color) {
    this.name = name;
    this.color = color;
  }

  // Shallow copy here is enough because every field is an immutable
  // string — if Sheep held a mutable reference field (like an array or
  // another object), a shallow clone would make both sheep share
  // (and corrupt) it.
  clone() {
    return new Sheep(this.name, this.color);
  }

  toString() {
    return `Sheep(name=${this.name}, color=${this.color})`;
  }
}

// --- demo ---
const original = new Sheep("Dolly", "white");
const clone = original.clone();
clone.name = "Dolly Jr.";

console.log(original.toString()); // untouched
console.log(clone.toString()); // independent copy with one field changed
