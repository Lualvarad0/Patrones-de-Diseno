// Facade: hides a handful of fiddly subsystem classes behind one simple
// method. The subsystem classes still exist and can be used directly by
// whoever needs the detail — the facade is just a convenient shortcut.
class Amplifier {
    void on() { System.out.println("Amplifier on"); }
    void setVolume(int level) { System.out.println("Amplifier volume set to " + level); }
    void off() { System.out.println("Amplifier off"); }
}

class DvdPlayer {
    void on() { System.out.println("DVD player on"); }
    void play(String movie) { System.out.println("Playing \"" + movie + "\""); }
    void off() { System.out.println("DVD player off"); }
}

class Projector {
    void on() { System.out.println("Projector on"); }
    void setInput(String source) { System.out.println("Projector input set to " + source); }
    void off() { System.out.println("Projector off"); }
}

// The facade: one simple entry point that coordinates the subsystem.
class HomeTheaterFacade {
    private final Amplifier amplifier = new Amplifier();
    private final DvdPlayer dvdPlayer = new DvdPlayer();
    private final Projector projector = new Projector();

    void watchMovie(String movie) {
        amplifier.on();
        amplifier.setVolume(7);
        projector.on();
        projector.setInput("DVD");
        dvdPlayer.on();
        dvdPlayer.play(movie);
    }

    void endMovie() {
        dvdPlayer.off();
        projector.off();
        amplifier.off();
    }
}

public class FacadeDemo {
    public static void main(String[] args) {
        HomeTheaterFacade homeTheater = new HomeTheaterFacade();
        homeTheater.watchMovie("The Matrix"); // one call instead of six
        homeTheater.endMovie();
    }
}
