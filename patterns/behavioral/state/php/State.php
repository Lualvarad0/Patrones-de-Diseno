<?php
// State: a traffic light behaves differently depending on its current
// state, and each state decides what the NEXT state is — the light
// itself just delegates to whichever state object it currently holds.
interface TrafficLightState
{
    public function next(TrafficLight $light): void;
    public function getName(): string;
}

class RedState implements TrafficLightState
{
    public function next(TrafficLight $light): void { $light->setState(new GreenState()); }
    public function getName(): string { return "Red"; }
}

class GreenState implements TrafficLightState
{
    public function next(TrafficLight $light): void { $light->setState(new YellowState()); }
    public function getName(): string { return "Green"; }
}

class YellowState implements TrafficLightState
{
    public function next(TrafficLight $light): void { $light->setState(new RedState()); }
    public function getName(): string { return "Yellow"; }
}

// The "context": holds the current state and delegates to it, without a
// big switch statement anywhere checking which state it's in.
class TrafficLight
{
    private TrafficLightState $state;

    public function __construct()
    {
        $this->state = new RedState();
    }

    public function setState(TrafficLightState $state): void
    {
        $this->state = $state;
    }

    public function change(): void
    {
        $this->state->next($this);
        echo "Light is now " . $this->state->getName() . "\n";
    }
}

// --- demo ---
$light = new TrafficLight();
$light->change(); // Red -> Green
$light->change(); // Green -> Yellow
$light->change(); // Yellow -> Red
