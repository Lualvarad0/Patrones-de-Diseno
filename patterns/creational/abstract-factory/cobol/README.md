# Abstract Factory en COBOL

## El problema, en código

Tu app tiene un tema claro y uno oscuro. El primer intento es que cada
widget se decida por separado según una variable `current-theme`:

```cobol
if current-theme = "DARK"
    invoke dark-button "new" returning the-button
else
    invoke light-button "new" returning the-button
end-if

*> alguien copia y pega esto para el checkbox, y se equivoca:
invoke light-checkbox "new" returning the-checkbox   *> ¡olvidó chequear el tema!
```

Nada impide que el checkbox quede "claro" mientras el botón quedó "oscuro",
porque cada widget se crea por separado, con su propio `if`. Con 2 widgets
el error ya es real; con una pantalla de 10 widgets, un copy-paste apurado
deja la UI con componentes de dos temas mezclados — un bug visual que nadie
detecta hasta que un usuario manda una captura de pantalla rara.

## Así queda con Abstract Factory aplicado

Mirá [`abstract_factory.cbl`](abstract_factory.cbl) de esta carpeta:
`light-factory` y `dark-factory` (líneas 56 y 82) agrupan **ambos** métodos
de creación (`create-button` y `create-checkbox`) en la misma clase — es
imposible pedirle a `light-factory` un checkbox oscuro, porque esa clase ni
siquiera tiene `dark-checkbox` en su `repository` (línea 87-88).

`application` (línea 108) recibe **una única** referencia a fábrica en su
método `init` (línea 117) y le pide los dos widgets a esa misma fábrica
(líneas 121-122) — no hay forma de mezclar: lo que sea que `factory` sea
(clara u oscura), los dos widgets salen de la misma familia. El párrafo
principal (líneas 154 y 159) lo confirma creando una `application` completa
por tema, sin ningún `if` por widget.
