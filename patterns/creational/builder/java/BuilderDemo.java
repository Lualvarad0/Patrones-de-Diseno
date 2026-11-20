import java.util.ArrayList;
import java.util.List;

// Builder: constructs a complex object step by step through chainable
// methods, instead of a constructor with a dozen optional parameters.
class Pizza {
    String size = "medium";
    boolean cheese;
    boolean pepperoni;
    boolean mushrooms;

    @Override
    public String toString() {
        List<String> toppings = new ArrayList<>();
        if (cheese) toppings.add("cheese");
        if (pepperoni) toppings.add("pepperoni");
        if (mushrooms) toppings.add("mushrooms");
        String list = toppings.isEmpty() ? "no toppings" : String.join(", ", toppings);
        return size + " pizza with " + list;
    }
}

class PizzaBuilder {
    private final Pizza pizza = new Pizza();

    PizzaBuilder withSize(String size) {
        pizza.size = size;
        return this; // returning `this` is what makes the calls chainable
    }

    PizzaBuilder addCheese() {
        pizza.cheese = true;
        return this;
    }

    PizzaBuilder addPepperoni() {
        pizza.pepperoni = true;
        return this;
    }

    PizzaBuilder addMushrooms() {
        pizza.mushrooms = true;
        return this;
    }

    Pizza build() {
        return pizza;
    }
}

public class BuilderDemo {
    public static void main(String[] args) {
        Pizza pizza = new PizzaBuilder()
                .withSize("large")
                .addCheese()
                .addPepperoni()
                .build();

        System.out.println(pizza);
    }
}
