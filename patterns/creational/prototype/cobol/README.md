# Prototype en COBOL

## El problema, en código

Necesitás una copia independiente de una `sheep` en varios lugares del
código (un programa de reportes, un batch de duplicado, un test). Sin
Prototype, cada uno de esos lugares arma la copia a mano, campo por campo:

```cobol
*> en tres programas distintos...
invoke sheep "new" returning copy
invoke copy "init" using the-name the-color
```

Esto funciona hasta que `sheep` crece: el negocio pide agregar `the-age` y
`the-breed`. Vas, agregás los campos a la clase y al método `init`... pero
los tres programas que copiaban "a mano" siguen llamando a `init` con solo
nombre y color — nadie les avisó. El bug es silencioso: el programa compila
y corre perfecto, solo que la copia queda con la edad en blanco en vez del
valor real, y nadie se da cuenta hasta que alguien nota datos raros en el
reporte.

## Así queda con Prototype aplicado

Mirá [`prototype.cbl`](prototype.cbl) de esta carpeta: la clase `sheep`
sabe copiarse **a sí misma** con el método `clone` (línea 41) — es la única
clase que necesita conocer sus propios campos para copiarlos, armando una
`sheep` nueva e invocando su propio `init` con sus propios valores
(líneas 45-46). Si mañana agregás `the-age`, el único lugar que hay que
tocar es ese método `clone`; el párrafo principal y cualquier otro
programa que llame a `invoke original "clone" returning the-clone` (línea
82) siguen funcionando sin cambios y reciben la copia completa
automáticamente.

El comentario de las líneas 38-40 también marca algo importante: acá
alcanza con una copia superficial porque `the-name`/`the-color` son campos
alfanuméricos simples — si `sheep` guardara una referencia a otro objeto
compartido, `clone` necesitaría clonar también ese objeto referenciado, o
el original y la copia terminarían compartiendo (y corrompiendo entre sí)
la misma referencia.
