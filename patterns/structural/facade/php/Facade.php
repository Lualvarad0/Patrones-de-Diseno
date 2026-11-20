<?php
// Facade: hides a handful of fiddly subsystem classes behind one simple
// method. The subsystem classes still exist and can be used directly by
// whoever needs the detail — the facade is just a convenient shortcut.
class Amplifier
{
    public function on(): void { echo "Amplifier on\n"; }
    public function setVolume(int $level): void { echo "Amplifier volume set to {$level}\n"; }
    public function off(): void { echo "Amplifier off\n"; }
}

class DvdPlayer
{
    public function on(): void { echo "DVD player on\n"; }
    public function play(string $movie): void { echo "Playing \"{$movie}\"\n"; }
    public function off(): void { echo "DVD player off\n"; }
}

class Projector
{
    public function on(): void { echo "Projector on\n"; }
    public function setInput(string $source): void { echo "Projector input set to {$source}\n"; }
    public function off(): void { echo "Projector off\n"; }
}

// The facade: one simple entry point that coordinates the subsystem.
class HomeTheaterFacade
{
    private Amplifier $amplifier;
    private DvdPlayer $dvdPlayer;
    private Projector $projector;

    public function __construct()
    {
        $this->amplifier = new Amplifier();
        $this->dvdPlayer = new DvdPlayer();
        $this->projector = new Projector();
    }

    public function watchMovie(string $movie): void
    {
        $this->amplifier->on();
        $this->amplifier->setVolume(7);
        $this->projector->on();
        $this->projector->setInput("DVD");
        $this->dvdPlayer->on();
        $this->dvdPlayer->play($movie);
    }

    public function endMovie(): void
    {
        $this->dvdPlayer->off();
        $this->projector->off();
        $this->amplifier->off();
    }
}

// --- demo ---
$homeTheater = new HomeTheaterFacade();
$homeTheater->watchMovie("The Matrix"); // one call instead of six
$homeTheater->endMovie();
