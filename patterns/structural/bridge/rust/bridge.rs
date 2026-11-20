// Bridge: splits "remote control" (the abstraction) from "device" (the
// implementation) into two independent hierarchies joined by composition,
// so each one can grow on its own without a subclass explosion.
trait Device {
    fn is_on(&self) -> bool;
    fn turn_on(&mut self);
    fn turn_off(&mut self);
    fn name(&self) -> &str;
}

struct Tv { on: bool }
impl Device for Tv {
    fn is_on(&self) -> bool { self.on }
    fn turn_on(&mut self) { self.on = true; }
    fn turn_off(&mut self) { self.on = false; }
    fn name(&self) -> &str { "TV" }
}

struct Radio { on: bool }
impl Device for Radio {
    fn is_on(&self) -> bool { self.on }
    fn turn_on(&mut self) { self.on = true; }
    fn turn_off(&mut self) { self.on = false; }
    fn name(&self) -> &str { "Radio" }
}

// The abstraction: holds a device and delegates to it, without caring
// which concrete device it is.
struct RemoteControl {
    device: Box<dyn Device>,
}

impl RemoteControl {
    fn toggle_power(&mut self) {
        if self.device.is_on() { self.device.turn_off(); } else { self.device.turn_on(); }
        println!("{} is now {}", self.device.name(), if self.device.is_on() { "ON" } else { "OFF" });
    }
}

// A second abstraction growing independently of the device hierarchy.
// Rust favors composition over inheritance, so instead of subclassing
// RemoteControl we wrap it.
struct AdvancedRemoteControl {
    remote: RemoteControl,
}

impl AdvancedRemoteControl {
    fn toggle_power(&mut self) {
        self.remote.toggle_power();
    }

    fn mute(&self) {
        if self.remote.device.is_on() {
            println!("{} muted", self.remote.device.name());
        }
    }
}

fn main() {
    let mut tv_remote = RemoteControl { device: Box::new(Tv { on: false }) };
    tv_remote.toggle_power();

    let mut radio_remote = AdvancedRemoteControl { remote: RemoteControl { device: Box::new(Radio { on: false }) } };
    radio_remote.toggle_power();
    radio_remote.mute();
}
