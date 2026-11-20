// State: a traffic light behaves differently depending on its current
// state, and each state decides what the NEXT state is — the light
// itself just delegates to whichever state object it currently holds.
#include <iostream>
#include <memory>
#include <string>

class TrafficLight;

class TrafficLightState {
public:
    virtual void next(TrafficLight& light) = 0;
    virtual std::string name() const = 0;
    virtual ~TrafficLightState() = default;
};

class TrafficLight {
public:
    TrafficLight();

    void setState(std::unique_ptr<TrafficLightState> state) { this->state = std::move(state); }

    void change() {
        state->next(*this);
        std::cout << "Light is now " << state->name() << std::endl;
    }

private:
    std::unique_ptr<TrafficLightState> state;
};

class RedState : public TrafficLightState {
public:
    void next(TrafficLight& light) override;
    std::string name() const override { return "Red"; }
};

class GreenState : public TrafficLightState {
public:
    void next(TrafficLight& light) override;
    std::string name() const override { return "Green"; }
};

class YellowState : public TrafficLightState {
public:
    void next(TrafficLight& light) override;
    std::string name() const override { return "Yellow"; }
};

void RedState::next(TrafficLight& light) { light.setState(std::make_unique<GreenState>()); }
void GreenState::next(TrafficLight& light) { light.setState(std::make_unique<YellowState>()); }
void YellowState::next(TrafficLight& light) { light.setState(std::make_unique<RedState>()); }

TrafficLight::TrafficLight() : state(std::make_unique<RedState>()) {}

int main() {
    TrafficLight light;
    light.change(); // Red -> Green
    light.change(); // Green -> Yellow
    light.change(); // Yellow -> Red

    return 0;
}
