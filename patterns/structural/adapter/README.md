# Adapter

**Categoría:** Estructural

## Problema

Tienes una clase existente (propia o de una librería externa) cuya
interfaz **no es compatible** con la que tu código espera, y no puedes (o
no quieres) modificarla directamente.

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
