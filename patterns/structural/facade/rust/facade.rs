// Facade: hides a handful of fiddly subsystem types behind one simple
// method. The subsystem types still exist and can be used directly by
// whoever needs the detail — the facade is just a convenient shortcut.
struct Amplifier;
impl Amplifier {
    fn on(&self) { println!("Amplifier on"); }
    fn set_volume(&self, level: u8) { println!("Amplifier volume set to {level}"); }
    fn off(&self) { println!("Amplifier off"); }
}

struct DvdPlayer;
impl DvdPlayer {
    fn on(&self) { println!("DVD player on"); }
    fn play(&self, movie: &str) { println!("Playing \"{movie}\""); }
    fn off(&self) { println!("DVD player off"); }
}

struct Projector;
impl Projector {
    fn on(&self) { println!("Projector on"); }
    fn set_input(&self, source: &str) { println!("Projector input set to {source}"); }
    fn off(&self) { println!("Projector off"); }
}

// The facade: one simple entry point that coordinates the subsystem.
struct HomeTheaterFacade {
    amplifier: Amplifier,
    dvd_player: DvdPlayer,
    projector: Projector,
}

impl HomeTheaterFacade {
    fn new() -> Self {
        HomeTheaterFacade { amplifier: Amplifier, dvd_player: DvdPlayer, projector: Projector }
    }

    fn watch_movie(&self, movie: &str) {
        self.amplifier.on();
        self.amplifier.set_volume(7);
        self.projector.on();
        self.projector.set_input("DVD");
        self.dvd_player.on();
        self.dvd_player.play(movie);
    }

    fn end_movie(&self) {
        self.dvd_player.off();
        self.projector.off();
        self.amplifier.off();
    }
}

fn main() {
    let home_theater = HomeTheaterFacade::new();
    home_theater.watch_movie("The Matrix"); // one call instead of six
    home_theater.end_movie();
}
