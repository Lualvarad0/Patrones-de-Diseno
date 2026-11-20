# Adapter

**Categoría:** Estructural

## Problema

Tu app dibuja una lista de figuras llamando a `.Draw()` en cada una. Ahora
necesitás integrar `LegacyRectangle`, una clase de una librería de terceros
con una firma completamente distinta (`OldDraw(x1, y1, x2, y2)`, sin el
método `Draw()` que tu código espera, y no podés modificarla porque viene
de afuera). La solución rápida es meter un `if`/`instanceof` especial en el
bucle de dibujo cada vez que aparece un tipo incompatible — y volver a
tocar ese mismo bucle cada vez que sumás una librería más con otra figura
rara.

## Solución

Creas una clase intermedia, el **adaptador**, que implementa la interfaz
que tu código espera y, por dentro, delega las llamadas traduciéndolas a
la interfaz real del objeto adaptado. Es literalmente un adaptador de
corriente: no cambia el enchufe original, solo lo hace compatible.

## Cuándo usarlo

- Integrar una librería de terceros con una interfaz distinta a la que usa
  el resto de tu aplicación.
- Hacer que código legado funcione con una interfaz nueva sin reescribirlo.

## Cuándo NO usarlo

- Si puedes simplemente cambiar la interfaz de la clase original sin romper
  nada, hazlo — el adapter añade una capa de indirección que no siempre
  hace falta.

## Dónde lo vas a encontrar en la vida real

- El ejemplo más literal: un adaptador de corriente o de USB-C a HDMI — no
  cambia ninguno de los dos lados, solo los hace compatibles.
- `Arrays.asList()` en Java: adapta un array nativo para que se pueda usar
  donde se espera una `List`.
- Integrar dos pasarelas de pago (Stripe y PayPal) detrás de una sola
  interfaz `PaymentGateway` en tu app, aunque cada SDK cobre distinto por
  dentro.
- `InputStreamReader` en Java: adapta un flujo de bytes (`InputStream`) a uno
  de caracteres (`Reader`).

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
