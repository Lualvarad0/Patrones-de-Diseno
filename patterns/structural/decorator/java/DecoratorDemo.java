// Decorator: wraps an object to add behavior, while implementing the same
// interface — so decorators can be stacked in any combination.
interface Beverage {
    String description();
    double cost();
}

class SimpleCoffee implements Beverage {
    public String description() { return "Coffee"; }
    public double cost() { return 2.0; }
}

// Base decorator: just forwards to the wrapped beverage by default.
abstract class BeverageDecorator implements Beverage {
    protected final Beverage beverage;
    protected BeverageDecorator(Beverage beverage) { this.beverage = beverage; }

    public String description() { return beverage.description(); }
    public double cost() { return beverage.cost(); }
}

class MilkDecorator extends BeverageDecorator {
    MilkDecorator(Beverage beverage) { super(beverage); }
    public String description() { return beverage.description() + " + Milk"; }
    public double cost() { return beverage.cost() + 0.5; }
}

class SugarDecorator extends BeverageDecorator {
    SugarDecorator(Beverage beverage) { super(beverage); }
    public String description() { return beverage.description() + " + Sugar"; }
    public double cost() { return beverage.cost() + 0.2; }
}

public class DecoratorDemo {
    public static void main(String[] args) {
        Beverage beverage = new SimpleCoffee();
        beverage = new MilkDecorator(beverage);
        beverage = new SugarDecorator(beverage); // decorators stack freely

        System.out.println(beverage.description() + " => $" + beverage.cost());
    }
}
