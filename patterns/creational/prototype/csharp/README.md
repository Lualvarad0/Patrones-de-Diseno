# Prototype en C#

## El problema, en código

Necesitás una copia independiente de una `Sheep` en varios lugares del
código (un botón de "Duplicar", un endpoint de la API, un test). Sin
Prototype, cada uno de esos lugares arma la copia a mano, campo por campo:

```csharp
// en tres archivos distintos del proyecto...
var copy = new Sheep(original.Name, original.Color);
```

Esto funciona hasta que `Sheep` crece: el negocio pide agregar `Age` y
`Breed`. Vas, agregás los campos a la clase... pero los tres lugares que
copiaban "a mano" siguen copiando solo `Name` y `Color` — nadie les avisó.
El bug es silencioso: la copia compila y corre perfecto, solo que
`copy.Age` queda en su valor por defecto en vez del valor real, y nadie se
da cuenta hasta que alguien nota datos raros en producción.

## Así queda con Prototype aplicado

Mirá [`Program.cs`](Program.cs) de esta carpeta: `Sheep` implementa
`ICloneable` (línea 3) y sabe copiarse **a sí misma** con `Clone()` (línea
17) — es la única clase que necesita conocer sus propios campos para
copiarlos. Si mañana agregás `Age`, el único lugar que hay que tocar es ese
método `Clone()`; los `Main` y cualquier otro código que llame a
`original.Clone()` (línea 27) siguen funcionando sin cambios y reciben la
copia completa automáticamente.

El comentario de la línea 14 también marca algo importante: acá alcanza con
una copia superficial porque `Name`/`Color` son strings inmutables: si
`Sheep` tuviera, por ejemplo, una `List<string> Vacunas` mutable, `Clone()`
necesitaría copiar esa lista también (no solo la referencia), o el original
y el clon terminarían compartiendo — y corrompiendo entre sí — la misma
lista.
