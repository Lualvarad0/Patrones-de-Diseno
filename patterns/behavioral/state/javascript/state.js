// State: a traffic light behaves differently depending on its current
// state, and each state decides what the NEXT state is — the light
// itself just delegates to whichever state object it currently holds.
class RedState {
  name = "Red";
  next(light) {
    light.setState(new GreenState());
  }
}

class GreenState {
  name = "Green";
  next(light) {
    light.setState(new YellowState());
  }
}

class YellowState {
  name = "Yellow";
  next(light) {
    light.setState(new RedState());
  }
}

// The "context": holds the current state and delegates to it, without a
// big switch statement anywhere checking which state it's in.
class TrafficLight {
  state = new RedState();

  setState(state) {
    this.state = state;
  }

  change() {
    this.state.next(this);
    console.log(`Light is now ${this.state.name}`);
  }
}

// --- demo ---
const light = new TrafficLight();
light.change(); // Red -> Green
light.change(); // Green -> Yellow
light.change(); // Yellow -> Red
