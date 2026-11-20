# Abstract Factory en C++

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
componente de la UI decida su propia clase según una variable global
`currentTheme`:

```cpp
class Application {
public:
    Application() {
        auto button = currentTheme == "dark" ? std::make_unique<DarkButton>()
                                              : std::make_unique<LightButton>();
        // alguien copia y pega esta línea para el checkbox, y se equivoca:
        auto checkbox = std::make_unique<LightCheckbox>(); // ¡olvidó chequear el tema!
    }
};
```

Nada impide que el checkbox quede "claro" mientras el botón quedó "oscuro",
porque cada widget decide su propia clase por su cuenta, en un `if`
separado. Con 2 widgets el error ya es real; con una pantalla de 10
widgets, un copy-paste apurado deja la UI con componentes de dos temas
mezclados — un bug visual que nadie detecta hasta que un usuario manda una
captura de pantalla rara.

## Así queda con Abstract Factory aplicado

Mirá [`abstract_factory.cpp`](abstract_factory.cpp) de esta carpeta:
`GuiFactory` (línea 37) agrupa **ambos** métodos de creación
(`createButton` y `createCheckbox`) en una sola clase abstracta, y
`LightFactory`/`DarkFactory` (líneas 44 y 50) implementan los dos juntos —
es imposible pedirle a `LightFactory` un checkbox oscuro, porque esa clase
ni siquiera construye un `DarkCheckbox`.

`Application` (línea 57) recibe **una única** `GuiFactory` en su
constructor (línea 59) y le pide los dos widgets a esa misma fábrica en la
lista de inicialización (línea 60) — no hay forma de mezclar: lo que sea
que `factory` sea (clara u oscura), los dos widgets salen de la misma
familia. El `main` (líneas 73 y 76) lo confirma creando una `Application`
completa por tema, sin ningún `if` por widget.
