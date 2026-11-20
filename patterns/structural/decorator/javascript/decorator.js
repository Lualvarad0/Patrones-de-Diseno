// Decorator: wraps an object to add behavior, while implementing the same
// interface — so decorators can be stacked in any combination.
class SimpleCoffee {
  description() {
    return "Coffee";
  }
  cost() {
    return 2.0;
  }
}

// Base decorator: just forwards to the wrapped beverage by default.
class BeverageDecorator {
  constructor(beverage) {
    this.beverage = beverage;
  }
  description() {
    return this.beverage.description();
  }
  cost() {
    return this.beverage.cost();
  }
}

class MilkDecorator extends BeverageDecorator {
  description() {
    return `${this.beverage.description()} + Milk`;
  }
  cost() {
    return this.beverage.cost() + 0.5;
  }
}

class SugarDecorator extends BeverageDecorator {
  description() {
    return `${this.beverage.description()} + Sugar`;
  }
  cost() {
    return this.beverage.cost() + 0.2;
  }
}

// --- demo ---
let beverage = new SimpleCoffee();
beverage = new MilkDecorator(beverage);
beverage = new SugarDecorator(beverage); // decorators stack freely

console.log(`${beverage.description()} => $${beverage.cost()}`);
