# Proxy en Rust

## El problema, en código

Tu galería carga cien fotos de alta resolución al abrir la pantalla, pero
el usuario puede terminar viendo solo tres. Sin Proxy, crear el vector de
imágenes ya dispara la carga de las cien:

```rust
let gallery: Vec<RealImage> = filenames.iter().map(|f| RealImage::new(f)).collect();
// cada RealImage::new ya lee el archivo del disco
// las 100 fotos se cargaron aunque el usuario solo vea 3
```

`RealImage::new` hace el trabajo caro (leer del disco) apenas se
construye, así que no hay forma de posponer esa carga sin cambiar cómo se
la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`proxy.rs`](proxy.rs) de esta carpeta: `RealImage` (línea 8) sigue
siendo el tipo caro — su constructor `new` (línea 13) imprime el "Loading"
apenas se llama. `ImageProxy` (línea 27) implementa el mismo trait `Image`
(línea 38) pero `ImageProxy::new` (línea 33) solo guarda el nombre de
archivo en `real_image: None`; el `RealImage` recién se crea dentro de
`display()` (línea 41), la primera vez que de verdad hace falta mostrarla.

El `main` (línea 47) crea el `ImageProxy` y no pasa nada todavía (línea
50, "nothing loaded yet"); solo al llamar `image.display()` la primera vez
(línea 51) se dispara la carga real, y la segunda llamada (línea 52)
reutiliza el `RealImage` ya guardado en el `Option` sin tocar el disco de
nuevo.
