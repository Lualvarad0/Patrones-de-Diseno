# Abstract Factory en JavaScript

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
componente de la UI decida su propia clase según una variable global
`currentTheme`:

```js
class Application {
  constructor() {
    const button = currentTheme === "dark" ? new DarkButton() : new LightButton();
    // alguien copia y pega esta línea para el checkbox, y se equivoca:
    const checkbox = new LightCheckbox(); // <-- olvidó chequear el tema!
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

Mirá [`abstract-factory.js`](abstract-factory.js) de esta carpeta:
`LightFactory` y `DarkFactory` (líneas 26 y 35) agrupan **ambos** métodos de
creación (`createButton` y `createCheckbox`) en un solo objeto — es
imposible pedirle a `LightFactory` un checkbox oscuro, porque esa clase ni
siquiera conoce `DarkCheckbox`.

`Application` (línea 46) recibe **una única** fábrica en su constructor
(línea 47) y le pide los dos widgets a esa misma fábrica (líneas 48-49) —
no hay forma de mezclar: lo que sea que `factory` sea (clara u oscura), los
dos widgets salen de la misma familia. El bloque de demo (líneas 59-60) lo
confirma creando una `Application` completa por tema, sin ningún `if` por
widget.
