<?php
// Prototype: the object knows how to clone itself, so you can get a copy
// without coupling the caller to the concrete class or constructor. PHP
// has this pattern built into the language via the `clone` keyword,
// which does a shallow copy by default; the magic `__clone()` method
// lets you customize what happens on top of that (e.g. deep-copying a
// mutable reference field) — not needed here since every field is a
// plain string.
class Sheep
{
    public function __construct(public string $name, public string $color) {}

    public function describe(): string
    {
        return "Sheep(name={$this->name}, color={$this->color})";
    }
}

// --- demo ---
$original = new Sheep("Dolly", "white");
$clone = clone $original;
$clone->name = "Dolly Jr.";

echo $original->describe() . "\n"; // untouched
echo $clone->describe() . "\n";    // independent copy with one field changed
