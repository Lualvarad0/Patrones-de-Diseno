// State: a traffic light behaves differently depending on its current
// state, and each state decides what the NEXT state is — the light
// itself just delegates to whichever state object it currently holds.
// (A closed set of states like this could also be a plain Rust `enum`
// with a `match` — using trait objects here mirrors the classic OOP
// shape of the pattern for comparison with the other languages.)
trait TrafficLightState {
    fn next(self: Box<Self>) -> Box<dyn TrafficLightState>;
    fn name(&self) -> &str;
}

struct RedState;
impl TrafficLightState for RedState {
    fn next(self: Box<Self>) -> Box<dyn TrafficLightState> { Box::new(GreenState) }
    fn name(&self) -> &str { "Red" }
}

struct GreenState;
impl TrafficLightState for GreenState {
    fn next(self: Box<Self>) -> Box<dyn TrafficLightState> { Box::new(YellowState) }
    fn name(&self) -> &str { "Green" }
}

struct YellowState;
impl TrafficLightState for YellowState {
    fn next(self: Box<Self>) -> Box<dyn TrafficLightState> { Box::new(RedState) }
    fn name(&self) -> &str { "Yellow" }
}

// The "context": holds the current state and delegates to it, without a
// big match statement anywhere checking which state it's in. The state
// is wrapped in `Option` so `change()` can take ownership of it (needed
// because `next()` consumes `self`) and put the new one back.
struct TrafficLight {
    state: Option<Box<dyn TrafficLightState>>,
}

impl TrafficLight {
    fn new() -> Self {
        TrafficLight { state: Some(Box::new(RedState)) }
    }

    fn change(&mut self) {
        let current = self.state.take().unwrap();
        let next = current.next();
        println!("Light is now {}", next.name());
        self.state = Some(next);
    }
}

fn main() {
    let mut light = TrafficLight::new();
    light.change(); // Red -> Green
    light.change(); // Green -> Yellow
    light.change(); // Yellow -> Red
}
