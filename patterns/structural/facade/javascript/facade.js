// Facade: hides a handful of fiddly subsystem classes behind one simple
// method. The subsystem classes still exist and can be used directly by
// whoever needs the detail — the facade is just a convenient shortcut.
class Amplifier {
  on() {
    console.log("Amplifier on");
  }
  setVolume(level) {
    console.log(`Amplifier volume set to ${level}`);
  }
  off() {
    console.log("Amplifier off");
  }
}

class DvdPlayer {
  on() {
    console.log("DVD player on");
  }
  play(movie) {
    console.log(`Playing "${movie}"`);
  }
  off() {
    console.log("DVD player off");
  }
}

class Projector {
  on() {
    console.log("Projector on");
  }
  setInput(source) {
    console.log(`Projector input set to ${source}`);
  }
  off() {
    console.log("Projector off");
  }
}

// The facade: one simple entry point that coordinates the subsystem.
class HomeTheaterFacade {
  #amplifier = new Amplifier();
  #dvdPlayer = new DvdPlayer();
  #projector = new Projector();

  watchMovie(movie) {
    this.#amplifier.on();
    this.#amplifier.setVolume(7);
    this.#projector.on();
    this.#projector.setInput("DVD");
    this.#dvdPlayer.on();
    this.#dvdPlayer.play(movie);
  }

  endMovie() {
    this.#dvdPlayer.off();
    this.#projector.off();
    this.#amplifier.off();
  }
}

// --- demo ---
const homeTheater = new HomeTheaterFacade();
homeTheater.watchMovie("The Matrix"); // one call instead of six
homeTheater.endMovie();
