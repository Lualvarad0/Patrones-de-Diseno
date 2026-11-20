# Abstract Factory en PHP

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
componente de la UI decida su propia clase según una variable global
`$currentTheme`:

```php
class Application
{
    public function __construct()
    {
        $button = $currentTheme === 'dark' ? new DarkButton() : new LightButton();
        // alguien copia y pega esta línea para el checkbox, y se equivoca:
        $checkbox = new LightCheckbox(); // ¡olvidó chequear el tema!
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

Mirá [`AbstractFactory.php`](AbstractFactory.php) de esta carpeta:
`GuiFactory` (línea 32) agrupa **ambos** métodos de creación
(`createButton` y `createCheckbox`) en una sola interfaz, y
`LightFactory`/`DarkFactory` (líneas 38 y 44) implementan los dos juntos —
es imposible pedirle a `LightFactory` un checkbox oscuro, porque esa clase
ni siquiera menciona `DarkCheckbox`.

`Application` (línea 51) recibe **una única** `GuiFactory` en su
constructor (línea 56) y le pide los dos widgets a esa misma fábrica
(líneas 58-59) — no hay forma de mezclar: lo que sea que `$factory` sea
(clara u oscura), los dos widgets salen de la misma familia. El bloque de
demo (líneas 70-71) lo confirma creando una `Application` completa por
tema, sin ningún `if` por widget.
