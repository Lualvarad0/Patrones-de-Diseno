// State: a traffic light behaves differently depending on its current
// state, and each state decides what the NEXT state is — the light
// itself just delegates to whichever state object it currently holds.
interface TrafficLightState {
    void next(TrafficLight light);
    String getName();
}

class RedState implements TrafficLightState {
    public String getName() { return "Red"; }
    public void next(TrafficLight light) { light.setState(new GreenState()); }
}

class GreenState implements TrafficLightState {
    public String getName() { return "Green"; }
    public void next(TrafficLight light) { light.setState(new YellowState()); }
}

class YellowState implements TrafficLightState {
    public String getName() { return "Yellow"; }
    public void next(TrafficLight light) { light.setState(new RedState()); }
}

// The "context": holds the current state and delegates to it, without a
// big switch statement anywhere checking which state it's in.
class TrafficLight {
    private TrafficLightState state = new RedState();

    void setState(TrafficLightState state) { this.state = state; }

    void change() {
        state.next(this);
        System.out.println("Light is now " + state.getName());
    }
}

public class StateDemo {
    public static void main(String[] args) {
        TrafficLight light = new TrafficLight();
        light.change(); // Red -> Green
        light.change(); // Green -> Yellow
        light.change(); // Yellow -> Red
    }
}
