# Chain of Responsibility en COBOL

## El problema, en código

Un ticket de soporte tiene que resolverse en el nivel que corresponda según
su severidad. Sin Chain of Responsibility, un solo párrafo concentra todas
las reglas de escalamiento:

```cobol
*> un único párrafo con todos los umbrales juntos
if severity <= 1
    display "Level1 resolved severity " severity
else
    if severity <= 2
        display "Level2 resolved severity " severity
    else
        if severity <= 3
            display "Level3 resolved severity " severity
        else
            display "No handler could resolve severity " severity
        end-if
    end-if
end-if
*> agregar un nivel 4 significa editar este mismo párrafo anidado
```

Este párrafo tiene que conocer los umbrales de los tres niveles a la vez, y
cualquier otro lugar del programa que necesite la misma lógica de
escalamiento termina copiando el mismo anidamiento de `if`.

## Así queda con Chain of Responsibility aplicado

Mirá [`chain_of_responsibility.cbl`](chain_of_responsibility.cbl) de esta
carpeta: `support-handler` (línea 9) define `handle` (línea 40) una sola
vez — si `"can-handle"` (línea 26, base que no resuelve nada) devuelve 1,
invoca `"resolve"` (línea 48); si no, delega en `next-handler` (línea 51).
Cada nivel (`level1-support`, línea 63; `level2-support`, línea 87;
`level3-support`, línea 111) **hereda** de `support-handler` con
`inherits` y solo sobreescribe `can-handle` y `resolve` con su propio
umbral, sin saber nada de los demás niveles.

El párrafo principal (línea 150) arma la cadena con `"set-next"` (líneas
155-156): `level1 "set-next" using level2`, `level2 "set-next" using
level3`. Después solo invoca `level1 "handle"` (líneas 159-162); cada
handler decide solo si le toca a él o lo pasa al siguiente. Agregar un
`level4-support` es una clase nueva y una invocación más en la cadena —
cero cambios en `handle`.
