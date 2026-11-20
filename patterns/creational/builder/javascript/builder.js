// Builder: constructs a complex object step by step through chainable
// methods, instead of a constructor with a dozen optional parameters.
class Pizza {
  size = "medium";
  cheese = false;
  pepperoni = false;
  mushrooms = false;

  toString() {
    const toppings = [];
    if (this.cheese) toppings.push("cheese");
    if (this.pepperoni) toppings.push("pepperoni");
    if (this.mushrooms) toppings.push("mushrooms");
    const list = toppings.length > 0 ? toppings.join(", ") : "no toppings";
    return `${this.size} pizza with ${list}`;
  }
}

class PizzaBuilder {
  #pizza = new Pizza();

  withSize(size) {
    this.#pizza.size = size;
    return this; // returning `this` is what makes the calls chainable
  }

  addCheese() {
    this.#pizza.cheese = true;
    return this;
  }

  addPepperoni() {
    this.#pizza.pepperoni = true;
    return this;
  }

  addMushrooms() {
    this.#pizza.mushrooms = true;
    return this;
  }

  build() {
    return this.#pizza;
  }
}

// --- demo ---
const pizza = new PizzaBuilder().withSize("large").addCheese().addPepperoni().build();

console.log(pizza.toString());
