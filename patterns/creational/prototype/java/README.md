# Prototype en Java

## El problema, en código

Necesitás una copia independiente de una `Sheep` en varios lugares del
código (un botón de "Duplicar", un endpoint de la API, un test). Sin
Prototype, cada uno de esos lugares arma la copia a mano, campo por campo:

```java
// en tres archivos distintos del proyecto...
Sheep copy = new Sheep(original.name, original.color);
```

Esto funciona hasta que `Sheep` crece: el negocio pide agregar `age` y
`breed`. Vas, agregás los campos a la clase... pero los tres lugares que
copiaban "a mano" siguen copiando solo `name` y `color` — nadie les avisó.
El bug es silencioso: la copia compila y corre perfecto, solo que
`copy.age` queda en su valor por defecto en vez del valor real, y nadie se
da cuenta hasta que alguien nota datos raros en producción.

## Así queda con Prototype aplicado

Mirá [`PrototypeDemo.java`](PrototypeDemo.java) de esta carpeta: `Sheep`
implementa `Cloneable` (línea 3) y sabe copiarse **a sí misma** con
`clone()` (línea 16) — es la única clase que necesita conocer sus propios
campos para copiarlos. Si mañana agregás `age`, el único lugar que hay que
tocar es ese método `clone()`; el `main` y cualquier otro código que llame a
`original.clone()` (línea 29) siguen funcionando sin cambios y reciben la
copia completa automáticamente.

El comentario de la línea 12 también marca algo importante: acá alcanza con
una copia superficial porque `name`/`color` son `String` inmutables: si
`Sheep` tuviera, por ejemplo, una `List<String> vacunas` mutable, `clone()`
necesitaría copiar esa lista también (no solo la referencia), o el original
y el clon terminarían compartiendo — y corrompiendo entre sí — la misma
lista.
