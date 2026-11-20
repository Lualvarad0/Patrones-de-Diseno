<?php
// Builder: constructs a complex object step by step through chainable
// methods, instead of a constructor with a dozen optional parameters.
class Pizza
{
    public string $size = "medium";
    public bool $cheese = false;
    public bool $pepperoni = false;
    public bool $mushrooms = false;

    public function describe(): string
    {
        $toppings = [];
        if ($this->cheese) $toppings[] = "cheese";
        if ($this->pepperoni) $toppings[] = "pepperoni";
        if ($this->mushrooms) $toppings[] = "mushrooms";
        $list = empty($toppings) ? "no toppings" : implode(", ", $toppings);
        return "{$this->size} pizza with {$list}";
    }
}

class PizzaBuilder
{
    private Pizza $pizza;

    public function __construct()
    {
        $this->pizza = new Pizza();
    }

    public function withSize(string $size): static
    {
        $this->pizza->size = $size;
        return $this; // returning $this is what makes the calls chainable
    }

    public function addCheese(): static
    {
        $this->pizza->cheese = true;
        return $this;
    }

    public function addPepperoni(): static
    {
        $this->pizza->pepperoni = true;
        return $this;
    }

    public function addMushrooms(): static
    {
        $this->pizza->mushrooms = true;
        return $this;
    }

    public function build(): Pizza
    {
        return $this->pizza;
    }
}

// --- demo ---
$pizza = (new PizzaBuilder())
    ->withSize("large")
    ->addCheese()
    ->addPepperoni()
    ->build();

echo $pizza->describe() . "\n";
