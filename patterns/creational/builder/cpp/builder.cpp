// Builder: constructs a complex object step by step through chainable
// methods, instead of a constructor with a dozen optional parameters.
#include <iostream>
#include <string>
#include <vector>

class Pizza {
public:
    std::string size = "medium";
    bool cheese = false;
    bool pepperoni = false;
    bool mushrooms = false;

    std::string describe() const {
        std::vector<std::string> toppings;
        if (cheese) toppings.push_back("cheese");
        if (pepperoni) toppings.push_back("pepperoni");
        if (mushrooms) toppings.push_back("mushrooms");

        std::string list = toppings.empty() ? "no toppings" : "";
        for (size_t i = 0; i < toppings.size(); ++i) {
            list += toppings[i];
            if (i + 1 < toppings.size()) list += ", ";
        }
        return size + " pizza with " + list;
    }
};

class PizzaBuilder {
public:
    PizzaBuilder& withSize(const std::string& s) {
        pizza.size = s;
        return *this; // returning a reference to *this is what makes the calls chainable
    }

    PizzaBuilder& addCheese() {
        pizza.cheese = true;
        return *this;
    }

    PizzaBuilder& addPepperoni() {
        pizza.pepperoni = true;
        return *this;
    }

    PizzaBuilder& addMushrooms() {
        pizza.mushrooms = true;
        return *this;
    }

    Pizza build() const {
        return pizza;
    }

private:
    Pizza pizza;
};

int main() {
    Pizza pizza = PizzaBuilder()
        .withSize("large")
        .addCheese()
        .addPepperoni()
        .build();

    std::cout << pizza.describe() << std::endl;

    return 0;
}
