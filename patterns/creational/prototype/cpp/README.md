# Prototype en C++

## El problema, en código

Necesitás una copia independiente de una `Sheep` en varios lugares del
código (un comando de "Duplicar", un endpoint, un test). Sin Prototype,
cada uno de esos lugares arma la copia a mano, campo por campo:

```cpp
// en tres archivos distintos del proyecto...
auto copy = std::make_unique<Sheep>(original.getName(), original.getColor());
```

Esto funciona hasta que `Sheep` crece: el negocio pide agregar `age` y
`breed`. Vas, agregás los campos a la clase... pero los tres lugares que
copiaban "a mano" siguen copiando solo nombre y color — nadie les avisó. El
bug es silencioso: la copia compila y corre perfecto, solo que `age` queda
en su valor por defecto en vez del valor real, y nadie se da cuenta hasta
que alguien nota datos raros en producción.

## Así queda con Prototype aplicado

Mirá [`prototype.cpp`](prototype.cpp) de esta carpeta: `Sheep` sabe
copiarse **a sí misma** con `clone()` (línea 14) — es la única clase que
necesita conocer sus propios campos para copiarlos. Si mañana agregás
`age`, el único lugar que hay que tocar es ese método `clone()`; el `main`
y cualquier otro código que llame a `original.clone()` (línea 31) siguen
funcionando sin cambios y reciben la copia completa automáticamente.

El comentario de las líneas 11-13 también marca algo importante: acá
alcanza con una copia superficial porque `name`/`color` son `std::string`
con su propio valor: si `Sheep` tuviera, por ejemplo, un `std::shared_ptr`
a datos mutables, `clone()` necesitaría decidir si copiar esos datos de
verdad o solo el puntero — copiar solo el puntero dejaría al original y al
clon compartiendo (y corrompiendo entre sí) el mismo dato.
