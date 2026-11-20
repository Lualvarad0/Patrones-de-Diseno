<?php
// Decorator: wraps an object to add behavior, while implementing the same
// interface — so decorators can be stacked in any combination.
interface Beverage
{
    public function description(): string;
    public function cost(): float;
}

class SimpleCoffee implements Beverage
{
    public function description(): string { return "Coffee"; }
    public function cost(): float { return 2.0; }
}

// Base decorator: just forwards to the wrapped beverage by default.
abstract class BeverageDecorator implements Beverage
{
    public function __construct(protected Beverage $beverage) {}

    public function description(): string { return $this->beverage->description(); }
    public function cost(): float { return $this->beverage->cost(); }
}

class MilkDecorator extends BeverageDecorator
{
    public function description(): string { return $this->beverage->description() . " + Milk"; }
    public function cost(): float { return $this->beverage->cost() + 0.5; }
}

class SugarDecorator extends BeverageDecorator
{
    public function description(): string { return $this->beverage->description() . " + Sugar"; }
    public function cost(): float { return $this->beverage->cost() + 0.2; }
}

// --- demo ---
$beverage = new SimpleCoffee();
$beverage = new MilkDecorator($beverage);
$beverage = new SugarDecorator($beverage); // decorators stack freely

echo $beverage->description() . " => $" . $beverage->cost() . "\n";
