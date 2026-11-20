// Prototype: the object knows how to clone itself, so you can get a copy
// without coupling the caller to the concrete type or constructor. Rust
// has this pattern built into the language via the `Clone` trait —
// `#[derive(Clone)]` generates a field-by-field (shallow) copy for free.
#[derive(Clone)]
struct Sheep {
    name: String,
    color: String,
}

impl Sheep {
    fn describe(&self) -> String {
        format!("Sheep(name={}, color={})", self.name, self.color)
    }
}

fn main() {
    let original = Sheep { name: "Dolly".to_string(), color: "white".to_string() };

    let mut clone = original.clone();
    clone.name = "Dolly Jr.".to_string();

    println!("{}", original.describe()); // untouched
    println!("{}", clone.describe()); // independent copy with one field changed
}
