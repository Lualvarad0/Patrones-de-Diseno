import java.util.ArrayList;
import java.util.List;

// Observer: the subject keeps a list of observers and notifies all of
// them when its state changes, without knowing what each one does with
// that information.
interface Observer {
    void update(double temperature);
}

class PhoneDisplay implements Observer {
    public void update(double temperature) { System.out.println("[Phone] Temperature is now " + temperature + "°C"); }
}

class TvDisplay implements Observer {
    public void update(double temperature) { System.out.println("[TV] Temperature is now " + temperature + "°C"); }
}

// The "subject": holds the observers and pushes updates to all of them.
class WeatherStation {
    private final List<Observer> observers = new ArrayList<>();

    void subscribe(Observer observer) { observers.add(observer); }
    void unsubscribe(Observer observer) { observers.remove(observer); }

    void setTemperature(double temperature) {
        for (Observer observer : observers) {
            observer.update(temperature);
        }
    }
}

public class ObserverDemo {
    public static void main(String[] args) {
        WeatherStation station = new WeatherStation();
        Observer phone = new PhoneDisplay();
        Observer tv = new TvDisplay();

        station.subscribe(phone);
        station.subscribe(tv);

        station.setTemperature(23.5); // both observers get notified

        station.unsubscribe(tv);
        station.setTemperature(24.0); // only phone gets notified now
    }
}
