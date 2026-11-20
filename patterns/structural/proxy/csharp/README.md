# Proxy en C#

## El problema, en código

Tu galería carga cien fotos de alta resolución al abrir la pantalla, pero
el usuario puede terminar viendo solo tres. Sin Proxy, crear la lista de
imágenes ya dispara la carga de las cien:

```csharp
var gallery = new List<RealImage>();
foreach (var filename in filenames)
    gallery.Add(new RealImage(filename)); // cada new ya lee el archivo del disco
// las 100 fotos se cargaron aunque el usuario solo vea 3
```

`RealImage` hace el trabajo caro (leer del disco) en su propio
constructor, así que no hay forma de posponer esa carga sin cambiar cómo
se la usa en todos lados.

## Así queda con Proxy aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `RealImage` (línea 9)
sigue siendo la clase cara — su constructor llama `LoadFromDisk()` (línea
16). `ImageProxy` (línea 26) implementa la misma interfaz `IImage` (línea
4) pero en el constructor (línea 31) solo guarda el nombre de archivo; el
`RealImage` recién se crea dentro de `Display()` (línea 35), la primera
vez que de verdad hace falta mostrarla.

El `Main` (línea 42) crea el `ImageProxy` y no pasa nada todavía (línea
46, "nothing loaded yet"); solo al llamar `image.Display()` la primera vez
(línea 47) se dispara la carga real, y la segunda llamada (línea 48)
reutiliza el `RealImage` ya cargado sin tocar el disco de nuevo.
