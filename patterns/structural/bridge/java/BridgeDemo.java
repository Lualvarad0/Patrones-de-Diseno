// Bridge: splits "remote control" (the abstraction) from "device" (the
// implementation) into two independent hierarchies joined by composition,
// so each one can grow on its own without a subclass explosion.
interface Device {
    boolean isOn();
    void turnOn();
    void turnOff();
    String getName();
}

class Tv implements Device {
    private boolean on = false;
    public boolean isOn() { return on; }
    public void turnOn() { on = true; }
    public void turnOff() { on = false; }
    public String getName() { return "TV"; }
}

class Radio implements Device {
    private boolean on = false;
    public boolean isOn() { return on; }
    public void turnOn() { on = true; }
    public void turnOff() { on = false; }
    public String getName() { return "Radio"; }
}

// The abstraction: holds a reference to a device and delegates to it,
// without caring which concrete device it is.
class RemoteControl {
    protected final Device device;
    RemoteControl(Device device) { this.device = device; }

    void togglePower() {
        if (device.isOn()) device.turnOff(); else device.turnOn();
        System.out.println(device.getName() + " is now " + (device.isOn() ? "ON" : "OFF"));
    }
}

// A second abstraction growing independently of the device hierarchy.
class AdvancedRemoteControl extends RemoteControl {
    AdvancedRemoteControl(Device device) { super(device); }

    void mute() {
        if (device.isOn()) System.out.println(device.getName() + " muted");
    }
}

public class BridgeDemo {
    public static void main(String[] args) {
        RemoteControl tvRemote = new RemoteControl(new Tv());
        tvRemote.togglePower();

        AdvancedRemoteControl radioRemote = new AdvancedRemoteControl(new Radio());
        radioRemote.togglePower();
        radioRemote.mute();
    }
}
