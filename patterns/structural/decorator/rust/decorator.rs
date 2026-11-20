// Decorator: wraps an object to add behavior, while implementing the same
// trait — so decorators can be stacked in any combination. In Rust this
// is just a struct holding a `Box<dyn Beverage>` and re-implementing the
// trait on top of it.
trait Beverage {
    fn description(&self) -> String;
    fn cost(&self) -> f64;
}

struct SimpleCoffee;
impl Beverage for SimpleCoffee {
    fn description(&self) -> String {
        "Coffee".to_string()
    }
    fn cost(&self) -> f64 {
        2.0
    }
}

struct MilkDecorator {
    beverage: Box<dyn Beverage>,
}
impl Beverage for MilkDecorator {
    fn description(&self) -> String {
        format!("{} + Milk", self.beverage.description())
    }
    fn cost(&self) -> f64 {
        self.beverage.cost() + 0.5
    }
}

struct SugarDecorator {
    beverage: Box<dyn Beverage>,
}
impl Beverage for SugarDecorator {
    fn description(&self) -> String {
        format!("{} + Sugar", self.beverage.description())
    }
    fn cost(&self) -> f64 {
        self.beverage.cost() + 0.2
    }
}

fn main() {
    let mut beverage: Box<dyn Beverage> = Box::new(SimpleCoffee);
    beverage = Box::new(MilkDecorator { beverage });
    beverage = Box::new(SugarDecorator { beverage }); // decorators stack freely

    println!("{} => ${}", beverage.description(), beverage.cost());
}
