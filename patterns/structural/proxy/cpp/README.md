# Proxy en C++

## El problema, en código

Tu galería carga cien fotos de alta resolución al abrir la pantalla, pero
el usuario puede terminar viendo solo tres. Sin Proxy, crear el vector de
imágenes ya dispara la carga de las cien:

```cpp
std::vector<RealImage> gallery;
for (const auto& filename : filenames)
    gallery.emplace_back(filename); // cada construcción ya lee el archivo del disco
// las 100 fotos se cargaron aunque el usuario solo vea 3
```

`RealImage` hace el trabajo caro (leer del disco) en su propio
constructor, así que no hay forma de posponer esa carga sin cambiar cómo
se la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`proxy.cpp`](proxy.cpp) de esta carpeta: `RealImage` (línea 14)
sigue siendo la clase cara — su constructor llama `loadFromDisk()` (línea
17). `ImageProxy` (línea 34) hereda de la misma clase abstracta `Image`
(línea 8) pero su constructor (línea 36) solo guarda el nombre de archivo;
el `RealImage` recién se crea dentro de `display()` (línea 40), la
primera vez que de verdad hace falta mostrarla, guardado en un
`unique_ptr` (línea 47).

El `main` (línea 50) crea el `ImageProxy` y no pasa nada todavía (línea
53, "nothing loaded yet"); solo al llamar `image->display()` la primera
vez (línea 54) se dispara la carga real, y la segunda llamada (línea 55)
reutiliza el `RealImage` ya cargado sin tocar el disco de nuevo.
