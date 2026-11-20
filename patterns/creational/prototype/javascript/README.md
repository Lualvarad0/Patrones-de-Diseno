# Prototype en JavaScript

## El problema, en código

Necesitás una copia independiente de una `Sheep` en varios lugares del
código (un botón de "Duplicar", un endpoint de la API, un test). Sin
Prototype, cada uno de esos lugares arma la copia a mano, campo por campo:

```js
// en tres archivos distintos del proyecto...
const copy = new Sheep(original.name, original.color);
// o, con spread, la misma trampa en otra forma:
const copy2 = { ...original };
```

Esto funciona hasta que `Sheep` crece: el negocio pide agregar `age` y
`breed`. Vas, agregás los campos a la clase... pero los tres lugares que
copiaban "a mano" siguen copiando solo `name` y `color` — nadie les avisó.
El bug es silencioso: la copia corre perfecto, solo que `copy.age` queda
`undefined` en vez del valor real, y nadie se da cuenta hasta que alguien
nota datos raros en producción.

## Así queda con Prototype aplicado

Mirá [`prototype.js`](prototype.js) de esta carpeta: `Sheep` sabe copiarse
**a sí misma** con `clone()` (línea 13) — es la única clase que necesita
conocer sus propios campos para copiarlos. Si mañana agregás `age`, el
único lugar que hay que tocar es ese método `clone()`; el bloque de demo y
cualquier otro código que llame a `original.clone()` (línea 24) siguen
funcionando sin cambios y reciben la copia completa automáticamente.

El comentario de las líneas 9-12 también marca algo importante: acá
alcanza con una copia superficial porque `name`/`color` son strings
inmutables: si `Sheep` tuviera, por ejemplo, un array `vacunas` mutable,
`clone()` necesitaría copiar ese array también (no solo la referencia), o
el original y el clon terminarían compartiendo — y corrompiendo entre sí —
el mismo array.
