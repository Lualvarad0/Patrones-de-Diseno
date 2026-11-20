// Bridge: splits "remote control" (the abstraction) from "device" (the
// implementation) into two independent hierarchies joined by composition,
// so each one can grow on its own without a subclass explosion.
#include <iostream>
#include <memory>
#include <string>

class Device {
public:
    virtual bool isOn() const = 0;
    virtual void turnOn() = 0;
    virtual void turnOff() = 0;
    virtual std::string name() const = 0;
    virtual ~Device() = default;
};

class Tv : public Device {
public:
    bool isOn() const override { return on; }
    void turnOn() override { on = true; }
    void turnOff() override { on = false; }
    std::string name() const override { return "TV"; }
private:
    bool on = false;
};

class Radio : public Device {
public:
    bool isOn() const override { return on; }
    void turnOn() override { on = true; }
    void turnOff() override { on = false; }
    std::string name() const override { return "Radio"; }
private:
    bool on = false;
};

// The abstraction: holds a device and delegates to it, without caring
// which concrete device it is.
class RemoteControl {
public:
    explicit RemoteControl(std::unique_ptr<Device> device) : device(std::move(device)) {}

    void togglePower() {
        if (device->isOn()) device->turnOff(); else device->turnOn();
        std::cout << device->name() << " is now " << (device->isOn() ? "ON" : "OFF") << std::endl;
    }

protected:
    std::unique_ptr<Device> device;
};

// A second abstraction growing independently of the device hierarchy.
class AdvancedRemoteControl : public RemoteControl {
public:
    explicit AdvancedRemoteControl(std::unique_ptr<Device> device) : RemoteControl(std::move(device)) {}

    void mute() {
        if (device->isOn()) std::cout << device->name() << " muted" << std::endl;
    }
};

int main() {
    RemoteControl tvRemote(std::make_unique<Tv>());
    tvRemote.togglePower();

    AdvancedRemoteControl radioRemote(std::make_unique<Radio>());
    radioRemote.togglePower();
    radioRemote.mute();

    return 0;
}
