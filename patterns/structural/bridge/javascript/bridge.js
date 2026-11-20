// Bridge: splits "remote control" (the abstraction) from "device" (the
// implementation) into two independent hierarchies joined by composition,
// so each one can grow on its own without a subclass explosion.
class Tv {
  on = false;
  name = "TV";
  turnOn() {
    this.on = true;
  }
  turnOff() {
    this.on = false;
  }
}

class Radio {
  on = false;
  name = "Radio";
  turnOn() {
    this.on = true;
  }
  turnOff() {
    this.on = false;
  }
}

// The abstraction: holds a reference to a device and delegates to it,
// without caring which concrete device it is.
class RemoteControl {
  constructor(device) {
    this.device = device;
  }

  togglePower() {
    if (this.device.on) this.device.turnOff();
    else this.device.turnOn();
    console.log(`${this.device.name} is now ${this.device.on ? "ON" : "OFF"}`);
  }
}

// A second abstraction growing independently of the device hierarchy.
class AdvancedRemoteControl extends RemoteControl {
  mute() {
    if (this.device.on) console.log(`${this.device.name} muted`);
  }
}

// --- demo ---
const tvRemote = new RemoteControl(new Tv());
tvRemote.togglePower();

const radioRemote = new AdvancedRemoteControl(new Radio());
radioRemote.togglePower();
radioRemote.mute();
