<?php
// Bridge: splits "remote control" (the abstraction) from "device" (the
// implementation) into two independent hierarchies joined by composition,
// so each one can grow on its own without a subclass explosion.
interface Device
{
    public function isOn(): bool;
    public function turnOn(): void;
    public function turnOff(): void;
    public function getName(): string;
}

class Tv implements Device
{
    private bool $on = false;
    public function isOn(): bool { return $this->on; }
    public function turnOn(): void { $this->on = true; }
    public function turnOff(): void { $this->on = false; }
    public function getName(): string { return "TV"; }
}

class Radio implements Device
{
    private bool $on = false;
    public function isOn(): bool { return $this->on; }
    public function turnOn(): void { $this->on = true; }
    public function turnOff(): void { $this->on = false; }
    public function getName(): string { return "Radio"; }
}

// The abstraction: holds a device and delegates to it, without caring
// which concrete device it is.
class RemoteControl
{
    public function __construct(protected Device $device) {}

    public function togglePower(): void
    {
        if ($this->device->isOn()) $this->device->turnOff(); else $this->device->turnOn();
        echo $this->device->getName() . " is now " . ($this->device->isOn() ? "ON" : "OFF") . "\n";
    }
}

// A second abstraction growing independently of the device hierarchy.
class AdvancedRemoteControl extends RemoteControl
{
    public function mute(): void
    {
        if ($this->device->isOn()) echo $this->device->getName() . " muted\n";
    }
}

// --- demo ---
$tvRemote = new RemoteControl(new Tv());
$tvRemote->togglePower();

$radioRemote = new AdvancedRemoteControl(new Radio());
$radioRemote->togglePower();
$radioRemote->mute();
