<?php
// Abstract Factory: one factory interface creates a whole FAMILY of
// related products (button + checkbox), guaranteeing they're never mixed
// across families (no light button with a dark checkbox).
interface Button
{
    public function render(): string;
}
interface Checkbox
{
    public function render(): string;
}

class LightButton implements Button
{
    public function render(): string { return "[ Light Button ]"; }
}
class LightCheckbox implements Checkbox
{
    public function render(): string { return "[x] Light Checkbox"; }
}
class DarkButton implements Button
{
    public function render(): string { return "[ Dark Button ]"; }
}
class DarkCheckbox implements Checkbox
{
    public function render(): string { return "[x] Dark Checkbox"; }
}

// The abstract factory: one creation method per product in the family.
interface GuiFactory
{
    public function createButton(): Button;
    public function createCheckbox(): Checkbox;
}

class LightFactory implements GuiFactory
{
    public function createButton(): Button { return new LightButton(); }
    public function createCheckbox(): Checkbox { return new LightCheckbox(); }
}

class DarkFactory implements GuiFactory
{
    public function createButton(): Button { return new DarkButton(); }
    public function createCheckbox(): Checkbox { return new DarkCheckbox(); }
}

// The client only talks to GuiFactory — it never knows which theme it got.
class Application
{
    private Button $button;
    private Checkbox $checkbox;

    public function __construct(GuiFactory $factory)
    {
        $this->button = $factory->createButton();
        $this->checkbox = $factory->createCheckbox();
    }

    public function render(): void
    {
        echo $this->button->render() . "\n";
        echo $this->checkbox->render() . "\n";
    }
}

// --- demo ---
(new Application(new LightFactory()))->render();
(new Application(new DarkFactory()))->render();
