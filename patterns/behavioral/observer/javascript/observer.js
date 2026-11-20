// Observer: the subject keeps a list of observers and notifies all of
// them when its state changes, without knowing what each one does with
// that information.
class PhoneDisplay {
  update(temperature) {
    console.log(`[Phone] Temperature is now ${temperature}°C`);
  }
}

class TvDisplay {
  update(temperature) {
    console.log(`[TV] Temperature is now ${temperature}°C`);
  }
}

// The "subject": holds the observers and pushes updates to all of them.
class WeatherStation {
  #observers = [];

  subscribe(observer) {
    this.#observers.push(observer);
  }

  unsubscribe(observer) {
    this.#observers = this.#observers.filter((o) => o !== observer);
  }

  setTemperature(temperature) {
    for (const observer of this.#observers) {
      observer.update(temperature);
    }
  }
}

// --- demo ---
const station = new WeatherStation();
const phone = new PhoneDisplay();
const tv = new TvDisplay();

station.subscribe(phone);
station.subscribe(tv);

station.setTemperature(23.5); // both observers get notified

station.unsubscribe(tv);
station.setTemperature(24.0); // only phone gets notified now
