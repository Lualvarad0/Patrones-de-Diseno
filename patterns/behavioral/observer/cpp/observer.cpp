// Observer: the subject keeps a list of observers and notifies all of
// them when its state changes, without knowing what each one does with
// that information.
#include <algorithm>
#include <iostream>
#include <vector>

class Observer {
public:
    virtual void update(double temperature) const = 0;
    virtual ~Observer() = default;
};

class PhoneDisplay : public Observer {
public:
    void update(double temperature) const override {
        std::cout << "[Phone] Temperature is now " << temperature << " C" << std::endl;
    }
};

class TvDisplay : public Observer {
public:
    void update(double temperature) const override {
        std::cout << "[TV] Temperature is now " << temperature << " C" << std::endl;
    }
};

// The "subject": holds the observers (as raw pointers it doesn't own) and
// pushes updates to all of them.
class WeatherStation {
public:
    void subscribe(Observer* observer) {
        observers.push_back(observer);
    }

    void unsubscribe(Observer* observer) {
        observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
    }

    void setTemperature(double temperature) const {
        for (auto* observer : observers) {
            observer->update(temperature);
        }
    }

private:
    std::vector<Observer*> observers;
};

int main() {
    WeatherStation station;
    PhoneDisplay phone;
    TvDisplay tv;

    station.subscribe(&phone);
    station.subscribe(&tv);

    station.setTemperature(23.5); // both observers get notified

    station.unsubscribe(&tv);
    station.setTemperature(24.0); // only phone gets notified now

    return 0;
}
