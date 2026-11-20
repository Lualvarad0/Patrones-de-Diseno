// Abstract Factory: one factory interface creates a whole FAMILY of
// related products (button + checkbox), guaranteeing they're never mixed
// across families (no light button with a dark checkbox).
#include <iostream>
#include <memory>
#include <string>

class Button {
public:
    virtual std::string render() const = 0;
    virtual ~Button() = default;
};
class Checkbox {
public:
    virtual std::string render() const = 0;
    virtual ~Checkbox() = default;
};

class LightButton : public Button {
public:
    std::string render() const override { return "[ Light Button ]"; }
};
class LightCheckbox : public Checkbox {
public:
    std::string render() const override { return "[x] Light Checkbox"; }
};
class DarkButton : public Button {
public:
    std::string render() const override { return "[ Dark Button ]"; }
};
class DarkCheckbox : public Checkbox {
public:
    std::string render() const override { return "[x] Dark Checkbox"; }
};

// The abstract factory: one creation method per product in the family.
class GuiFactory {
public:
    virtual std::unique_ptr<Button> createButton() const = 0;
    virtual std::unique_ptr<Checkbox> createCheckbox() const = 0;
    virtual ~GuiFactory() = default;
};

class LightFactory : public GuiFactory {
public:
    std::unique_ptr<Button> createButton() const override { return std::make_unique<LightButton>(); }
    std::unique_ptr<Checkbox> createCheckbox() const override { return std::make_unique<LightCheckbox>(); }
};

class DarkFactory : public GuiFactory {
public:
    std::unique_ptr<Button> createButton() const override { return std::make_unique<DarkButton>(); }
    std::unique_ptr<Checkbox> createCheckbox() const override { return std::make_unique<DarkCheckbox>(); }
};

// The client only talks to GuiFactory — it never knows which theme it got.
class Application {
public:
    explicit Application(const GuiFactory& factory)
        : button(factory.createButton()), checkbox(factory.createCheckbox()) {}

    void render() const {
        std::cout << button->render() << std::endl;
        std::cout << checkbox->render() << std::endl;
    }

private:
    std::unique_ptr<Button> button;
    std::unique_ptr<Checkbox> checkbox;
};

int main() {
    Application lightApp(LightFactory{});
    lightApp.render();

    Application darkApp(DarkFactory{});
    darkApp.render();

    return 0;
}
