# Chain of Responsibility en JavaScript

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, una sola función concentra
todas las reglas de escalamiento:

```javascript
function handleTicket(severity) {
  if (severity <= 1) console.log(`Level1 resolved severity ${severity}`);
  else if (severity <= 2) console.log(`Level2 resolved severity ${severity}`);
  else if (severity <= 3) console.log(`Level3 resolved severity ${severity}`);
  else console.log(`No handler could resolve severity ${severity}`);
  // agregar un Level4 significa editar esta función y
  // repetir el mismo patrón en cualquier otro lugar que escale tickets
}
```

Esta función tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier lugar del código que necesite la misma lógica de escalamiento la
termina copiando.

## Así queda con Chain of Responsibility aplicado

Mirá [`chain-of-responsibility.js`](chain-of-responsibility.js) de esta
carpeta: `SupportHandler` (línea 4) define `handle()` (línea 12) una sola
vez — si `this.canHandle()` es verdadero, resuelve; si no, delega en
`this.next` (línea 16). Cada nivel (`Level1Support`, línea 23;
`Level2Support`, línea 32; `Level3Support`, línea 41) solo implementa su
propio umbral, sin saber nada de los demás niveles.

El bloque de demo (línea 51) arma la cadena con `setNext()` (línea 54):
`level1.setNext(level2).setNext(level3)`. Después solo llama
`level1.handle(severity)` (líneas 56-59); cada handler decide solo si le
toca a él o lo pasa al siguiente. Agregar un `Level4Support` es una clase
nueva y una línea en la cadena — cero cambios en `handle()`.
