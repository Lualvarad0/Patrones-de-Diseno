# Proxy en PHP

## El problema, en código

Tu galería carga cien fotos de alta resolución al abrir la pantalla, pero
el usuario puede terminar viendo solo tres. Sin Proxy, crear el arreglo de
imágenes ya dispara la carga de las cien:

```php
$gallery = array_map(fn($filename) => new RealImage($filename), $filenames);
// cada "new RealImage" ya lee el archivo del disco
// las 100 fotos se cargaron aunque el usuario solo vea 3
```

`RealImage` hace el trabajo caro (leer del disco) en su propio
constructor, así que no hay forma de posponer esa carga sin cambiar cómo
se la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`Proxy.php`](Proxy.php) de esta carpeta: `RealImage` (línea 10)
sigue siendo la clase cara — su constructor llama `loadFromDisk()` (línea
14). `ImageProxy` (línea 30) implementa la misma interfaz `Image` (línea
5) pero su constructor (línea 34) solo guarda el nombre de archivo; el
`RealImage` recién se crea dentro de `display()` (línea 38), la primera
vez que de verdad hace falta mostrarla.

El bloque de demo (línea 46) crea el `ImageProxy` y no pasa nada todavía
(línea 48, "nothing loaded yet"); solo al llamar `$image->display()` la
primera vez (línea 49) se dispara la carga real, y la segunda llamada
(línea 50) reutiliza el `RealImage` ya cargado sin tocar el disco de
nuevo.
