# Bridge en COBOL

## El problema, en código

Tenés una clase `remote-control` básica y una `advanced-remote-control` (que
agrega `mute`), y necesitás que ambas funcionen con `tv` y con `radio`. Si
cada control guardara el dispositivo concreto por dentro en vez de una
referencia genérica, terminarías con una clase por cada combinación:

```cobol
*> class-id. tv-remote-control.      *> conoce tv por dentro
*> class-id. radio-remote-control.   *> conoce radio por dentro
*> class-id. advanced-tv-remote-control inherits tv-remote-control.
*> class-id. advanced-radio-remote-control inherits radio-remote-control.
*> agregás un dispositivo (speaker) y ya necesitás
*> speaker-remote-control + advanced-speaker-remote-control
```

Cada dispositivo nuevo duplica toda la jerarquía de controles, y cada
control nuevo duplica toda la jerarquía de dispositivos: dos dimensiones
que crecen multiplicadas entre sí.

## Así queda con Bridge aplicado

Mirá [`bridge.cbl`](bridge.cbl) de esta carpeta: `remote-control` (línea 74)
no conoce `tv` ni `radio` — guarda en `device` (línea 78) una `object
reference` genérica, recibida en `init` (líneas 82-87), y delega en ella
por mensaje (`invoke device "is-on"`, línea 100). `advanced-remote-control`
(línea 120) **hereda** de `remote-control` con `inherits` y agrega `mute`
(líneas 125-137), que llega al dispositivo a través de `get-device`
(línea 90), un método que la clase base expone justamente para que las
subclases puedan reusar ese mismo `device` sin duplicarlo.

El párrafo principal (línea 144) arma las combinaciones que necesita
simplemente invocando `"init"` con el dispositivo que corresponda:
`invoke tv-remote "init" using tv-device` o `invoke radio-remote "init"
using radio-device` (líneas 163 y 168). Para sumar un dispositivo
`speaker` solo haría falta otra `class-id` con los mismos cuatro métodos
(`turn-on`, `turn-off`, `is-on`, `get-name`) — cero clases nuevas de
control.
