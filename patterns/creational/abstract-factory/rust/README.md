# Abstract Factory en Rust

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
componente de la UI decida su propio tipo según una variable global
`current_theme`:

```rust
struct Application;
impl Application {
    fn new() {
        let button: Box<dyn Button> = if current_theme == "dark" {
            Box::new(DarkButton)
        } else {
            Box::new(LightButton)
        };
        // alguien copia y pega esta línea para el checkbox, y se equivoca:
        let checkbox: Box<dyn Checkbox> = Box::new(LightCheckbox); // ¡olvidó chequear el tema!
    }
}
```

Nada impide que el checkbox quede "claro" mientras el botón quedó "oscuro",
porque cada widget decide su propio tipo por su cuenta, en un `if` separado.
Con 2 widgets el error ya es real; con una pantalla de 10 widgets, un
copy-paste apurado deja la UI con componentes de dos temas mezclados — un
bug visual que nadie detecta hasta que un usuario manda una captura de
pantalla rara.

## Así queda con Abstract Factory aplicado

Mirá [`abstract_factory.rs`](abstract_factory.rs) de esta carpeta: el trait
`GuiFactory` (línea 38) agrupa **ambos** métodos de creación
(`create_button` y `create_checkbox`), y `LightFactory`/`DarkFactory`
(líneas 43 y 53) implementan los dos juntos — es imposible pedirle a
`LightFactory` un checkbox oscuro, porque esa implementación ni siquiera
construye un `DarkCheckbox`.

`Application` (línea 65) recibe **una única** referencia `&dyn GuiFactory`
en `new` (línea 71) y le pide los dos widgets a esa misma fábrica (líneas
73-74) — no hay forma de mezclar: lo que sea que `factory` sea (clara u
oscura), los dos widgets salen de la misma familia. El `main` (líneas 85 y
86) lo confirma creando una `Application` completa por tema, sin ningún
`if` por widget.
