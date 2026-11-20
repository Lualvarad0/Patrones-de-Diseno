# Proxy en Java

## El problema, en código

Tu galería carga cien fotos de alta resolución al abrir la pantalla, pero
el usuario puede terminar viendo solo tres. Sin Proxy, crear la lista de
imágenes ya dispara la carga de las cien:

```java
List<RealImage> gallery = new ArrayList<>();
for (String filename : filenames)
    gallery.add(new RealImage(filename)); // cada new ya lee el archivo del disco
// las 100 fotos se cargaron aunque el usuario solo vea 3
```

`RealImage` hace el trabajo caro (leer del disco) en su propio
constructor, así que no hay forma de posponer esa carga sin cambiar cómo
se la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`ProxyDemo.java`](ProxyDemo.java) de esta carpeta: `RealImage`
(línea 8) sigue siendo la clase cara — su constructor llama
`loadFromDisk()` (línea 13). `ImageProxy` (línea 23) implementa la misma
interfaz `Image` (línea 4) pero en el constructor (línea 27) solo guarda
el nombre de archivo; el `RealImage` recién se crea dentro de
`display()` (línea 31), la primera vez que de verdad hace falta mostrarla.

El `main` (línea 38) crea el `ImageProxy` y no pasa nada todavía (línea
41, "nothing loaded yet"); solo al llamar `image.display()` la primera vez
(línea 42) se dispara la carga real, y la segunda llamada (línea 43)
reutiliza el `RealImage` ya cargado sin tocar el disco de nuevo.
