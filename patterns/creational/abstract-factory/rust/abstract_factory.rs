// Abstract Factory: one factory trait creates a whole FAMILY of related
// products (button + checkbox), guaranteeing they're never mixed across
// families (no light button with a dark checkbox).
trait Button {
    fn render(&self) -> String;
}
trait Checkbox {
    fn render(&self) -> String;
}

struct LightButton;
impl Button for LightButton {
    fn render(&self) -> String {
        "[ Light Button ]".to_string()
    }
}
struct LightCheckbox;
impl Checkbox for LightCheckbox {
    fn render(&self) -> String {
        "[x] Light Checkbox".to_string()
    }
}

struct DarkButton;
impl Button for DarkButton {
    fn render(&self) -> String {
        "[ Dark Button ]".to_string()
    }
}
struct DarkCheckbox;
impl Checkbox for DarkCheckbox {
    fn render(&self) -> String {
        "[x] Dark Checkbox".to_string()
    }
}

// The abstract factory trait: one creation method per product in the family.
trait GuiFactory {
    fn create_button(&self) -> Box<dyn Button>;
    fn create_checkbox(&self) -> Box<dyn Checkbox>;
}

struct LightFactory;
impl GuiFactory for LightFactory {
    fn create_button(&self) -> Box<dyn Button> {
        Box::new(LightButton)
    }
    fn create_checkbox(&self) -> Box<dyn Checkbox> {
        Box::new(LightCheckbox)
    }
}

struct DarkFactory;
impl GuiFactory for DarkFactory {
    fn create_button(&self) -> Box<dyn Button> {
        Box::new(DarkButton)
    }
    fn create_checkbox(&self) -> Box<dyn Checkbox> {
        Box::new(DarkCheckbox)
    }
}

// The client only talks to the GuiFactory trait — it never knows which
// theme it got.
struct Application {
    button: Box<dyn Button>,
    checkbox: Box<dyn Checkbox>,
}

impl Application {
    fn new(factory: &dyn GuiFactory) -> Self {
        Application {
            button: factory.create_button(),
            checkbox: factory.create_checkbox(),
        }
    }

    fn render(&self) {
        println!("{}", self.button.render());
        println!("{}", self.checkbox.render());
    }
}

fn main() {
    Application::new(&LightFactory).render();
    Application::new(&DarkFactory).render();
}
