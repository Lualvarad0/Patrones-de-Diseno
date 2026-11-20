// Decorator: wraps an object to add behavior, while implementing the same
// interface — so decorators can be stacked in any combination.
#include <iostream>
#include <memory>
#include <string>

class Beverage {
public:
    virtual std::string description() const = 0;
    virtual double cost() const = 0;
    virtual ~Beverage() = default;
};

class SimpleCoffee : public Beverage {
public:
    std::string description() const override { return "Coffee"; }
    double cost() const override { return 2.0; }
};

// Base decorator: just forwards to the wrapped beverage by default.
class BeverageDecorator : public Beverage {
public:
    explicit BeverageDecorator(std::unique_ptr<Beverage> beverage)
        : beverage(std::move(beverage)) {}

protected:
    std::unique_ptr<Beverage> beverage;
};

class MilkDecorator : public BeverageDecorator {
public:
    explicit MilkDecorator(std::unique_ptr<Beverage> beverage)
        : BeverageDecorator(std::move(beverage)) {}

    std::string description() const override { return beverage->description() + " + Milk"; }
    double cost() const override { return beverage->cost() + 0.5; }
};

class SugarDecorator : public BeverageDecorator {
public:
    explicit SugarDecorator(std::unique_ptr<Beverage> beverage)
        : BeverageDecorator(std::move(beverage)) {}

    std::string description() const override { return beverage->description() + " + Sugar"; }
    double cost() const override { return beverage->cost() + 0.2; }
};

int main() {
    std::unique_ptr<Beverage> beverage = std::make_unique<SimpleCoffee>();
    beverage = std::make_unique<MilkDecorator>(std::move(beverage));
    beverage = std::make_unique<SugarDecorator>(std::move(beverage)); // stack freely

    std::cout << beverage->description() << " => $" << beverage->cost() << std::endl;

    return 0;
}
