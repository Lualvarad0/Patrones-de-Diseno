# Observer

**Categoría:** Comportamiento

## Problema

Un objeto (el "sujeto") cambia de estado y **varios otros objetos**
necesitan enterarse y reaccionar (actualizar una UI, loguear, enviar una
notificación), pero no quieres que el sujeto conozca las clases concretas
de todos sus interesados ni los llame uno por uno a mano cada vez.

## Solución

Los interesados ("observadores") se **suscriben** al sujeto implementando
una interfaz común (`notificar(evento)`). El sujeto mantiene una lista de
observadores suscritos y, cuando cambia, simplemente recorre la lista y
llama a `notificar()` en cada uno, sin saber (ni importarle) qué hace cada
observador con esa información.

## Cuándo usarlo

- Cuando el cambio de un objeto debe disparar efectos en un número variable
  y desconocido de otros objetos (eventos de UI, pub/sub, sistemas
  reactivos).

## Cuidado con

- Fugas de memoria si los observadores no se desuscriben cuando ya no se
  necesitan (muy común en listeners de UI de larga vida).
- El orden de notificación no suele estar garantizado — no diseñes lógica
  que dependa de "quién se entera primero".

## Dónde lo vas a encontrar en la vida real

- `addEventListener` en el navegador: toda la Web está armada sobre este
  patrón — un botón "notifica" a quien se haya suscrito a su evento `click`.
- El `EventEmitter` de Node.js, usado por dentro de streams, servidores HTTP
  y un montón de librerías.
- Los sistemas reactivos como RxJS, o cómo React/Vue vuelven a renderizar un
  componente automáticamente cuando cambia el estado del que depende.
- Suscribirte a un canal de YouTube o a una newsletter: te avisan cada vez
  que hay contenido nuevo, sin que vos tengas que estar preguntando todo el
  tiempo.

## En este repositorio

Implementado en: C#, Java, JavaScript, Rust, C++, PHP, COBOL.
