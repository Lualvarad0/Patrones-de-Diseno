// Abstract Factory: one factory interface creates a whole FAMILY of
// related products (button + checkbox), guaranteeing they're never mixed
// across families (no light button with a dark checkbox).
interface Button {
    String render();
}

interface Checkbox {
    String render();
}

class LightButton implements Button {
    public String render() { return "[ Light Button ]"; }
}

class LightCheckbox implements Checkbox {
    public String render() { return "[x] Light Checkbox"; }
}

class DarkButton implements Button {
    public String render() { return "[ Dark Button ]"; }
}

class DarkCheckbox implements Checkbox {
    public String render() { return "[x] Dark Checkbox"; }
}

// The abstract factory: one creation method per product in the family.
interface GuiFactory {
    Button createButton();
    Checkbox createCheckbox();
}

class LightFactory implements GuiFactory {
    public Button createButton() { return new LightButton(); }
    public Checkbox createCheckbox() { return new LightCheckbox(); }
}

class DarkFactory implements GuiFactory {
    public Button createButton() { return new DarkButton(); }
    public Checkbox createCheckbox() { return new DarkCheckbox(); }
}

// The client only talks to GuiFactory — it never knows which theme it got.
class Application {
    private final Button button;
    private final Checkbox checkbox;

    Application(GuiFactory factory) {
        this.button = factory.createButton();
        this.checkbox = factory.createCheckbox();
    }

    void render() {
        System.out.println(button.render());
        System.out.println(checkbox.render());
    }
}

public class AbstractFactoryDemo {
    public static void main(String[] args) {
        Application lightApp = new Application(new LightFactory());
        lightApp.render();

        Application darkApp = new Application(new DarkFactory());
        darkApp.render();
    }
}
