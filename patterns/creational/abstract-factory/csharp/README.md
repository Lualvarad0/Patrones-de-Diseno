# Abstract Factory en C#

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
componente de la UI decida su propia clase según una variable global
`currentTheme`:

```csharp
public class Application
{
    public Application()
    {
        IButton button = currentTheme == "dark" ? new DarkButton() : new LightButton();
        // alguien copia y pega esta línea para el checkbox, y se equivoca:
        ICheckbox checkbox = new LightCheckbox(); // <-- olvidó chequear el tema!
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

Mirá [`Program.cs`](Program.cs) de esta carpeta: `IGuiFactory` (línea 35)
agrupa **ambos** métodos de creación (`CreateButton` y `CreateCheckbox`) en
una sola interfaz, y `LightFactory`/`DarkFactory` (líneas 41 y 47)
implementan los dos juntos — es imposible pedirle a `LightFactory` un
checkbox oscuro, porque esa clase ni siquiera conoce `DarkCheckbox`.

`Application` (línea 54) recibe **una única** `IGuiFactory` en su
constructor (línea 59) y le pide los dos widgets a esa misma fábrica
(líneas 61-62) — no hay forma de mezclar: lo que sea que `factory` sea
(clara u oscura), los dos widgets salen de la misma familia. El `Main`
(líneas 76 y 79) lo confirma creando una `Application` completa por tema,
sin ningún `if` por widget.
