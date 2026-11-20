// Facade: hides a handful of fiddly subsystem classes behind one simple
// method. The subsystem classes still exist and can be used directly by
// whoever needs the detail — the facade is just a convenient shortcut.
#include <iostream>
#include <string>

class Amplifier {
public:
    void on() const { std::cout << "Amplifier on" << std::endl; }
    void setVolume(int level) const { std::cout << "Amplifier volume set to " << level << std::endl; }
    void off() const { std::cout << "Amplifier off" << std::endl; }
};

class DvdPlayer {
public:
    void on() const { std::cout << "DVD player on" << std::endl; }
    void play(const std::string& movie) const { std::cout << "Playing \"" << movie << "\"" << std::endl; }
    void off() const { std::cout << "DVD player off" << std::endl; }
};

class Projector {
public:
    void on() const { std::cout << "Projector on" << std::endl; }
    void setInput(const std::string& source) const { std::cout << "Projector input set to " << source << std::endl; }
    void off() const { std::cout << "Projector off" << std::endl; }
};

// The facade: one simple entry point that coordinates the subsystem.
class HomeTheaterFacade {
public:
    void watchMovie(const std::string& movie) const {
        amplifier.on();
        amplifier.setVolume(7);
        projector.on();
        projector.setInput("DVD");
        dvdPlayer.on();
        dvdPlayer.play(movie);
    }

    void endMovie() const {
        dvdPlayer.off();
        projector.off();
        amplifier.off();
    }

private:
    Amplifier amplifier;
    DvdPlayer dvdPlayer;
    Projector projector;
};

int main() {
    HomeTheaterFacade homeTheater;
    homeTheater.watchMovie("The Matrix"); // one call instead of six
    homeTheater.endMovie();

    return 0;
}
