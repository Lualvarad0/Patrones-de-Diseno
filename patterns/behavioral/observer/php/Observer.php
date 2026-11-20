<?php
// Observer: the subject keeps a list of observers and notifies all of
// them when its state changes, without knowing what each one does with
// that information.
interface Observer
{
    public function update(float $temperature): void;
}

class PhoneDisplay implements Observer
{
    public function update(float $temperature): void
    {
        echo "[Phone] Temperature is now {$temperature}C\n";
    }
}

class TvDisplay implements Observer
{
    public function update(float $temperature): void
    {
        echo "[TV] Temperature is now {$temperature}C\n";
    }
}

// The "subject": holds the observers and pushes updates to all of them.
class WeatherStation
{
    /** @var Observer[] */
    private array $observers = [];

    public function subscribe(Observer $observer): void
    {
        $this->observers[] = $observer;
    }

    public function unsubscribe(Observer $observer): void
    {
        $this->observers = array_filter($this->observers, fn($o) => $o !== $observer);
    }

    public function setTemperature(float $temperature): void
    {
        foreach ($this->observers as $observer) {
            $observer->update($temperature);
        }
    }
}

// --- demo ---
$station = new WeatherStation();
$phone = new PhoneDisplay();
$tv = new TvDisplay();

$station->subscribe($phone);
$station->subscribe($tv);

$station->setTemperature(23.5); // both observers get notified

$station->unsubscribe($tv);
$station->setTemperature(24.0); // only phone gets notified now
