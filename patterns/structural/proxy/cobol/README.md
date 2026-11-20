# Proxy en COBOL

## El problema, en código

Tu programa carga cien fotos de alta resolución al abrir la galería, pero
el usuario puede terminar viendo solo tres. Sin Proxy, el párrafo que
arma la lista de imágenes ya dispara la carga de las cien:

```cobol
perform varying i from 1 by 1 until i > filename-count
    invoke real-image "new" returning img-entry(i)
    invoke img-entry(i) "init" using filename-entry(i)
    *> "init" ya hace la carga cara (display "Loading ... from disk...")
end-perform
*> las 100 fotos se cargaron aunque el usuario solo vea 3
```

El método `"init"` de `real-image` hace el trabajo caro (leer del disco)
apenas se invoca, así que no hay forma de posponer esa carga sin cambiar
cómo se la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`proxy.cbl`](proxy.cbl) de esta carpeta: `real-image` (línea 8)
sigue siendo la clase cara — su método `init` (línea 17) muestra el
mensaje de "Loading" apenas se invoca. `image-proxy` (línea 36) expone el
mismo método `"display"` (línea 57) pero su `init` (línea 50) solo guarda
el nombre de archivo en `the-filename`, dejando `the-real-image` en
`null` (línea 46); el `real-image` recién se crea dentro de `display`
(líneas 59-62), la primera vez que de verdad hace falta mostrarla.

El párrafo principal (línea 81) crea el `image-proxy` y no pasa nada
todavía (línea 85, "nothing loaded yet"); solo la primera invocación de
`"display"` (línea 86) dispara la carga real, y la segunda (línea 88)
reutiliza el `real-image` ya guardado en `the-real-image` sin tocar el
disco de nuevo.
