// Abstract Factory: one factory creates a whole FAMILY of related
// products (button + checkbox), guaranteeing they're never mixed across
// families (no light button with a dark checkbox).
class LightButton {
  render() {
    return "[ Light Button ]";
  }
}
class LightCheckbox {
  render() {
    return "[x] Light Checkbox";
  }
}
class DarkButton {
  render() {
    return "[ Dark Button ]";
  }
}
class DarkCheckbox {
  render() {
    return "[x] Dark Checkbox";
  }
}

// The abstract factories: one creation method per product in the family.
class LightFactory {
  createButton() {
    return new LightButton();
  }
  createCheckbox() {
    return new LightCheckbox();
  }
}

class DarkFactory {
  createButton() {
    return new DarkButton();
  }
  createCheckbox() {
    return new DarkCheckbox();
  }
}

// The client only talks to the factory's interface — it never knows
// which theme it got.
class Application {
  constructor(factory) {
    this.button = factory.createButton();
    this.checkbox = factory.createCheckbox();
  }

  render() {
    console.log(this.button.render());
    console.log(this.checkbox.render());
  }
}

// --- demo ---
new Application(new LightFactory()).render();
new Application(new DarkFactory()).render();
