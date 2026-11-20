# Abstract Factory en Java

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
componente de la UI decida su propia clase según una variable global
`currentTheme`:

```java
class Application {
    Application() {
        Button button = currentTheme.equals("dark") ? new DarkButton() : new LightButton();
        // alguien copia y pega esta línea para el checkbox, y se equivoca:
        Checkbox checkbox = new LightCheckbox(); // <-- olvidó chequear el tema!
    }
}
```

Nada impide que el checkbox quede "claro" mientras el botón quedó "oscuro",
porque cada widget decide su propia clase por su cuenta, en un `if`
separado. Con 2 widgets el error ya es real; con una pantalla de 10
widgets, un copy-paste apurado deja la UI con componentes de dos temas
mezclados — un bug visual que nadie detecta hasta que un usuario manda una
captura de pantalla rara.

## Así queda con Abstract Factory aplicado

Mirá [`AbstractFactoryDemo.java`](AbstractFactoryDemo.java) de esta carpeta:
`GuiFactory` (línea 29) agrupa **ambos** métodos de creación
(`createButton` y `createCheckbox`) en una sola interfaz, y
`LightFactory`/`DarkFactory` (líneas 34 y 39) implementan los dos juntos —
es imposible pedirle a `LightFactory` un checkbox oscuro, porque esa clase
ni siquiera conoce `DarkCheckbox`.

`Application` (línea 45) recibe **una única** `GuiFactory` en su
constructor (línea 49) y le pide los dos widgets a esa misma fábrica
(líneas 50-51) — no hay forma de mezclar: lo que sea que `factory` sea
(clara u oscura), los dos widgets salen de la misma familia. El `main`
(líneas 62 y 65) lo confirma creando una `Application` completa por tema,
sin ningún `if` por widget.
