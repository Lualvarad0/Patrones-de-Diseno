# Proxy en JavaScript

## El problema, en código

Tu galería carga cien fotos de alta resolución al abrir la pantalla, pero
el usuario puede terminar viendo solo tres. Sin Proxy, crear la lista de
imágenes ya dispara la carga de las cien:

```javascript
const gallery = filenames.map((filename) => new RealImage(filename));
// cada "new RealImage" ya lee el archivo del disco
// las 100 fotos se cargaron aunque el usuario solo vea 3
```

`RealImage` hace el trabajo caro (leer del disco) en su propio
constructor, así que no hay forma de posponer esa carga sin cambiar cómo
se la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`proxy.js`](proxy.js) de esta carpeta: `RealImage` (línea 4) sigue
siendo la clase cara — su constructor llama `#loadFromDisk()` (línea 8).
`ImageProxy` (línea 22) tiene la misma forma (un método `display()`) pero
en el constructor (línea 26) solo guarda el nombre de archivo; el
`RealImage` recién se crea dentro de `display()` (línea 32), la primera
vez que de verdad hace falta mostrarla.

El bloque de demo (línea 39) crea el `ImageProxy` y no pasa nada todavía
(línea 41, "nothing loaded yet"); solo al llamar `image.display()` la
primera vez (línea 42) se dispara la carga real, y la segunda llamada
(línea 43) reutiliza el `RealImage` ya cargado sin tocar el disco de
nuevo.
