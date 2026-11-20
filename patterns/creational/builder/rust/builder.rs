// Builder: constructs a complex value step by step through chainable
// methods, instead of a constructor with a dozen optional parameters.
// The idiomatic Rust style consumes and returns `self` by value, so each
// call in the chain moves the builder forward.
struct Pizza {
    size: String,
    cheese: bool,
    pepperoni: bool,
    mushrooms: bool,
}

impl Pizza {
    fn describe(&self) -> String {
        let mut toppings = Vec::new();
        if self.cheese { toppings.push("cheese"); }
        if self.pepperoni { toppings.push("pepperoni"); }
        if self.mushrooms { toppings.push("mushrooms"); }
        let list = if toppings.is_empty() { "no toppings".to_string() } else { toppings.join(", ") };
        format!("{} pizza with {}", self.size, list)
    }
}

struct PizzaBuilder {
    size: String,
    cheese: bool,
    pepperoni: bool,
    mushrooms: bool,
}

impl PizzaBuilder {
    fn new() -> Self {
        PizzaBuilder { size: "medium".to_string(), cheese: false, pepperoni: false, mushrooms: false }
    }

    fn with_size(mut self, size: &str) -> Self {
        self.size = size.to_string();
        self // returning `self` by value is what makes the calls chainable
    }

    fn add_cheese(mut self) -> Self {
        self.cheese = true;
        self
    }

    fn add_pepperoni(mut self) -> Self {
        self.pepperoni = true;
        self
    }

    fn add_mushrooms(mut self) -> Self {
        self.mushrooms = true;
        self
    }

    fn build(self) -> Pizza {
        Pizza { size: self.size, cheese: self.cheese, pepperoni: self.pepperoni, mushrooms: self.mushrooms }
    }
}

fn main() {
    let pizza = PizzaBuilder::new()
        .with_size("large")
        .add_cheese()
        .add_pepperoni()
        .build();

    println!("{}", pizza.describe());
}
