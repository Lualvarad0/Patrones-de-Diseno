# Flyweight en COBOL

## El problema, en código

Tu programa dibuja un bosque de miles de árboles, y solo hay un puñado de
especies distintas (pino, roble...). Sin Flyweight, cada entrada del
bosque guardaría su propia copia del nombre y el sprite:

```cobol
*> cada entrada repetiría estos campos en vez de compartir una sola copia
01 forest-entry occurs 10000 times.
    05 x-pos      pic 9(3).
    05 y-pos      pic 9(3).
    05 tree-name  pic x(10).   *> "Pine" repetido miles de veces
    05 tree-sprite pic x(20).  *> el sprite completo, repetido otras miles de veces
```

Si el sprite pesa unos cuantos bytes de más, miles de copias idénticas se
comen la memoria del programa por nada — los datos son los mismos, solo
cambia la posición de cada árbol.

## Así queda con Flyweight aplicado

Mirá [`flyweight.cbl`](flyweight.cbl) de esta carpeta: `tree-type` (línea
8) guarda el nombre y el sprite — el estado pesado y repetido
(intrínseco). `tree-factory::get-tree-type` (línea 63) devuelve siempre la
misma referencia de `tree-type` para un mismo nombre: busca primero en
`type-table` (líneas 73-78) y solo si no existe crea uno nuevo (líneas
80-86). `tree` (línea 96) ya no guarda nombre ni sprite: solo su posición
(`x-pos`, `y-pos`) y una `object reference` compartida a `the-type`
(línea 102) — el estado que sí varía por instancia (extrínseco).

El párrafo principal (línea 145) pide dos árboles "Pine" y uno "Oak": la
segunda llamada a `"get-tree-type"` con "Pine" (línea 155) encuentra la
referencia ya guardada en `type-table` y la reusa, sin mostrar "Created
new TreeType" (comentario en línea 157).
