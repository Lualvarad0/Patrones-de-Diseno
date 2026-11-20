# Adapter en COBOL

## El problema, en código

Tu sistema dibuja una lista de figuras invocando `"draw"` en cada una. Ahora
necesitás integrar `legacy-rectangle`, una clase de un módulo de terceros
con un método completamente distinto (`"old-draw"`, que recibe cuatro
coordenadas separadas en vez de nada). La solución rápida es meter un caso
especial en el párrafo de dibujo:

```cobol
if tipo-de-figura = "LEGACY"
    invoke legacy-rectangle-ref "old-draw" using 0 0 10 20
else
    invoke figura-ref "draw"
end-if
*> y si mañana sumás otro módulo con otra figura incompatible, otro "if" más
```

El párrafo de dibujo, que debería ser genérico, ahora conoce los detalles
de un módulo externo puntual. Si integrás otro módulo con otra figura rara,
tenés que volver a tocar este mismo párrafo (y cualquier otro lugar del
código que dibuje figuras) para agregarle otro caso especial más.

## Así queda con Adapter aplicado

Mirá [`adapter.cbl`](adapter.cbl) de esta carpeta: la clase
`rectangle-adapter` (línea 29) expone el método `draw` (línea 63) — la
forma que ya espera tu código — y guarda adentro la referencia a
`legacy-rectangle` junto con las coordenadas que necesita, seteadas una
sola vez en `init` (líneas 47-60). El método `draw` simplemente traduce la
llamada: `invoke stored-legacy "old-draw" using stored-x1 stored-y1
stored-x2 stored-y2` (líneas 65-66).

El párrafo principal (línea 91) invoca `"draw"` sobre el adaptador sin
ningún `if` especial — es indistinguible de invocar `"draw"` sobre
cualquier otra figura que ya hable ese idioma. `legacy-rectangle` en sí no
se tocó ni una línea.
