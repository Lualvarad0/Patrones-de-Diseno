// Observer: the subject keeps a list of observers and notifies all of
// them when its state changes, without knowing what each one does with
// that information.
trait Observer {
    fn update(&self, temperature: f64);
}

struct PhoneDisplay;
impl Observer for PhoneDisplay {
    fn update(&self, temperature: f64) {
        println!("[Phone] Temperature is now {temperature}°C");
    }
}

struct TvDisplay;
impl Observer for TvDisplay {
    fn update(&self, temperature: f64) {
        println!("[TV] Temperature is now {temperature}°C");
    }
}

// The "subject": holds the observers and pushes updates to all of them.
// We give each observer an id so unsubscribe has something to match on —
// Rust's ownership rules make removing "by reference" from a Vec<Box<dyn Trait>>
// awkward, so a simple id is the idiomatic way around it here.
struct WeatherStation {
    observers: Vec<(u32, Box<dyn Observer>)>,
    next_id: u32,
}

impl WeatherStation {
    fn new() -> Self {
        WeatherStation { observers: Vec::new(), next_id: 0 }
    }

    fn subscribe(&mut self, observer: Box<dyn Observer>) -> u32 {
        let id = self.next_id;
        self.next_id += 1;
        self.observers.push((id, observer));
        id
    }

    fn unsubscribe(&mut self, id: u32) {
        self.observers.retain(|(obs_id, _)| *obs_id != id);
    }

    fn set_temperature(&self, temperature: f64) {
        for (_, observer) in &self.observers {
            observer.update(temperature);
        }
    }
}

fn main() {
    let mut station = WeatherStation::new();
    let phone_id = station.subscribe(Box::new(PhoneDisplay));
    let tv_id = station.subscribe(Box::new(TvDisplay));

    station.set_temperature(23.5); // both observers get notified

    station.unsubscribe(tv_id);
    station.set_temperature(24.0); // only phone gets notified now

    let _ = phone_id; // keep the id around; nothing else needs it here
}
